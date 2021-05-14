<%@ page import="com.paf9.Item"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
Item itemObj = new Item();
String stsMsg = "";

if (request.getParameter("itemCode") != null) {
	System.out.println("Insert/update working");
	//Insert item----------------------------------
	if (request.getParameter("hidItemIDSave").toString().equalsIgnoreCase("")) {
		System.out.println("insert working");
		stsMsg = itemObj.insertItem(
				request.getParameter("itemCode"), 
				request.getParameter("itemName"),
				request.getParameter("itemPrice"), 
				request.getParameter("itemDesc"));
		//Update item-----------------------------------
	} else {//if (request.getParameter("action").toString().equalsIgnoreCase("update")) {
		System.out.println("update working");
		stsMsg = itemObj.updateItem(
				Integer.parseInt(request.getParameter("hidItemIDSave").toString()),
				request.getParameter("itemCode"), 
				request.getParameter("itemName"), 
				request.getParameter("itemPrice"),
				request.getParameter("itemDesc"));
	}
	session.setAttribute("statusMsg", stsMsg);
}
//Remove
if (request.getParameter("hidItemIDDelete") != null) {
	System.out.println("delete working");
	stsMsg = itemObj.removeItem(Integer.parseInt(request.getParameter("hidItemIDDelete").toString()));
	session.setAttribute("statusMsg", stsMsg);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Items Management</title>
<script src="Components/jquery-3.2.1.min.js"></script>
<script src="Components/Items.js"></script>
<link rel="stylesheet" href="views/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col">


				<h1>Items Management</h1>
				<form method='post' action='Items.jsp' id='formItem' name='formItem'>
					Item code: <input id='itemCode' name='itemCode' type='text' class='form-control col-md-3'><br> 
					Item name: <input id='itemName' name='itemName' type='text' class='form-control col-md-3'><br> 
					Item price: <input id='itemPrice' name='itemPrice' type='text' class='form-control col-md-3'><br> 
					Item description: <input id='itemDesc' name='itemDesc' type='text' class='form-control col-md-3'><br> 
					<input id='btnSave' name='btnSave' type='button' value='Save' class='btn btn-primary'> 
					<input type='hidden' id='hidItemIDSave' name='hidItemIDSave' value=''>
				</form>

				<br>
				<p>
					<%
					out.print("<div id='alertSuccess' name='alertSuccess' class='alert alert-success'>" + session.getAttribute("statusMsg") + "</div>");
					out.print("<div id='alertError' name='alertError' class='alert alert-danger'>" + session.getAttribute("statusMsg") + "</div>");
					%>
				</p>

				<br>
				<%
				Item itemObjRead = new Item();
				out.print(itemObjRead.readItems());
				%>


			</div>
		</div>
	</div>
</body>
</html>