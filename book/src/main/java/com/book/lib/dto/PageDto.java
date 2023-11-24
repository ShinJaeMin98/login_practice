package com.book.lib.dto;

public class PageDto {	/**
	 * 페이지네이션을 그리기 위해 필요한 정보
	 */
	int startNo;		// 페이지 블럭 시작번호
	int endNo;			// 페이지 블럭 끝번호
	int realEnd;		// 게시물의 끝 페이지 번호(게시물의 총 갯수를 페이지 당 게시물의 수로 나누어 구한다.)	
	boolean prev, next;	// 이전, 다음 버튼(true:보여주기)
	
	/**
	 * 위의 정보들을 세팅하기 위해 필요한 값
	 * - 페이지 블럭을 생성하기 위해 필요한 변수에 값을 넣기 위해 필요
	 */
	int totalCnt;		// 총 게시물의 수
	Criteria cri;		// 요청 페이지번호, 페이지당 게시물 수
	int blockAmount = 5;	// 페이지 블럭에 보여줄 페이지 수
	
	/**
	 * 생성자를 통해 페이지블럭을 그리기 위한 정보를 세팅한다.
	 * 
	 * @param totalCnt
	 * @param cri
	 * @param blockAmount
	 */
	
	//blockAmount는 생성자를 통해 값을 받을 수도 있고 받지 않을 수도 있다.

	public PageDto(int totalCnt, Criteria cri, String blockAmount) {
		// 생성자 호출
		this(totalCnt, cri);
		
		if(blockAmount != null && !"".equals(blockAmount)) {
			this.blockAmount = Integer.parseInt(blockAmount);
		}
	}
	
	public PageDto(int totalCnt, Criteria cri) {
		
		this.totalCnt = totalCnt;
		this.cri = cri;
		
		// 페이지 블럭의 끝번호를 구한다
		// 요청 페이지, 블럭당 페이지 수에 따라서 블럭의 범위가 정해진다.
		
		// 페이지 블럭의 시작번호, 끝번호
		// 페이지 블럭의 끝번호
		endNo = (int)Math.ceil(cri.getPageNo() / (blockAmount*1.0)) * blockAmount;
		startNo = endNo - (blockAmount - 1);
		
		// 페이지 끝번호
		realEnd = (int)Math.ceil((totalCnt*1.0) / cri.getAmount());
		
		// 진짜 끝번호보다 블럭의 끝번호가 큰 경우 처리 (게시물의 67건인 경우 끝번호는 7, 블럭의 끝번호는 10일 경우)
		
		endNo = endNo > realEnd ? realEnd : endNo;
		
		prev = startNo == 1 ? false : true;
		next = endNo == realEnd ? false : true;
		
	}

	public int getStartNo() {
		return startNo;
	}

	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}

	public int getEndNo() {
		return endNo;
	}

	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}

	public int getRealEnd() {
		return realEnd;
	}

	public void setRealEnd(int realEnd) {
		this.realEnd = realEnd;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	public int getBlockAmount() {
		return blockAmount;
	}

	public void setBlockAmount(int blockAmount) {
		this.blockAmount = blockAmount;
	}
	
	
	

}

