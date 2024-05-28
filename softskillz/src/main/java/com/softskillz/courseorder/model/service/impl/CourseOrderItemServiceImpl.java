package com.softskillz.courseorder.model.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.softskillz.courseorder.model.bean.ItemBean;
import com.softskillz.courseorder.model.repository.CourseOrderItemRepository;
import com.softskillz.courseorder.model.service.CourseOrderItemService;

@Service
public class CourseOrderItemServiceImpl implements CourseOrderItemService {

	@Autowired
	private CourseOrderItemRepository coiRepo;

	@Override
	public void updateStatus(Integer studentID, Integer courseID, Integer totalHour) {
		List<ItemBean> items = coiRepo.findBystudentIDAndCourseID(studentID, courseID);
		
		for (ItemBean i : items) {
			if(totalHour <= 0) {
				break;
			}
			Integer newStatus = i.getItemStatus() + totalHour;
			if (i.getQty() > newStatus) {
				i.setItemStatus(newStatus);
				coiRepo.save(i);
			} else {
				totalHour = (totalHour+i.getItemStatus()) - i.getQty();
				i.setItemStatus(i.getQty());
				coiRepo.save(i);
				System.out.println(totalHour);
			}
		}
		System.out.println(items);

	}

}
