// package com.softskillz.mall.service;

// import java.io.IOException;
// import java.nio.file.Files;
// import java.nio.file.Path;
// import java.nio.file.Paths;

// import org.springframework.beans.factory.annotation.Value;
// import org.springframework.stereotype.Service;
// import org.springframework.util.StringUtils;
// import org.springframework.web.multipart.MultipartFile;

// @Service
// public class FileStorageService {

// @Value("${file.upload-dir}")
// private String uploadDir;

// public String storeFile(MultipartFile file) throws IOException {
// String fileName = StringUtils.cleanPath(file.getOriginalFilename());

// if (file.isEmpty()) {
// throw new IOException("檔案是空的");
// }

// if (fileName.contains("..")) {
// throw new IOException("無效的檔案路徑");
// }

// Path fileStorageLocation = Paths.get(uploadDir);
// try {
// Files.copy(file.getInputStream(), fileStorageLocation.resolve(fileName));
// } catch (IOException ex) {
// throw new IOException("無法儲存檔案 " + fileName + "。請再試一次！", ex);
// }

// return fileName;
// }
// }
