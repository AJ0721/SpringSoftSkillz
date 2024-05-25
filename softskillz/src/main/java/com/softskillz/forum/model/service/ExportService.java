package com.softskillz.forum.model.service;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.softskillz.forum.model.dto.ForumThreadDto;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

@Service
public class ExportService {

    public ByteArrayInputStream exportToExcel(List<ForumThreadDto> threads) throws IOException {
        String[] columns = {"ID", "Title", "Content", "Author", "Time Created "};
        try (Workbook workbook = new XSSFWorkbook()) {
			ByteArrayOutputStream out = new ByteArrayOutputStream();

			Sheet sheet = workbook.createSheet("Threads");
			Row headerRow = sheet.createRow(0);

			for (int col = 0; col < columns.length; col++) {
			    Cell cell = headerRow.createCell(col);
			    cell.setCellValue(columns[col]);
			}

			int rowIdx = 1;
			for (ForumThreadDto thread : threads) {
			    Row row = sheet.createRow(rowIdx++);
			    row.createCell(0).setCellValue(thread.getThreadId());
			    row.createCell(1).setCellValue(thread.getThreadTitle());
			    row.createCell(2).setCellValue(thread.getThreadContent());
			    row.createCell(3).setCellValue(thread.getStudent() != null ? thread.getStudent().getStudentUsername() :
			                                  thread.getTeacher() != null ? thread.getTeacher().getTeacherUserName() :
			                                  thread.getAdmin() != null ? thread.getAdmin().getAdminAccount() : "N/A");
			    row.createCell(4).setCellValue(thread.getThreadCreatedTime().toString());
			}

			workbook.write(out);
			return new ByteArrayInputStream(out.toByteArray());
		}
    }

    public String exportToJson(List<ForumThreadDto> threads) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(threads);
    }
}
