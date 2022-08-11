<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%
	//로직을 작성
	
	//드라이버 로드
	Class.forName("com.mysql.jdbc.Driver");

	//접속
	String url = "jdbc:mysql://localhost/javastudy";
	String user = "root";
	String password = "1234";
	//아래에서도 이 객체들을 쓰기 위함
	PreparedStatement pstmt = null;

	ResultSet rs = null; //select문 수행

	Connection con = DriverManager.getConnection(url, user, password);

	if(con==null){
		out.print("실패");
	}else{
		out.print("성공");
		String sql = "select * from emp";
		pstmt = con.prepareStatement(sql);

		rs = pstmt.executeQuery(); //select문 수행
	}

%>

<table width="800px" border="1px" align="center">
	<tr align="center" onmouseover="this.style.background='yellow'" onmouseout="this.style.background=''">
		<td>empno</td>
		<td>ename</td>
		<td>job</td>
		<td>mgr</td>
		<td>hiredate</td>
		<td>sal</td>
		<td>comm</td>
		<td>deptno</td>
	</tr>
	<%while(rs.next()){%>
	<tr align="center" onmouseover="this.style.background='yellow'" onmouseout="this.style.background=''">
		<td><%out.print(rs.getInt("empno"));%></td>
		<td><%out.print(rs.getString("ename"));%></td>
		<td><%out.print(rs.getString("job"));%></td>
		<td><%out.print(rs.getInt("mgr"));%></td>
		<td><%out.print(rs.getString("hiredate"));%></td>
		<td><%out.print(rs.getInt("sal"));%></td>
		<td><%out.print(rs.getInt("comm"));%></td>
		<td><%out.print(rs.getInt("deptno"));%></td>
	</tr>
	<%};%>
	<%
	if(rs!=null)rs.close();
	if(pstmt!=null)pstmt.close();
	if(con!=null)con.close();
	
	%>
</table>