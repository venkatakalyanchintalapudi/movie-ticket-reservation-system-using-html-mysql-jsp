<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@page import="java.sql.*" %>
<title>Book Tickets</title>
</head>
<%! Connection con;
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
<h1 align=center>BOOK TICKETS</h1>
<table cellspacing=2 cellpadding=20 >
<tr><td align=right colspan=4><form action="ticket.jsp" action=post> <input type="submit" value="My tickets"/></form></td></tr>
<%
try
{
	String moviename="";
	String trailerlink="";
	String poster="";
	String certificate="";
	String duration="";
	PreparedStatement st=con.prepareStatement("select * from movieslist");
	ResultSet rs=st.executeQuery();
	%><tr>
	<form action="movie.jsp" method=post>
	<% 
	while(rs.next()){
			moviename=rs.getString("name");
			trailerlink=rs.getString("trailer");
			poster=rs.getString("poster");
			certificate=rs.getString("certify");
			duration=rs.getString("runtime");%>
			<td align="center">
			<% 
				out.println("<img src='"+poster+"' alt='image unable to load' width=460 height=300/><br>");
				out.println("<b><p style='font-size:30px'>"+moviename+"</b></p><p>"+certificate+"</p>");
				out.println("<input type='submit' name='"+moviename+"' value='Book Now' /><br>");
				%>
				
				</td>
			
		<%		
	}
	%>
	</tr>
	</form>
<%
}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>
</table>
</body>
</body>
</html>