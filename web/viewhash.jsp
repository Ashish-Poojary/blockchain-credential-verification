<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="java.sql.*"%>
<%@page import="dbconnection.Dbconnection,java.net.*,java.io.*,java.util.*"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Certificate Verify</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Merriweather:300,400|Montserrat:400,700" rel="stylesheet">
<link rel="stylesheet" href="css/animate.css">
<link rel="stylesheet" href="css/icomoon.css">
<link rel="stylesheet" href="css/themify-icons.css">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/owl.carousel.min.css">
<link rel="stylesheet" href="css/owl.theme.default.min.css">
<link rel="stylesheet" href="css/style.css">
<script src="js/modernizr-2.6.2.min.js"></script>
<!--[if lt IE 9]>
<script src="js/respond.min.js"></script>
<![endif]-->
<style>
    body {
        background-color: snow;
        font-family: 'Montserrat', sans-serif;
    }
    .page-title {
        text-align: center;
        font-size: 28px;
        font-weight: bold;
        margin-top: 20px;
        color: #333;
    }
    .navbar {
        border-bottom: 2px solid #fff;
    }
    .gtco-nav {
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #f8f9fa;
        padding: 10px 0;
        margin-bottom: 20px;
    }
    .menu-1 {
        display: flex;
        justify-content: flex-end;
    }
    .menu-1 ul {
        list-style: none;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: flex-end;
    }
    .menu-1 ul li {
        display: inline-block;
        margin-right: 15px;
    }
    .menu-1 ul li a {
        text-decoration: none;
        font-size: 16px;
        color: #333;
        font-weight: bold;
    }
    .menu-1 ul li a:hover {
        color: #007bff;
    }
    table {
        border-collapse: collapse;
        margin: 20px auto;
        width: 70%;
        background-color: lemonchiffon;
    }
    table, th, td {
        border: 1px solid #ccc;
    }
    th {
        background-color: khaki;
        color: black;
        text-align: center;
        padding: 10px;
    }
    td {
        text-align: center;
        padding: 10px;
        color: #333;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .formhead {
        font-size: 24px;
        color: lightsalmon;
        font-weight: bold;
        margin: 20px 0;
    }
</style>
</head>

<body>

<div class="gtco-loader"></div>

<div id="page">
    <div class="page-title">
        <h3>BlockChain Based Academic Credential Verification System</h3>
    </div>

    <nav class="gtco-nav" role="navigation">
        <div class="gtco-container">
            <div class="row">
                <div class="col-sm-2 col-xs-12">
                    <div id="gtco-logo"><a href="index.jsp"><h5></h5></div>
                </div>
                <div class="col-xs-10 text-right menu-1">
                    <ul>
                        <li><a href="adminpage.jsp">Home</a></li>
                        <li><a href="registerstudent.jsp">Register Student</a></li>
                        <li><a href="uploadcertificate.jsp">Upload Certificate</a></li>
                        <li class="active"><a href="viewhash.jsp">View Hash</a></li>
                        <li><a href="logout.jsp">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <div align="center"><span class="formhead">VIEW HASH</span></div>

    <center>
    <table width="70%" border="1" cellpadding="10" cellspacing="10">
        <tr>
            <th>USN</th>
            <th>HASH</th>
            <th>UPLOAD DATE</th>
        </tr>

        <%
        try {
            Socket soc = new Socket("localhost", 3000);
            ObjectOutputStream oos = new ObjectOutputStream(soc.getOutputStream());
            ObjectInputStream oin = new ObjectInputStream(soc.getInputStream());

            oos.writeObject("GETALLHASH");
            String reply = (String) oin.readObject();

            if ("SUCCESS".equals(reply)) {
                Vector v = (Vector) oin.readObject();
                for (int i = 0; i < v.size(); i++) {
                    String app = v.get(i).toString().trim();
                    StringTokenizer st = new StringTokenizer(app, "$");

                    String usn = "", hash = "", uploadDate = "";
                    if (st.hasMoreTokens()) usn = st.nextToken();
                    if (st.hasMoreTokens()) hash = st.nextToken();
                    if (st.hasMoreTokens()) uploadDate = st.nextToken();
                    
                    // Handle timestamp display
                    if (uploadDate.contains("Timestamp not available")) {
                        uploadDate = "Upload time not available (pre-timestamp feature)";
                    }
        %>
        <tr>
            <td><%= usn %></td>
            <td><%= hash %></td>
            <td><%= uploadDate %></td>
        </tr>
        <%
                }
            } else {
                out.println("<h1 center>NO DETAILS FOUND IN BLOCKCHAIN!</h1>");
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
        %>

    </table>
    </center>
</div>

<div class="gototop js-top">
    <a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
</div>

<script src="js/jquery.min.js"></script>
<script src="js/jquery.easing.1.3.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.waypoints.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>

</body>
</html>
