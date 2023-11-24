package com.book.lib.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.book.lib.common.DBConnPool;
import com.book.lib.dto.BookDto;
import com.book.lib.dto.Criteria;

/**
 * DB에 접근하여 쿼리를 질의한다.
 */
public class BookDao extends DBConnPool {
	
	/**
	 * 도서목록을 조회 후 반환 합니다.
	 * @return 도서목록
	 */
	public List<BookDto> getList(Criteria cri){
		List<BookDto> list = new ArrayList<>();
		
		// 검색어와 검색필드에 값이 들어있다면 조건 문장을 생성한다.
		String where = "";
		if(!"".equals(cri.getSearchField())
					&& !"".equals(cri.getSearchWord())) {
			where = " where " + cri.getSearchField()
							+ " like '%" + cri.getSearchWord() + "%'\r\n ";			
		}
		
		String sql = "select * from book\r\n"
						+ where
						+ "order by no DESC";
		
		try {	
			// pagingQuery 이용시 페이지 처리를 위한 파라미터 세팅 필요
			sql = pagingQuery(sql);
			
			System.out.println("sql\n" + sql);
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, cri.getStartNum());
			pstmt.setInt(2, cri.getEndNum());
			
			rs = pstmt.executeQuery();
			
			// 결과집합으로부터 도서의 정보를 가지고와서 dto에 저장 후 리스트에 담아줍니다
			while(rs.next()) {
				String no = rs.getString("no");
				String title = rs.getString("title");
				String author = rs.getString("author");
				String rentYn = rs.getString("rentYn");
				
				BookDto dto = new BookDto(no, title, author, rentYn);
				list.add(dto);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	/**
	 * 도서의 상세 정보를 조회 후 반환 합니다.
	 * @param no
	 * @return 도서정보(BookDto)
	 */
	public BookDto view(String no){
		BookDto dto = new BookDto();
		String sql = "select * from book where no = ? ";
		try {
			pstmt = con.prepareStatement(sql);
			// ?의 갯수만큼 파라메터를 설정 합니다.
			pstmt.setString(1, no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setNo(rs.getString("no"));
				dto.setTitle(rs.getString("title"));
				dto.setAuthor(rs.getString("author"));
				dto.setRentYn(rs.getString("rentYn"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return dto;
	}

	/**
	 * 도서의 총 건수 구하기
	 * @return
	 */
	public int getTotalCnt(Criteria cri) {
		int res = 0;
		
		String where = "";
		if(!"".equals(cri.getSearchField())
					&& !"".equals(cri.getSearchWord())) {
			where = "where " + cri.getSearchField()
							+ " like '%" + cri.getSearchWord() + "%'\r\n ";			
		}
		
		String sql = "select count(*) from book " + where;
		
		try {
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				res = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}

}
