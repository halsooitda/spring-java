package com.myweb.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Setter
@Getter
public class FileVO {
	public String uuid;
	public String saveDir;
	public String fileName;
	public int fileType;
	public long bno;
	public long fileSize;
	public String regAt;
	
}
