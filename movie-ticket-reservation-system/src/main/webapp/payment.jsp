<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>payment</title>
</head>
<body>

<h1>Payment</h1>
<form action="bookings.jsp" method="post">
<%
	out.println(session.getAttribute("username")+"<br>");
	out.println(session.getAttribute("moviename")+"<br>");
	out.println(session.getAttribute("theatrename")+"<br>");
	String[] seats=request.getParameterValues("seatno");
	double premium=Double.parseDouble(""+session.getAttribute("premiumprice"));
	double nonpremium=Double.parseDouble(""+session.getAttribute("nonpremiumprice"));
	double total=0;
	String tickets="";
	int p=0;
	int np=0;
	for(String s:seats)
	{
		if(s.charAt(0)>'J')
		{
			total+=nonpremium;
			np++;
		}
		else
		{
			total+=premium;
			p++;
		}%>
		<input type=hidden name=seatno value="<%=s%>"/>
		<%
		tickets=tickets+","+s;
	}
	out.println("Total no of seats :"+(p+np)+"<br>");
	out.println("No of Premium class :"+p+"<br>");
	out.println("No of Non Premium class :"+np+"<br>");
	out.println("Tickets:"+tickets.substring(1)+"<br>");
	out.println("Total Price :"+total+"<br>");
	session.setAttribute("totalamount", total);
	session.setAttribute("totalseats", p+np);
	session.setAttribute("no_of_premium", p);
	session.setAttribute("no_of_nonpremium", np);
	out.println(session.getAttribute("date")+"<br>");
	out.println(session.getAttribute("timings")+"<br>");
%>

	<input type="submit" value="Proceed To Pay"/>
</form>
</body>
</html>