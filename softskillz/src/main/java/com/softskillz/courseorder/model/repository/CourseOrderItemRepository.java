package com.softskillz.courseorder.model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.softskillz.courseorder.model.bean.ItemBean;

public interface CourseOrderItemRepository extends JpaRepository<ItemBean, Integer> {

	@Query("from ItemBean i left join CorderBean o on i.orderID = o.orderID where o.status = '已付款' AND o.studentID = :sid AND i.courseID = :cid AND i.qty > i.itemStatus ORDER BY o.orderDate ASC")
	List<ItemBean> findBystudentIDAndCourseID(@Param("sid") Integer studentID,@Param("cid") Integer courseID);
	
	
	
}
