package com.softskillz.forum.model;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface IDtoConverter {

	IDtoConverter INSTANCE = Mappers.getMapper(IDtoConverter.class);

	// category

	ForumCategoryDto toForumCategoryDTO(ForumCategoryModel categoryModel);

	@Mapping(target = "forumThreads", ignore = true)
	ForumCategoryModel toForumCategoryModel(ForumCategoryDto categoryDTO);

	// thread
	@Mapping(source = "adminBean.adminId", target = "adminId")
	@Mapping(source = "forumCategoryModel.forumCategoryId", target = "forumCategoryId")
	@Mapping(source = "studentBean.studentId", target = "studentId")
	@Mapping(source = "teacherBean.teacherId", target = "teacherId")
	ForumThreadDto toForumThreadDto(ForumThreadModel forumThreadModel);

	@Mapping(target = "studentBean", ignore = true)
    @Mapping(target = "teacherBean", ignore = true)
	@Mapping(source = "forumCategoryId", target = "forumCategoryModel.forumCategoryId")
	@Mapping(source = "studentId", target = "studentBean.studentId") //attribute if id=null don't create a new student
	@Mapping(source = "teacherId", target = "teacherBean.teacherId")
	@Mapping(source = "adminId", target = "adminBean.adminId")
	@Mapping(target = "forumImageModel", ignore = true)
	@Mapping(target = "forumPostModel", ignore = true)
	 ForumThreadModel toForumThreadModel(ForumThreadDto forumThreadDto);
	
/*	
	default ForumThreadModel resolveStudentTeacher(ForumThreadDto threadDto, ForumThreadModel model) {
        if (threadDto.getStudentId() != null) {
            StudentBean student = new StudentBean();  // Suppose you have a method to fetch StudentBean
            student.setStudentId(threadDto.getStudentId());
            model.setStudentBean(student);
        }
        if (threadDto.getTeacherId() != null) {
            TeacherBean teacher = new TeacherBean();  // Suppose you have a method to fetch TeacherBean
            teacher.setTeacherId(threadDto.getTeacherId());
            model.setTeacherBean(teacher);
        }
        return model;
    }
	
	*/
	
	
	// post

}
