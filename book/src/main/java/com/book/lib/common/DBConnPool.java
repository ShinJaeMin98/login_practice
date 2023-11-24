package com.book.lib.common;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBConnPool {
	
	public Connection con;
	public Statement stmt;
	public PreparedStatement pstmt;
	public ResultSet rs;
	
	public DBConnPool() {
	
	try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		
		DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
		con = ds.getConnection();
		
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}	
	}
	
	// 자원 반납
	public void close() {
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(stmt != null) stmt.close();
			if(con != null) con.close();
		} catch (SQLException e) {
			System.out.println("자원 반납 중 오류 발생");
			e.printStackTrace();
		}
	}
	
	/**
	 * 페이지쿼리를 생성해주는 메서드
	 * @param sql
	 * @return
	 */
	
	public String pagingQuery(String sql) {
		
		String before = "select *\r\n"
				+ "from (select rownum rnum, b.*\r\n"
				+ "from (";
		
		String after = ") b)\r\n"
				+ "where rnum BETWEEN ? and ?";		
		
		return before + sql + after;
	}

}
