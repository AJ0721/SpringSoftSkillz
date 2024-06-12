package com.softskillz.forum.model.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.forum.model.StatusEnum;
import com.softskillz.forum.model.dto.ForumThreadDto;
import com.softskillz.forum.model.dto.IDtoConverter;
import com.softskillz.forum.model.model.ForumPostModel;
import com.softskillz.forum.model.model.ForumThreadModel;
import com.softskillz.forum.model.repository.ForumPostRepository;
import com.softskillz.forum.model.repository.ForumThreadRepository;

import jakarta.persistence.EntityNotFoundException;

@Service
@Transactional
public class ForumThreadService implements IForumThreadService {

	@Autowired
	private ForumThreadRepository forumThreadRepository;
	@Autowired
	private ForumPostRepository forumPostRepository;

	// insert
	@Override
	public ForumThreadDto insertForumThread(ForumThreadDto threadDto) {

		ForumThreadModel forumThread = IDtoConverter.INSTANCE.toForumThreadModel(threadDto);

		// workaround: check if id is null
		if (threadDto.getStudent() == null) {
			forumThread.setStudentBean(null);
		}
		if (threadDto.getTeacher() == null) {
			forumThread.setTeacherBean(null);
		}
		if (threadDto.getAdmin() == null) {
			forumThread.setAdminBean(null);
		}

		ForumThreadModel savedThread = forumThreadRepository.save(forumThread);
		return IDtoConverter.INSTANCE.toForumThreadDto(savedThread);

	}

	// update
	@Override
	public ForumThreadDto updateForumThreadById(Integer threadId, ForumThreadDto threadDto) {
		ForumThreadModel existingThread = forumThreadRepository.findById(threadId)
				.orElseThrow(() -> new EntityNotFoundException("Invalid thread ID:" + threadId));

		existingThread.setThreadTitle(threadDto.getThreadTitle());
		existingThread.setThreadContent(threadDto.getThreadContent());

		ForumThreadModel updatedThread = forumThreadRepository.save(existingThread);
		return IDtoConverter.INSTANCE.toForumThreadDto(updatedThread);

	}

	// update status
	public StatusEnum updateForumThreadStatus(Integer threadId, StatusEnum newStatus) {
		ForumThreadModel existingThread = forumThreadRepository.findById(threadId)
				.orElseThrow(() -> new EntityNotFoundException("Thread not found with id: " + threadId));
		existingThread.setThreadStatus(newStatus);
		ForumThreadModel updatedThread = forumThreadRepository.save(existingThread);
		return updatedThread.getThreadStatus();
	}

	// Delete
	@Override
	public void softDeleteForumThreadById(Integer threadId) {
		ForumThreadModel thread = forumThreadRepository.findById(threadId)
				.orElseThrow(() -> new EntityNotFoundException("Invalid thread ID:" + threadId));
		thread.setStatusDeleted();
		forumThreadRepository.save(thread);
		
		// Soft delete all posts under this thread
        List<ForumPostModel> posts = forumPostRepository.findPostsByThreadId(threadId);
        for (ForumPostModel post : posts) {
            post.setStatusDeleted();
            forumPostRepository.save(post);
        }
	}

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

		for (Integer id : threadIds) {
			if (!forumThreadRepository.existsById(id)) {
				throw new EntityNotFoundException("Thread ID not found: " + id);
			}
		}
		forumThreadRepository.deleteAllByIdInBatch(threadIds);
	}

	// Read all threads
	@Override //only find active threads
	public List<ForumThreadDto> findAllThreads() {
		List<ForumThreadModel> threads = forumThreadRepository.findAllActiveThreads();
		return threads.stream().map(IDtoConverter.INSTANCE::toForumThreadDto).collect(Collectors.toList());
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
				.orElseThrow(() -> new EntityNotFoundException("Invalid thread ID: " + threadId));

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

	//Get threads by category ID
	@Override
	public List<ForumThreadDto> findThreadsByCategory(Integer categoryId) {
		List<ForumThreadModel> threads = forumThreadRepository.findByForumCategoryModelForumCategoryId(categoryId);
		return threads.stream().map(IDtoConverter.INSTANCE::toForumThreadDto).collect(Collectors.toList());
	}

}
