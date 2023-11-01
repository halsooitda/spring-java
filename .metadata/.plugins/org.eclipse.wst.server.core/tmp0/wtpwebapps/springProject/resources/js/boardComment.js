console.log(">>"+bnoVal);

//1
async function postCommentToServer(cmtData){
    try{
        const url = "/comment/post";
        const config = {
            method : "post",
            headers : {
                'content-type' : 'application/json; charset=utf-8'
            },
            body : JSON.stringify(cmtData)
        };

        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;

    }catch(err){
        console.log(err);
    }
}

//2
document.getElementById('cmtPostBtn').addEventListener('click', ()=>{
    const cmtText = document.getElementById('cmtText').value;
    const cmtWriter = document.getElementById('cmtWriter').innerText; //span안에 있는 값을 가져올 때
    if(cmtText == "" || cmtText == null){
        alert('댓글을 입력해주세요.');
        document.getElementById('cmtText').focus();
        return false;
    }else {
        let cmtData = {
            bno : bnoVal,
            writer : cmtWriter,
            content : cmtText
        };
        console.log(cmtData);
        postCommentToServer(cmtData).then(result => {
            if(result == 1){
                alert('댓글 등록 성공');
                //댓글 등록 후 인풋 빈값으로 만들어주기
                document.getElementById('cmtText').value = '';
                //cmtText = '';하면 변수에 담긴 값이 바뀌는 거라서 안 먹음.
            }
            //화면에 뿌리기
            //5
            getCommentList(bnoVal);
        });
    }
})

//3
//paging을 위해 page추가
async function spreadCommentListFromServer(bno, page){
    try{
        const resp = await fetch('/comment/'+bno+'/'+page);
        const result = await resp.json();
        return result;

    }catch(err){
        console.log(err);
    }
}

//4
//paging > 무조건 처음 뿌릴 때는 첫페이지 값을 뿌려야 함.
function getCommentList(bno, page=1){
    spreadCommentListFromServer(bno, page).then(result => {
        console.log(result); //ph객체 : pgvo, totalCount, cmtList
        const ul = document.getElementById('cmtListArea'); //댓글 영역을 감싸는 ul
        if(result.cmtList.length > 0){ //댓글이 있다면
            //다시 댓글을 뿌릴 때 기존 값 삭제 1page일 경우만
            if(page == 1){
                ul.innerHTML = ""; //jsp에 임시로 넣어둔 댓글 표시영역을 지우고, 비어있는 값으로 바꿔버리기
            }
            for(let cvo of result.cmtList){
                let str = `<li class="list-group-item" data-cno="${cvo.cno}">`;
                str += `<div>`;
                str += `<div class="fw-bold">${cvo.writer} <span class="badge rounded-pill text-bg-secondary">${cvo.regAt}</span></div>`;
                str += `<div class="cvoContent">${cvo.content}</div>`;
            
                if(cvo.writer == id){    
                    str += `<button type="button" class="modBtn btn btn-success" data-bs-toggle="modal" data-bs-target="#myModal">수정</button>`;
                    str += `<button type="button" class="delBtn btn btn-danger">삭제</button>`;
                }

                str += `</div></li></ul>`;

                ul.innerHTML += str;
            }
        }else{
            let str = `<li>Comment List Empty</li>`;
            ul.innerHTML = str;
        }

        //댓글 페이징 코드
        let moreBtn = document.getElementById('moreBtn');
        console.log(moreBtn);
        //DB에서 pgvo + list 같이 가져와야 값을 줄 수 있음.
        if(result.pgvo.pageNo < result.endPage){
            moreBtn.style.visibility = 'visible'; //다시 나타냄
            moreBtn.dataset.page = page + 1;
        }else{
            moreBtn.style.visibility = 'hidden';
        }
    })
}

//5 삭제
async function removeCommentToServer(cno){
    try{
        const url = '/comment/'+cno;
        const config = {
            method : 'delete'
        };

        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;

    }catch(err){
        console.log(err);
    }
}

//6 수정/삭제 버튼 눌렀을 시
document.addEventListener('click',(e)=>{
    if(e.target.classList.contains('delBtn')){
        console.log('삭제 버튼 클릭');
        let li = e.target.closest('li');
        let cnoVal = li.dataset.cno;
        
        removeCommentToServer(cnoVal).then(result =>{
            if(result == 1){
                alert('댓글 삭제 성공');
            }
            getCommentList(bnoVal);
        })
        
    }else if(e.target.classList.contains('modBtn')){
        let li = e.target.closest('li');
        //nextSibling() : 같은 부모의 다음 형제 객체를 반환 => ${cvo.content}
        let cmtText = li.querySelector('.fw-bold').nextSibling;
        console.log(cmtText);
        //기존 내용 모달창에 반영(수정하기 편하게)
        document.getElementById('cmtTextMod').value = cmtText.innerText; //value는 input태그에만 사용
        //nodeValue = innerText
        //cmtModBtn에 data-cno 달기
        document.getElementById('cmtModBtn').setAttribute('data-cno', li.dataset.cno);


    }else if(e.target.id == 'cmtModBtn'){
        let cmtDataMod = {
            cno : e.target.dataset.cno,
            content : document.getElementById('cmtTextMod').value
        };
        console.log(cmtDataMod);

        editCommentToServer(cmtDataMod).then(result => {
            if(parseInt(result)){
                //모달창 닫기
                document.querySelector('.btn-close').click(); //닫기 버튼을 클릭해서 닫기
                alert('댓글 수정 성공');
            }
            getCommentList(bnoVal);
        })
    }else if(e.target.id == 'moreBtn'){
        getCommentList(bnoVal, parseInt(e.target.dataset.page));
    }



})

//7 수정
async function editCommentToServer(cmtDataMod){
    try{
        const url = '/comment/'+cmtDataMod.cno;
        const config = {
            method : 'put',
            headers : {
                'Content-Type' : 'application/json; charset=utf-8'
            },
            body : JSON.stringify(cmtDataMod)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;

    }catch(err){
        console.log(err);
    }
}

