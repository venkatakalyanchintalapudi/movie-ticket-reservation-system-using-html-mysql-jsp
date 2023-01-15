<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bookings</title>
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
</head>
<body>
<% 
	try
	{	
		int c=0;
		Random r=new Random();
		String pid="P"+r.nextInt(10000);
		PreparedStatement st=con.prepareStatement("select pid from ticketsbooked");
		ResultSet rs=st.executeQuery();
		ArrayList<String> a=new ArrayList<String>();
		while(rs.next())
		{
			a.add(rs.getString("pid"));
		}
		st.close();
		while(a.contains(pid))
		{
			pid="P"+r.nextInt(10000);
		}
		PreparedStatement st1=con.prepareStatement("insert into ticketsbooked values(?,?,?,?,?,?,?,?,?,?)");
		st1.setString(1,pid);
		st1.setString(2,""+session.getAttribute("username"));
		st1.setString(3,""+session.getAttribute("totalseats"));
		st1.setString(4,""+session.getAttribute("date"));
		st1.setString(5,""+session.getAttribute("timings"));
		st1.setString(6,""+session.getAttribute("moviename"));
		st1.setString(7,""+session.getAttribute("theatreid"));
		st1.setString(8,""+session.getAttribute("totalamount"));
		st1.setString(9,""+session.getAttribute("no_of_premium"));
		st1.setString(10,""+session.getAttribute("no_of_nonpremium"));
		int n=st1.executeUpdate();
		if(n!=0){
			String[] seats=request.getParameterValues("seatno");
			for(String s:seats){
			PreparedStatement st2=con.prepareStatement("insert into seatsbooked values(?,?)");
			st2.setString(1,pid);
			st2.setString(2,s);
			st2.executeUpdate();
			c++;
			st2.close();
			}
		}
		if(c==Integer.parseInt(""+session.getAttribute("totalseats"))){
			out.println("<h1>Tickets successfully booked</h1><br>");
			out.println("Click here to go to main page");
			out.println("<a href='homepage.jsp'>here</a>");
		}
		else
		{
			out.println("boooking unsuccessfull..try again");
		}
	}
	catch(Exception e)
	{
		System.out.println("hi");
	}
	%>
</body>
</html>
