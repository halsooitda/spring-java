package com.myweb.www.repository;

import java.util.List;

import com.myweb.www.domain.FileVO;

public interface FileDAO {

	int insertFile(FileVO fvo);

	List<FileVO> getFileList(long bno);

	int removeFile(String uuid);

	int boardFileCount(long bno);

	int deleteAll(long bno);

	List<FileVO> selectListAllFiles();

}
