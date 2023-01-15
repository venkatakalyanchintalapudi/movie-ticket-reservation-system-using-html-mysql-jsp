<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
div {
  background-color: #eeeeee;
  width: 400px;
  border: 1px solid cyan;
  padding: 10px;
  margin: 2px;
}
</style>
<%@page import="java.sql.*,java.util.*" %>
<%! Connection con;
	public void jspInit()
	{
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbmsproject","root","root");
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	public void jspDestroy()
	{
		try{
			con.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
%>
<body>
<table cellspacing=20 cellpadding=10 >
<% 
	try{
	String user=(String)session.getAttribute("username");
	PreparedStatement st=con.prepareStatement("select * from ticketsbooked where cname='"+user+"'");
	ResultSet rs=st.executeQuery();
	while(rs.next()){
		String pid=rs.getString("pid");
		String seats="";
		PreparedStatement st1=con.prepareStatement("select * from seatsbooked where pid='"+pid+"'");
		ResultSet rs1=st1.executeQuery();
		while(rs1.next())
		{
			seats=seats+rs1.getString("seatno")+",";
		}
		st1.close();
		String moviename=rs.getString("moviename");
		st1=con.prepareStatement("select * from movieslist where name='"+moviename+"'");
		rs1=st1.executeQuery();
		rs1.next();
		String poster=rs1.getString("poster");
		st1.close();
		String tid=rs.getString("theatreid");
		st1=con.prepareStatement("select * from theatre where id='"+tid+"'");
		rs1=st1.executeQuery();
		rs1.next();
		String theatrename=rs1.getString("theatrename");
		st1.close();
		seats=seats.substring(0,seats.length()-1);
		%>
			
			<tr>
			<td>
			<div>
			
			<img src='<%=poster %>' align=left width=400 height=280/>
			<br>
			<h1><%=moviename%></h1>
			<br>
			Theatre Name: <%=theatrename%>
				<br>
			Date : <%=rs.getString("date")%>
				<br>
			Show Time : <%=rs.getString("time")%>
				<br>
			Tickets : <%=seats%>
			</div>
			</td>
			
			</tr>
			
		<% 
	}
	}
	catch(Exception e)
	{
		out.println("something went wrong...");
		e.printStackTrace();	
	}
%>

</table>
</body>
</html>
