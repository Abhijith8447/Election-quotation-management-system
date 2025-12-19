<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.election.beans.OwnerBean" %>
    <%@ page import="com.election.dao.OwnerDAO" %>
<%
	String ownerName=request.getParameter("owner-name");
	String ownerAddress=request.getParameter("owner-address");
	String ownerContact=request.getParameter("owner-contact");
	
	OwnerBean ownerBean=new OwnerBean();
	
	ownerBean.setOwnerName(ownerName);
	ownerBean.setOwnerAddress(ownerAddress);
	ownerBean.setOwnerContact(ownerContact);
	boolean checkFlag = OwnerDAO.checkOwnerDetails(ownerBean);
	if(checkFlag){
		response.sendRedirect("adminOwner.jsp?v=1");
	}else{
		boolean flagInsert=OwnerDAO.insertOwnerDetails(ownerBean);
		if(flagInsert){
		response.sendRedirect("adminOwner.jsp?v=2");
		}else {
		response.sendRedirect("adminOwner.jsp?v=3");
		}
	}
%>