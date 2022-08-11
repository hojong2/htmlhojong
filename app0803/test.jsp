<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
</head>
<body>
<%
/*
	for(int i=1; i<=9; i++)
	out.println("2*"+ i + "= " + 2*i+"<br>");
	//자바 스탠다드의 문법이 적용되므로, 오라클을 연동해보자
	//SQLPlus로 접속할때: 서버의 주소, id/pw
*/
	//우리의 오라클 서버에 접속시도
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="java";
	String password="1234";

	//방금 가져온 드라이버를 메모리에 로드
	Class.forName("oracle.jdbc.driver.OracleDriver"); //static 영역에 메소드 로드

	//접속
	Connection con = DriverManager.getConnection(url, user, password);
	
	if(con==null){
		out.print("접속 실패");
	}else{
		out.print("접속 성공");

		//쿼리문 수행
		PreparedStatement pstmt=null; //인터페이스라 직접 new 못함
		String sql="select * from dept";  //부서 테이블 가져오기
		pstmt=con.prepareStatement(sql); //이 시점에 메모리에 올라옴
		ResultSet rs = pstmt.executeQuery(); //쿼리문 수행 시점

		out.print("<table border= 1px>");
		while(rs.next()){
			out.print("<tr>");
			out.print("<td>"+rs.getString("loc")+"</td>");   //컬럼이 loc인 데이터 가져오기
			out.print("<td>"+rs.getString("deptno")+"</td>");
			out.print("<td>"+rs.getString("dname")+"</td>");
			out.print("<tr>");
		}
		out.print("<table>");

	}
	if(con != null){
		con.close();
	}
%>
</body>
</html>
