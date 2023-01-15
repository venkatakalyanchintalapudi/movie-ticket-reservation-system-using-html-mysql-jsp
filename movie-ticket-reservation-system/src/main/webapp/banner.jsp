<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
</head>
<body bgcolor=#f0f0f0>
<%	
	String poster=(String)session.getAttribute("poster");
	out.println("<top><img src='"+poster+"' align=left width=500 height=274></top>");
	out.println("<center><font size=50><b>"+session.getAttribute("moviename")+"</b></font><center><br>");
	out.println("<p style='font-size:30px'>"+session.getAttribute("certificate")+"</p><p style='font-size:20px'>"+session.getAttribute("duration")+"</p>");
	out.println("<center><a target='_blank' href='"+session.getAttribute("trailerlink")+"' >Watch the Trailer</a></center>");
%>
</body>
</html>