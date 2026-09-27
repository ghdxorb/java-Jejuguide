package com.mnu.jeju.model;

	public class GuestbookDTO {
	    private int postId;
	    private String author;
	    private String content;
	    private String regDate;

	    public int getPostId() { return postId; }
	    public void setPostId(int postId) { this.postId = postId; }
	    
	    public String getAuthor() { return author; }
	    public void setAuthor(String author) { this.author = author; }
	    
	    public String getContent() { return content; }
	    public void setContent(String content) { this.content = content; }
	    
	    public String getRegDate() { return regDate; }
	    public void setRegDate(String regDate) { this.regDate = regDate; }
	}