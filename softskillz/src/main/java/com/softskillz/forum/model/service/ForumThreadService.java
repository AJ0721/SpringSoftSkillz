package com.softskillz.forum.model.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.forum.model.dto.ForumThreadDto;
import com.softskillz.forum.model.dto.IDtoConverter;
import com.softskillz.forum.model.model.ForumThreadModel;
import com.softskillz.forum.model.repository.ForumThreadRepository;

import jakarta.persistence.EntityNotFoundException;

@Service
@Transactional
public class ForumThreadService implements IForumThreadService {

	@Autowired
	private ForumThreadRepository forumThreadRepository;

	// insert
	@Override
	public ForumThreadDto insertForumThread(ForumThreadDto threadDto) {
		
		
		ForumThreadModel forumThread = IDtoConverter.INSTANCE.toForumThreadModel(threadDto);
		
		//workaround: check if id is null
		//test
		if( threadDto.getStudentId() == null) {
			forumThread.setStudentBean(null);
		}
		if( threadDto.getTeacherId() == null) {
			forumThread.setTeacherBean(null);
		}
		if( threadDto.getAdminId() == null) {
			forumThread.setAdminBean(null);
		}
		
		
		ForumThreadModel savedThread = forumThreadRepository.save(forumThread);
		return IDtoConverter.INSTANCE.toForumThreadDto(savedThread);

	}

	// update
	@Override
	public ForumThreadDto updateForumThreadById(Integer threadId, ForumThreadDto threadDto) {
		Optional<ForumThreadModel> existingThread = forumThreadRepository.findById(threadId);
		if (existingThread.isPresent()) {
			ForumThreadModel updatedThread = existingThread.get();
			updatedThread.setThreadTitle(threadDto.getThreadTitle());
			updatedThread.setThreadContent(threadDto.getThreadContent());
			updatedThread.setThreadStatus(threadDto.getThreadStatus());

			forumThreadRepository.save(updatedThread);
			return IDtoConverter.INSTANCE.toForumThreadDto(updatedThread);
		} else {
			throw new EntityNotFoundException("Thread not found with id: " + threadId);
		}
	}

	// Delete
	@Override
	public void deleteForumThreadById(Integer threadId) {
		if (!forumThreadRepository.existsById(threadId)) {
			throw new EntityNotFoundException("Thread ID not found: " + threadId);
		}
		forumThreadRepository.deleteById(threadId);
	}

	@Override
	public void deleteAllForumThreads(List<Integer> threadIds) {

		if (threadIds == null || threadIds.isEmpty()) {
			throw new IllegalArgumentException("No thread IDs provided for deletion.");
		}

		threadIds.forEach(id -> {
	        if (!forumThreadRepository.existsById(id)) {
	            throw new EntityNotFoundException("Thread ID not found: " + id);
	        }
	    });
	    forumThreadRepository.deleteAllByIdInBatch(threadIds);
	}

	// Read all threads
	@Override
	public List<ForumThreadDto> findAllThreads() {
		List<ForumThreadModel> threads = forumThreadRepository.findAll();
		return threads.stream()
				.map(IDtoConverter.INSTANCE::toForumThreadDto)
				.collect(Collectors.toList());
	}

	// Find threads by keyword
	@Override
	public List<ForumThreadDto> findThreadsByKeyword(String keyword) {
		List<ForumThreadModel> threads = forumThreadRepository.findThreadsByKeyword(keyword);
		return threads.stream().map(IDtoConverter.INSTANCE::toForumThreadDto).collect(Collectors.toList());
	}

	// Get thread by thread ID
	@Override
	public ForumThreadDto findThreadByThreadId(Integer threadId) {
		ForumThreadModel thread = forumThreadRepository.findById(threadId)
				.orElseThrow(() -> new EntityNotFoundException("Thread not found with id: " + threadId));
		return IDtoConverter.INSTANCE.toForumThreadDto(thread);
	}

	// Get threads by teacher ID
	@Override
	public List<ForumThreadDto> findThreadsByTeacherId(Integer teacherId) {
		List<ForumThreadModel> threads = forumThreadRepository.findByTeacherBeanTeacherId(teacherId);
		return threads.stream().map(IDtoConverter.INSTANCE::toForumThreadDto).collect(Collectors.toList());
	}

	// Get threads by student ID
	@Override
	public List<ForumThreadDto> findThreadsByStudentId(Integer studentId) {
		List<ForumThreadModel> threads = forumThreadRepository.findByStudentBeanStudentId(studentId);
		return threads.stream().map(IDtoConverter.INSTANCE::toForumThreadDto).collect(Collectors.toList());
	}

}
