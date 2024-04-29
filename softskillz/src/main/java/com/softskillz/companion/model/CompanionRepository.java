package com.softskillz.companion.model;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CompanionRepository extends JpaRepository<CompanionBean, Integer> {
	public Optional<CompanionBean> findBycompanionUsername(String companionUsername);

	@Query("SELECT c FROM CompanionBean c WHERE c.companionLearningInterest = :interest AND c.companionUsername != :username")
	List<CompanionBean> findByLearningInterestAndUsername(@Param("interest") String interest, @Param("username") String username);
}
