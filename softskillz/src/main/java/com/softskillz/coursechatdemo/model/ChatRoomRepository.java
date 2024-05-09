package com.softskillz.coursechatdemo.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ChatRoomRepository extends JpaRepository<ChatRoom, String> {

    @Query("from ChatRoom cr where cr.user1 = :uu or cr.user2 = :uu order by cr.lastTime desc")
	List<ChatRoom> chatRoomList(@Param("uu")String uesrID) ;
}
