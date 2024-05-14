package com.softskillz.forum.model.dto;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.forum.model.model.ForumCategoryModel;
import com.softskillz.forum.model.model.ForumPostModel;
import com.softskillz.forum.model.model.ForumThreadModel;

@Mapper
public interface IDtoConverter {

	IDtoConverter INSTANCE = Mappers.getMapper(IDtoConverter.class);

	// category

	ForumCategoryDto toForumCategoryDTO(ForumCategoryModel categoryModel);

	@Mapping(target = "forumThreads", ignore = true)
	ForumCategoryModel toForumCategoryModel(ForumCategoryDto categoryDTO);

	// thread
	//to full dto
	@Mapping(source = "forumCategoryModel", target = "forumCategory")
	@Mapping(source = "studentBean", target = "student")
	@Mapping(source = "teacherBean", target = "teacher")
	@Mapping(source = "adminBean", target = "admin")
	@Mapping(target = "threadIds", ignore = true)
	ForumThreadDto toForumThreadDto(ForumThreadModel forumThreadModel);

	
	//to model
	
	//to full model: insert
	@Mapping(source = "forumCategory.forumCategoryId", target = "forumCategoryModel.forumCategoryId")
    @Mapping(source = "student.studentId", target = "studentBean.studentId")
    @Mapping(source = "teacher.teacherId", target = "teacherBean.teacherId")
    @Mapping(source = "admin.adminId", target = "adminBean.adminId")
    ForumThreadModel toForumThreadModel(ForumThreadDto forumThreadDto);


    TeacherDto toTeacherDto(TeacherBean teacherBean);
    StudentDto toStudentDto(StudentBean studentBean);
	
	

	// post
	@Mapping(source = "adminBean", target = "admin")
	@Mapping(source = "studentBean", target = "student")
	@Mapping(source = "teacherBean", target = "teacher")
	@Mapping(source = "forumThreadModel", target="thread")
	@Mapping(source = "forumPostModel", target="parentPost")
	@Mapping(target = "postIds", ignore = true)
	ForumPostDto toForumPostDto(ForumPostModel forumPostModel);

	@Mapping(source = "student.studentId", target = "studentBean.studentId") // attribute if id=null don't create a new student
	@Mapping(source = "admin.adminId", target = "adminBean.adminId")
	@Mapping(source = "teacher.teacherId", target = "teacherBean.teacherId")
	@Mapping(source = "thread.threadId", target = "forumThreadModel.threadId")
	@Mapping(target = "forumImageModel", ignore = true)
	ForumPostModel toForumPostModel(ForumPostDto forumPostDto);

	
}
