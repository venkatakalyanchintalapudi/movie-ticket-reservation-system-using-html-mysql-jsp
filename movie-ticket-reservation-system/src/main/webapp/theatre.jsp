<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style> 
	input[type=submit]{
  	background-color: #f9f9f9;
  	border: 1;
  	border-color:#00d3ff;
  	color: black;
  	padding: 10px 8px;
  	margin: 10px 10px;
 
}
</style>
<style>
    .dotted {border: 2px dotted white; border-style: none none dotted; color: grey; background-color: black; }
	.div1 {
	position: relative;
  top: -3;
  left: -1;
  width: 25px;
  height: 25px;
  border: 1px solid grey;
  background:#eeee;
  font-size:14px;
  text-align:center;
}
</style>
</head>
<body>
<center><h1>Theatres List</h1></center>
<hr class='dotted'/>

<%@page import="java.sql.*,java.util.*,java.text.*" %>
<%! Connection con;
	String tid_d="";
	public void jspInit()
	{
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbmsproject","root","Kalyan@2476");
			
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
<%
try
{
	String moviename=(String)session.getAttribute("moviename");
	PreparedStatement st=con.prepareStatement("select * from theatre where moviename='"+moviename+"'");
	ResultSet rs=st.executeQuery();
	while(rs.next()){
		//String s=rs.getString("theatrename");
		int id=rs.getInt("id");
		out.println("<font size=5 color=#ff2e00><b>"+rs.getString("theatrename")+"</b></font><br>");
		out.println("<hr style='height:1px;border-width:0;background-color:#eeeeee'><br>");
		PreparedStatement st2=con.prepareStatement("select distinct date from timings where tid='"+id+"' order by date");
		ResultSet rs2=st2.executeQuery();
		while(rs2.next()){
			String d=rs2.getString("date");
			java.util.Date date = new SimpleDateFormat("yyyy-mm-dd")
                    .parse(d);
			out.println(date);
			PreparedStatement st1=con.prepareStatement("select * from timings where tid='"+id+"' and date='"+d+"'");
			ResultSet rs1=st1.executeQuery();
		%>
		<center>
		<form action="seats.jsp" method="post" target="display"  name="f">
		<% while(rs1.next()){
				tid_d=rs1.getInt("tid")+" "+rs1.getString("date")+" "+rs1.getString("timings");
			%>
			<input type="submit" name="<%=tid_d%>" value="<%=rs1.getString("timings")%>"/>
		<%}%>
		</form>
		<br>
		</center>
		<%
		}
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>
</body>
</html>
