package com.softskillz.courseorder.model.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.courseorder.model.bean.CorderBean;

public interface CourseOrderReporistory extends JpaRepository<CorderBean, String> {

	@Modifying(flushAutomatically = true)
	@Query("update CorderBean o set o.status = '處理中' where o.orderID=:oid  AND (o.status = '已付款' or o.status = '未付款') ")
	Integer cancelORD(@Param("oid") String oid);

	List<CorderBean> findByStudentID(Integer studentID);

	@Modifying(flushAutomatically = true)
	@Query("update CorderBean o set o.status = :ss where o.orderID=:oid ")
	Integer adminUpdateORD(@Param("oid") String oid, @Param("ss") String status);

	@Query("from CorderBean o where o.orderDate >= :date1 AND o.orderDate < :date2")
	List<CorderBean> getOrderByDate(@Param("date1") Date date1, @Param("date2") Date date2);

	@Modifying(flushAutomatically = true)
	@Query("update CorderBean o set o.status = :ss , o.method = :mm where o.orderID=:oid ")
	Integer updateStatus(@Param("oid") String oid, @Param("ss") String status, @Param("mm") String mm);

	@Modifying(flushAutomatically = true)
	@Query("update CorderBean o set o.status = :ss where o.cancelDate < :date and o.status = '未付款'")
	@Transactional
	Integer updateOverdueOrder(@Param("date") Date date ,@Param("ss") String status );
	
	@Query("from CorderBean o where o.orderDate < o.cancelDate and o.status = :ss" )
	List<CorderBean> findNoOverdueOrder(@Param("ss") String status);
	
	
	@Query("from CorderBean o where o.orderDate >= :date1 AND o.orderDate <= :date2")
	Page<CorderBean> getPageOrderByDate(@Param("date1") Date date1, @Param("date2") Date date2,Pageable pageable);
}
