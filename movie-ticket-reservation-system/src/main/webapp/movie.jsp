<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Movies</title>
</head>
<%@page import="java.sql.*" %>
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
	while(rs.next()){
		if(request.getParameter(rs.getString("name"))!=null)
		{
			System.out.println(rs.getString("name"));
			moviename=rs.getString("name");
			trailerlink=rs.getString("trailer");
			poster=rs.getString("poster");
			certificate=rs.getString("certify");
			duration=rs.getString("runtime");
		}
		
	}
	session.setAttribute("moviename",moviename);
	session.setAttribute("trailerlink",trailerlink);
	session.setAttribute("poster",poster);
	session.setAttribute("certificate",certificate);
	session.setAttribute("duration",duration);
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>
<frameset rows="42%,*" border=1>
			<frame src="banner.jsp" scrolling=no>
			<frameset cols="35%,*">
				<frame src="theatre.jsp" color="cyan" scrolling=yes>
				<frame src="seats.html" color="pink" name="display" scrolling=yes>
			</frameset>
		</frameset>
</body>
</html>