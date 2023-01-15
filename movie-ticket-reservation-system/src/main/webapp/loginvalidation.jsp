<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>

<body>
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
	String name=request.getParameter("username");
	String pass=request.getParameter("password");
	session=request.getSession();
	%>
	<script>
		function alertmsg(s)
		{
			alert(s);
		}
	</script>
	<%
	
	try
	{
		PreparedStatement st=con.prepareStatement("select * from users where name=? and password=?");
		st.setString(1,name);
		st.setString(2,pass);
		ResultSet rs=st.executeQuery();
		if(rs.next()){
			session.setAttribute("username",name);
			%>
			<script>
				alertmsg("Login success!");
			</script>
			<jsp:forward page="homepage.jsp"/>
			<%
			}
		else
		{
			%>
			<script>
				alertmsg("Invalid login credentials");
			</script>
			<%
			
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>
</body>
</html>