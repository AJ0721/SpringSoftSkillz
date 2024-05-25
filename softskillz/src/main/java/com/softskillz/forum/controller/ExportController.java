package com.softskillz.forum.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.softskillz.forum.model.dto.ForumThreadDto;
import com.softskillz.forum.model.service.ExportService;
import com.softskillz.forum.model.service.IForumThreadService;

@RestController
@RequestMapping("/api/export")
public class ExportController {

    @Autowired
    private IForumThreadService threadService;

    @Autowired
    private ExportService exportService;


    @GetMapping("/threads/json")
    public ResponseEntity<String> exportThreadsToJson() throws IOException {
        List<ForumThreadDto> threads = threadService.findAllThreads();
        String json = exportService.exportToJson(threads);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=threads.json")
                .contentType(MediaType.APPLICATION_JSON)
                .body(json);
    }

    @GetMapping("/threads/excel")
    public ResponseEntity<InputStreamResource> exportThreadsToExcel() throws IOException {
        List<ForumThreadDto> threads = threadService.findAllThreads();
        ByteArrayInputStream in = exportService.exportToExcel(threads);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=threads.xlsx")
                .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                .body(new InputStreamResource(in));
    }
}
