<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import= "java.sql.*"%>
<%!
	String url="jdbc:mysql://localhost:3306/javastudy?useUnicode=true&characterEncoding=utf8";
	String user="root";
	String password="1234";
	
	ResultSet rs;
	PreparedStatement pstmt;
	Connection con;
%>
<%
	Class.forName("com.mysql.jdbc.Driver");  //드라이버 가져옴
	con=DriverManager.getConnection(url,user,password); //접속

	String sql="select * from gallery order by gallery_id desc";
	pstmt=con.prepareStatement(sql); //쿼리문 준비
	rs= pstmt.executeQuery(); //select 실행
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>사진목록</title>
</head>
<body>
	<table width="80%" border="1px">
		<tr align="center">
			<td>gallery_id</td>
			<td>제목</td>
			<td>장소</td>
			<td>상세설명</td>
			<td>이미지</td>
		</tr>
		<%while(rs.next()){%>
		<tr>
			<td><%=rs.getInt("gallery_id")%></td>
			<td><%=rs.getString("title")%></td>
			<td><%=rs.getString("spot")%></td>
			<td><%=rs.getString("detail")%></td>
			<td><img src="/data/<%=rs.getString("filename")%>" width="50px" height="50px"></td>
		</tr>
		<%}%>
		<tr>
			<td colspan="5"><button onClick = "location.href='/upload.html';">사진등록</button></td>
		</tr>
	</table>
</body>
</html>
