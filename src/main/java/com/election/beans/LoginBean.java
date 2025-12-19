package com.election.beans;

public class LoginBean {
	private int loginId;
	private String loginUserName;
	private String loginPassword;
	public String getLoginPassword() {
		return loginPassword;
	}
	public void setLoginPassword(String loginPassword) {
		this.loginPassword = loginPassword;
	}
	private String loginAddress;
	private String loginRole;
	public int getLoginId() {
		return loginId;
	}
	public void setLoginId(int loginId) {
		this.loginId = loginId;
	}
	public String getLoginUserName() {
		return loginUserName;
	}
	public void setLoginUserName(String loginUserName) {
		this.loginUserName = loginUserName;
	}
	public String getLoginAddress() {
		return loginAddress;
	}
	public void setLoginAddress(String loginAddress) {
		this.loginAddress = loginAddress;
	}
	public String getLoginRole() {
		return loginRole;
	}
	public void setLoginRole(String loginRole) {
		this.loginRole = loginRole;
	}

}
