package com.softskillz.companion.model;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CompanionRepository extends JpaRepository<CompanionBean, Integer> {
	@Query("SELECT c FROM CompanionBean c JOIN c.studentBeanID s WHERE s.studentNickname = :nickname")
	public Optional<CompanionBean> findBycompanionUsername(@Param("nickname")String studentNickname);

	@Query("SELECT c FROM CompanionBean c " +
		       "JOIN c.studentBeanID s " +
		       "WHERE (c.companionLearningInterest = :interest OR :interest = '') " +
		       "AND (s.studentGender = :gender OR :gender = '') " +
		       "AND (c.companionFirstLanguage = :firstLanguage OR :firstLanguage = '') " +
		       "AND (c.companionSpeakingLanguage = :speakingLanguage OR :speakingLanguage = '') " +
		       "AND (c.companionLearningFrequency = :learningFrequency OR :learningFrequency = '') " +
		       "AND s.studentNickname != :username ")
	List<CompanionBean> findByMatchRequirement(@Param("interest") String interest, @Param("gender") String gender,
			@Param("firstLanguage") String firstLanguage, @Param("speakingLanguage") String speakingLanguage,
			@Param("learningFrequency") String learningFrequency, @Param("username") String username);
	

}
