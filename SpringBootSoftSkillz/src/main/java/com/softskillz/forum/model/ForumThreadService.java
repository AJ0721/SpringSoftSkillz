package com.softskillz.forum.model;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.EntityNotFoundException;

@Service
@Transactional
public class ForumThreadService implements IForumThreadService {

	@Autowired
	private ForumThreadRepository forumThreadRepository;

	// insert
	public ForumThreadDto insertForumThread(ForumThreadDto threadDto) {
		
		
		ForumThreadModel forumThread = IDtoConverter.INSTANCE.toForumThreadModel(threadDto);
		ForumThreadModel savedThread = forumThreadRepository.save(forumThread);
		return IDtoConverter.INSTANCE.toForumThreadDto(savedThread);

	}

	// update
	public ForumThreadDto updateForumThreadById(int threadId, ForumThreadDto threadDto) {
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
	public void deleteForumThreadById(Integer threadId) {
		if (!forumThreadRepository.existsById(threadId)) {
			throw new EntityNotFoundException("Thread ID not found: " + threadId);
		}
		forumThreadRepository.deleteById(threadId);
	}

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
	public List<ForumThreadDto> findAllThreads() {
		List<ForumThreadModel> threads = forumThreadRepository.findAll();
		return threads.stream()
				.map(IDtoConverter.INSTANCE::toForumThreadDto)
				.collect(Collectors.toList());
	}

	// Find threads by keyword
	public List<ForumThreadDto> findThreadsByKeyword(String keyword) {
		List<ForumThreadModel> threads = forumThreadRepository.findThreadsByKeyword(keyword);
		return threads.stream().map(IDtoConverter.INSTANCE::toForumThreadDto).collect(Collectors.toList());
	}

	// Get thread by thread ID
	public ForumThreadDto findThreadByThreadId(int threadId) {
		ForumThreadModel thread = forumThreadRepository.findById(threadId)
				.orElseThrow(() -> new EntityNotFoundException("Thread not found with id: " + threadId));
		return IDtoConverter.INSTANCE.toForumThreadDto(thread);
	}

	// Get threads by teacher ID
	public List<ForumThreadDto> findThreadsByTeacherId(Integer teacherId) {
		List<ForumThreadModel> threads = forumThreadRepository.findByTeacherBeanTeacherId(teacherId);
		return threads.stream().map(IDtoConverter.INSTANCE::toForumThreadDto).collect(Collectors.toList());
	}

	// Get threads by student ID
	public List<ForumThreadDto> findThreadsByStudentId(Integer studentId) {
		List<ForumThreadModel> threads = forumThreadRepository.findByStudentBeanStudentId(studentId);
		return threads.stream().map(IDtoConverter.INSTANCE::toForumThreadDto).collect(Collectors.toList());
	}

}