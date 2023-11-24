package com.login.dto;

/**
 * 리스트를 조회하기 위한 파라미터 생성
 */

public class Criteria {

	// pageNo : 요청 페이지 번호
	// amount : 페이지당 게시물 수
	
	// 사용자의 요청 정보가 없는 경우를 대비해 초기 기본값을 설정한다.
	private int pageNo = 1;
	private int amount = 10;
	 
	// 검색어
	private String searchWord="";
	// 검색필드
	private String searchField="";
	
	// 페이지 번호와 페이지당 게시물의 수를 받아서 조회할 게시글의 시작번호와 끝번호를 구한다.
	// 페이징 처리를 위한 값 세팅
	private int startNum;
	private int endNum;
	
	// 기본 생성자
	public Criteria(){
		
		endNum = pageNo * amount;
		startNum = endNum - (amount - 1);
		
	}
	
	/**
	 * 생성자를 통해 페이지번호와 페이지당 게시물의 수를 받아와서
	 * 시작번호와 끝 번호를 구한다.
	 * @param pageNo
	 * @param amount
	 */
	
	public Criteria(String pageNo, String amount, String searchWord, String searchField ) {
		
		// 페이지 정보 세팅
		// 전달된 값이 있으면 변경 / 없으면 기본값
		if(pageNo != null && !"".equals(pageNo)) {
			this.pageNo = Integer.parseInt(pageNo);
		}
		if(amount != null && !"".equals(amount)) {
			this.amount = Integer.parseInt(amount);
		}
		
		// 시작번호와 끝 번호를 계산
		
		//끝번호 = 페이지번호 * 페이지 당 게시물 수
		endNum = this.pageNo * this.amount;	
		//시작번호 = 끝번호 - (페이지 당 게시물 수 -1)
		startNum = endNum - (this.amount - 1);
		
		// 검색어 세팅
		if(searchWord != null && !"".equals(searchWord)) {
			this.searchWord = searchWord;
		}
		if(searchField != null && !"".equals(searchField)) {
			this.searchField = searchField;
		}
		
		
	}

	@Override
	public String toString() {
		// 재정의하지 않으면 메모리주소가 출력된다.
		// toString메서드를 재정의하여 객체가 가진 필드값을 출력해주자
		return "[searchWord]" + searchWord
				+ "[searchField]" + searchField
				+ "[pageNo]" + pageNo
				+"[amount]" + amount;
	}
	public int getStartNum() {
		return startNum;
	}

	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}

	public int getEndNum() {
		return endNum;
	}

	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getSearchField() {
		return searchField;
	}

	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}
	
}
