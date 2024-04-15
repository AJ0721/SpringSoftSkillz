package com.softskillz.courseorder.model.dao;

import java.util.Date;
import java.util.List;

import com.softskillz.courseorder.model.bean.CorderBean;


public interface OrderDaoInterface {

	public void insertORD(CorderBean orderBean);

	public void deleteORD(String orderID);

	public void cancelORD(String orderID, String status);

	public CorderBean selectORD(String orderID);

	public List<CorderBean> selsctUserAllORD(Integer studentID);

	public List<CorderBean> adminSelectAll();

	public List<CorderBean> adminSelectByDate(Date date1, Date date2);

	public CorderBean selectORDitem(String orderID);

}
