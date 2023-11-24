package com.login.dao;

import java.sql.SQLException;  
import java.util.ArrayList;
import java.util.List;

import com.login.common.DBConnPool;
import com.login.dto.BoardDto;
import com.login.dto.Criteria;

public class BoardDao extends DBConnPool {
	
	/**
	 * 게시글 삭제
	 * @param num : 삭제할 게시물 번호
	 * @return res : 삭제된 게시물의 수
	 */
	public int deleteBoard(String num) {
		int res = 0;
		String sql = "delete from board\r\n"
					+ "where num = ?";
	
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, num);
			
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
	/**
	 * 게시글의 조회수를 1 증가시켜준다.
	 * 
	 * insert, update, delete의 반환 타입은 int (몇 건이 처리되었는지 반환)
	 * 반환타입은 int로 설정
	 * @return 
	 * 
	 */
	public int visitcountUp(String num) {
		int res = 0;
		String sql = "update board\r\n"
					+ "set visitcount = visitcount + 1\r\n"
					+ "where num = ? ";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, num);
			
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {	
			e.printStackTrace();
		}
		return res;
	}
	
	/**
	 * 한건의 게시글을 조회후 BoardDto에 담아서 반납합니다.
	 * @return BoardDto
	 */
	public BoardDto getOne(String num) {
		BoardDto dto = null;
		String sql = "select * \r\n"
					+ "from board\r\n"
					+ "where num = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDto();
				dto.setContent(rs.getString("content"));
				dto.setId(rs.getString("id"));
				dto.setNum(rs.getString("num"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setTitle(rs.getString("title"));
				dto.setVisitcount(rs.getString("visitcount"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dto;
	}
	
	
	
	/**
	 * 데이터베이스로부터 사원의 목록을 조회하여 반환합니다.
	 * 조회된 데이터를 반환하기 위해 리스트에 담아준다.
	 * + 페이징 처리
	 */
	public List<BoardDto> getList (Criteria cri) {
		List<BoardDto> list = new ArrayList<>();
		
		// rownum : 쿼리의 결과에 1부터 순서대로 순번을 부여 해주는 컬럼
		// rownum을 이용시 조건을 1보다 큰 수로 지정하게 되면 게시물이 조회되지 않는다.
		// 따라서 한번 더 감싸준다.
		
		// 검색어와 검색필드에 값이 들어있다면 조건 문장을 생성한다.
		try {
			
		String where = "";
		if(!"".equals(cri.getSearchField())
					&& !"".equals(cri.getSearchWord())) {
			where = "where " + cri.getSearchField()
							+ " like '%" + cri.getSearchWord() + "%'\r\n ";			
		}
		
		String sql = "select *\r\n"
					+ "from (\r\n"
					+ "    select rownum rnum, b.*\r\n"
					+ "    from (\r\n"
					+ "          select num, title, content, id, to_char(postdate, 'yyyy-mm-dd') postdate, visitcount\r\n"
					+ "          from board\r\n"
					
					+ where
					
					+ "          order by num desc\r\n"
					+ "          ) b\r\n"
					+ "    )\r\n"
					+ "where rnum between ? and ?";
		
		
		
			pstmt = con.prepareStatement(sql);
			
			//시작번호 = 끝번호 - (페이지 당 게시물 수 -1)
			pstmt.setInt(1, cri.getStartNum());
			
			//끝번호 = 페이지번호 * 페이지 당 게시물 수
			pstmt.setInt(2, cri.getEndNum());
			
			rs = pstmt.executeQuery();
			
			System.out.println("pstmt" + pstmt);
			
			while(rs.next()) {
				BoardDto dto = new BoardDto();
				dto.setContent(rs.getString("content"));
				dto.setId(rs.getString("id"));
				dto.setNum(rs.getString("num"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setTitle(rs.getString("title"));
				dto.setVisitcount(rs.getString("visitcount"));
			
				list.add(dto);
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		 return list;		
	}
	
	/**
	 * 게시글의 총 건수를 조회 후 반환 
	 * - 집계 함수를 이용하여 게시글의 총 건수를 구해보자!
	 * @return 게시글의 총 건수
	 */
	
	public int getTotalCnt(Criteria cri) {
		int res = 0;
		
		String where = "";
		if(!"".equals(cri.getSearchField())
					&& !"".equals(cri.getSearchWord())) {
			where = "where " + cri.getSearchField()
							+ " like '%" + cri.getSearchWord() + "%'\r\n ";			
		}
		
		String sql = "select count(*) from board " + where;
		System.out.println("sql : " + sql);
		
		try {
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				res = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return res;
	}
	
}
