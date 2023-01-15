<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
/* The container */
.container {
  display: block;
  position: relative;
  padding-left: 30px;
  padding-bottom: 10px;
  margin-bottom: 20px;
  cursor: pointer;
  font-size: 14px;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

/* Hide the browser's default checkbox */
.container input {
  position: absolute;
  opacity: 0;
  cursor: pointer;
  height: 0;
  width: 0;
}

/* Create a custom checkbox */
.checkmark {
  position: absolute;
  top: 0;
  left: 0;
  height: 25px;
  width: 25px;
  background-color: white;
  outline:1px solid green;
}

/* On mouse-over, add a grey background color */
.container:hover input ~ .checkmark {
  background-color: #cccc;
}

/* When the checkbox is checked, add a blue background */
.container input:checked ~ .checkmark {
  background-color: green;
}

/* Create the checkmark/indicator (hidden when not checked) */
.checkmark:after {
  content: "";
  position: absolute;
  display: none;
}

/* Show the checkmark when checked */
.container input:checked ~ .checkmark:after {
  display: block;
}

/* Style the checkmark/indicator */
.container .checkmark:after {
  left: 9px;
  top: 5px;
  width: 5px;
  height: 10px;
  border: solid white;
  border-width: 0 3px 3px 0;
  -webkit-transform: rotate(45deg);
  -ms-transform: rotate(45deg);
  transform: rotate(45deg);
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
<%@page import="java.sql.*,java.util.*,java.text.*" %>
<%! Connection con;
	String tid_d="";
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
			//00d3ff
		}
	}
%>
<body >
<%	
	int n=0;
	try{
		
		PreparedStatement st=con.prepareStatement("select * from timings");
		ResultSet rs=st.executeQuery();
		while(rs.next())
		{
			String id_d_t=rs.getInt("tid")+" "+rs.getString("date")+" "+rs.getString("timings");
			if(request.getParameter(id_d_t)!=null)
			{
				n=rs.getInt("tid");
				session.setAttribute("theatreid",n);
				session.setAttribute("date",rs.getString("date"));
				java.util.Date date1 = new SimpleDateFormat("yyyy-mm-dd")
	                    .parse(rs.getString("date"));
				session.setAttribute("formaldate",date1);
				session.setAttribute("timings",rs.getString("timings"));
				break;
			}
		}
		PreparedStatement st1=con.prepareStatement("select * from theatre where id='"+n+"'");
		ResultSet rs1=st1.executeQuery();
		rs1.next();
		session.setAttribute("theatrename",rs1.getString("theatrename"));
		session.setAttribute("premiumprice",rs1.getString("premium"));
		session.setAttribute("nonpremiumprice",rs1.getString("nonpremium"));
		st.close();
		st1.close();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>
<form action="payment.jsp" method="post" target="_top">
<table align=center cellspacing=10 >
<h1><%="<font color=#00a08d>"+session.getAttribute("theatrename")+"</font> "+session.getAttribute("formaldate")+" <font color=#00548b>"+session.getAttribute("timings")+"</font>"%></h1>
<hr class='dotted'/>
<tr><td colspan=20><b>Rs.<%=session.getAttribute("premiumprice")%> Premium Class</b></td></tr>
<tr><td colspan=20><hr style="height:2px;border-width:0;background-color:#eeeeee"></td></tr>
<%
ArrayList<String> seatsbooked=new ArrayList<String>();
try
{
	String tid=""+session.getAttribute("theatreid");
	String date=(String)session.getAttribute("date");
	String time=(String)session.getAttribute("timings");
	PreparedStatement st=con.prepareStatement("select pid from ticketsbooked where date='"+date+"' and theatreid='"+tid+"' and time='"+time+"'");
	ResultSet rs=st.executeQuery();
	while(rs.next())
	{
		String pid=rs.getString("pid");
		PreparedStatement st1=con.prepareStatement("select seatno from seatsbooked where pid='"+pid+"'");
		ResultSet rs1=st1.executeQuery();
		while(rs1.next()){
			seatsbooked.add((String)rs1.getString("seatno"));
		}
	}
	st.close();
}
catch(Exception e)
{
	e.printStackTrace();
}
String rows[]={"A","B","C","D","E","F","G","H","I","J","K","L"};
for(String s:rows){
	%>
	<tr>
	<%for(int i=1;i<17;i++){
		if(seatsbooked.contains(s+i)){	
		%>
			<td style="vertical-align:top"><div class="div1"><%=s+i%></div></td>
		<%}else{ %>
	<td>
	<label class="container">
  		<input type="checkbox" name=seatno value="<%=s+i %>" >
  		<span class="checkmark"></span>
	</label>
	<font color=gray ><%=s+i%></font>
	</td>
	<%}if(s.charAt(0)<='B' && i==8 ){%>
			<td colspan=2>  </td>
	<%}else if(s.charAt(0)>'B' && s.charAt(0)<='L' && (i==3 || i==13)){%>
			<td >  </td>
	<% }%>

	<%}%>
	</tr>
	<%if(s.equals("B")){%>
			<tr><td colspan=20></td></tr>
			<tr><td colspan=20><hr style="height:4px;border-width:0;background-color:white"></td></tr>
	<% }if(s.equals("J")){%>
			<tr><td colspan=20><b>Rs.<%=session.getAttribute("nonpremiumprice")%> Non Premium</b></td></tr>
			<tr><td colspan=20><hr style="height:2px;border-width:0;background-color:#eeeeee"></td></tr>
	<%}}%>

<tr><td colspan=20 align=center><input type=submit name=submit value="booktickets" target="_blank"></td></tr>
</form>
</body>
</html>
