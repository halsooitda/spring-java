package com.myweb.www.handler;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.tika.Tika;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.myweb.www.domain.FileVO;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@Component
public class FileHandler {
	private final String UP_DIR = "D:\\_myweb\\_java\\fileupload";
	
	public List<FileVO> uploadFiles(MultipartFile[] files){
		List<FileVO> flist = new ArrayList<>();
		
		//파일경로, fvo세팅, 파일저장 ... 
		//날짜를 폴더로 생성하여 그날그날 업로드 파일을 관리
		LocalDate date = LocalDate.now(); //LocalDate 객체로 오늘 날짜 생성
		String today = date.toString(); //2023-10-24
		today = today.replace("-", File.separator); //2023\10\24(window) 2023/10/24(linux, mac)
		
		//D:\\_myweb\\_java\\fileupload\\2023\\10\\24
		File folders = new File(UP_DIR, today);
		//폴더 생성
		if(!folders.exists()) { //폴더가 없다면 폴더 생성
			//mkdir = 폴더 한개 생성, mkdirs = 폴더 여러개 생성
			folders.mkdirs();
		}
		
		//files 객체에 대한 설정 
		for(MultipartFile file : files) { //들어온 첨부파일 중 1개씩 for문 처리
			FileVO fvo = new FileVO();
			fvo.setSaveDir(today); 
			fvo.setFileSize(file.getSize());
			
			String originalFileName = file.getOriginalFilename(); //실제 파일명(파일 경로를 포함하고 있을 수 있음)
			String fileName = //경로 제외 실제 파일명만 추출
					originalFileName.substring(originalFileName.lastIndexOf(File.separator)+1);
			fvo.setFileName(fileName);
			
			UUID uuid = UUID.randomUUID();
			fvo.setUuid(uuid.toString());
			//기본 FileVO 생성 완료-------------------------------------------------------------------	
			
			//하단부터 디스크에 저장할 파일 객체 생성
			//파일이름 uuid_fileName / uuid_th_fileName
			String fullFileName = uuid.toString()+"_"+fileName;
			File storeFile = new File(folders, fullFileName); //해당 폴더 안에 해당 객체를 생성해라
			//File 객체가 저장이 되려면 첫 경로부터 다 설정이 되어있어야 함.
			//D:\\_myweb\\_java\\fileupload\\2023\\10\\24\\uuid_fileName.jpg
			
			try {
				file.transferTo(storeFile); //저장
				//썸네일 생성 => 이미지 파일만 썸네일 생성
				//이미지 파일인지 확인
				if(isImageFile(storeFile)) {
					fvo.setFileType(1); //이미지 파일 맞음 = 1
					//썸네일 생성
					File thumbNail = new File(folders, uuid.toString()+"_th_"+fileName);
					Thumbnails.of(storeFile).size(60, 60).toFile(thumbNail);
				}
				
			} catch (Exception e) {
				log.debug(">>>>> file 생성 오류!!!"); //빨간 글씨로 뜸
				e.printStackTrace();
			}
			
			//flist에 fvo추가
			flist.add(fvo);
			
		}//for문 끝

		return flist;
	}
	
	//이미지인지 아닌지 확인하는 메서드
	private boolean isImageFile(File storeFile) throws IOException {
		String mimeType = new Tika().detect(storeFile); //image/jpg 이런식으로 들어옴
		return mimeType.startsWith("image")? true : false; //해당 글자의 첫번째가 이미지인지 아닌지
	}
	
}