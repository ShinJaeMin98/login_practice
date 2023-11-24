package com.login.dao;

import java.sql.SQLException;

import javax.naming.NamingException;

import com.login.common.DBConnPool;

public class HelloDao extends DBConnPool {
	/**
	 * DB로부터 현재 시간을 조회한 후 반환
	 */
	public String getTime() {
		String time = "";
		
		try {
		stmt = con.createStatement();
		rs = stmt.executeQuery("select sysdate from dual");
		
		if(rs.next()) {
			time = rs.getString(1);
		}
		
		} catch (SQLException e) {
		e.printStackTrace();
		}
		
		return time;
	}

}
