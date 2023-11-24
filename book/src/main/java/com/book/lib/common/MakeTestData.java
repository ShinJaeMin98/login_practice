package com.book.lib.common;

import java.sql.SQLException;

public class MakeTestData extends DBConnPool {
	public void insert() {
		String sql = "insert into book\r\n"
				+ "values(SEQ_BOOK_NO.nextval, '책'||SEQ_BOOK_NO.nextval, 'N','작가'||SEQ_BOOK_NO.nextval)";
		
		
		try {
			pstmt = con.prepareStatement(sql);
			
			int res = pstmt.executeUpdate();
			System.out.println(res + "건 입력");
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public static void main(String[] args) {
		MakeTestData d = new MakeTestData();
			for(int i = 1; i < 300; i++) {
				d.insert();
			}
			d.close();
	}
	
}
