// package com.softskillz.mall.controller;

// import java.io.IOException;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.http.HttpStatus;
// import org.springframework.http.ResponseEntity;
// import org.springframework.web.bind.annotation.PostMapping;
// import org.springframework.web.bind.annotation.RequestParam;
// import org.springframework.web.bind.annotation.RestController;
// import org.springframework.web.multipart.MultipartFile;

// 上傳圖片，有Error，未實現，待修改

// @RestController
// public class FileUploadController {

// @Autowired
// private FileStorageService fileStorageService;

// @PostMapping("/upload")
// public ResponseEntity<String> uploadFile(@RequestParam("file") MultipartFile
// file) {
// try {
// String fileName = fileStorageService.storeFile(file);
// return new ResponseEntity<>("檔案上傳成功: " + fileName, HttpStatus.OK);
// } catch (IOException ex) {
// return new ResponseEntity<>("檔案上傳失敗: " + ex.getMessage(),
// HttpStatus.INTERNAL_SERVER_ERROR);
// }
// }
// }
