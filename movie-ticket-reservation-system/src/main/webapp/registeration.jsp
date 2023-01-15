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
<%
	String name=request.getParameter("username");
	String pass=request.getParameter("pass");
	String cpass=request.getParameter("cpass");
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
		PreparedStatement st=con.prepareStatement("select * from users where name=?");
		st.setString(1,name);
		ResultSet rs=st.executeQuery();
		if(rs.next()){
			%>
			<script>
				alertmsg("User Name already Exists!");
			</script>
			<center>Click here to <a href='WelcomeFile.html'>Sign in</a></center>
			<%
			}
		else
		{
			PreparedStatement st1=con.prepareStatement("insert into users values('"+name+"','"+pass+"')");
			int n=st1.executeUpdate();
			if(n==0){
			%>
			<script>
				alertmsg("unable to insert");
			</script>
			<%}
			else{
				out.println("<center>Successfully registered<br>Click here to <a href='login.html'>Sign in</a></center>");
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
