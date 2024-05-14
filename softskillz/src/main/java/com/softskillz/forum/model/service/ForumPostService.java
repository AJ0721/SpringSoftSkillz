package com.softskillz.forum.model.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.mapstruct.Mapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.AdminBean;
import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.account.model.repository.AdminRepository;
import com.softskillz.account.model.repository.StudentRepository;
import com.softskillz.account.model.repository.TeacherRepository;
import com.softskillz.forum.model.StatusEnum;
import com.softskillz.forum.model.UserEnum;
import com.softskillz.forum.model.dto.ForumPostDto;
import com.softskillz.forum.model.dto.ForumThreadDto;
import com.softskillz.forum.model.dto.IDtoConverter;
import com.softskillz.forum.model.model.ForumPostModel;
import com.softskillz.forum.model.model.ForumThreadModel;
import com.softskillz.forum.model.repository.ForumPostRepository;
import com.softskillz.forum.model.repository.ForumThreadRepository;
import com.softskillz.util.FindUserIdUtils;

import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class ForumPostService implements IForumPostService {
	@Autowired
	ForumPostRepository forumPostRepository;
	@Autowired
	ForumThreadRepository forumThreadRepository;

	@Override
	public ForumPostDto insertForumPost(ForumPostDto postDto) {
		// workaround: check if id is null

		ForumPostModel forumPost = IDtoConverter.INSTANCE.toForumPostModel(postDto);

//save users (student/teacher/admin)

		if (postDto.getStudent() == null) {
			forumPost.setStudentBean(null);
		}
		if (postDto.getTeacher() == null) {
			forumPost.setTeacherBean(null);
		}
		if (postDto.getAdmin() == null) {
			forumPost.setAdminBean(null);
		}

// save thread model
		ForumThreadModel forumThread = forumThreadRepository.findById(postDto.getThread().getThreadId())
				.orElseThrow(() -> new RuntimeException("Thread not found:"));

		forumPost.setForumThreadModel(forumThread);

//save parent post model

		if (postDto.getParentPost() != null) {
			ForumPostModel parentPost = forumPostRepository.findById(postDto.getParentPost().getPostId())
					.orElseThrow(() -> new RuntimeException("Parent post not found"));
			forumPost.setForumPostModel(parentPost);
		} else {
			forumPost.setForumPostModel(null); // Explicitly set to null if no parent
		}

		ForumPostModel savedPost = forumPostRepository.save(forumPost);
		return IDtoConverter.INSTANCE.toForumPostDto(savedPost);

	}

	@Override
	public ForumPostDto updateForumPostById(ForumPostDto postDto, Integer postId) {

		ForumPostModel existingPostModel = forumPostRepository.findById(postId)
				.orElseThrow(() -> new EntityNotFoundException("Invalid post ID: " + postId));

		existingPostModel.setPostContent(postDto.getPostContent());

		ForumPostModel updatedPostModel = forumPostRepository.save(existingPostModel);
		return IDtoConverter.INSTANCE.toForumPostDto(updatedPostModel);

	}

	@Override
	public StatusEnum updateForumPostStatus(Integer postId, @RequestParam("status") StatusEnum newStatus) {
		ForumPostModel existingPost = forumPostRepository.findById(postId)
				.orElseThrow(() -> new EntityNotFoundException());

		existingPost.setPostStatus(newStatus);
		ForumPostModel updatedPost = forumPostRepository.save(existingPost);

		return updatedPost.getPostStatus();
	}

	@Override
	public void deleteForumPostById(Integer postId) {
		if (!forumPostRepository.existsById(postId)) {
			throw new EntityNotFoundException("Post ID not found: " + postId);
		}
		forumPostRepository.deleteById(postId);

	}

	@Override
	public void deleteAllForumPost(List<Integer> postIds) {
		if (postIds == null || postIds.isEmpty()) {
			throw new IllegalArgumentException("Null. No thread IDs provided for deletion.");
		}

		for (Integer id : postIds) {
			if (!forumPostRepository.existsById(id)) {
				throw new EntityNotFoundException("Post ID not found: " + id);
			}
		}

		forumPostRepository.deleteAllByIdInBatch(postIds);
	}

	@Override
	public ForumPostDto findPostById(Integer postId) {
		ForumPostModel postModel = forumPostRepository.findById(postId)
				.orElseThrow(() -> new EntityNotFoundException());

		ForumPostDto postDto = IDtoConverter.INSTANCE.toForumPostDto(postModel);
		return postDto;
	}

	@Override
	public List<ForumPostDto> findAllPosts() {
		List<ForumPostModel> posts = forumPostRepository.findAll();

		return posts.stream().map(IDtoConverter.INSTANCE::toForumPostDto).collect(Collectors.toList());
	}

	@Override
	public List<ForumPostDto> findPostsByTeacherId(Integer teacherId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ForumPostDto> findPostsByStudentId(Integer studentId) {
		// TODO Auto-generated method stub
		return null;
	}

}
