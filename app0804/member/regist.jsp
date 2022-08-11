<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*"%>

<%!
	//선언부: 멤버영역(멤버변수, 멤버메서드)
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String user = "java";
	String password = "1234";
%>
<%
	//스클립틀릿: 로직작성
	//out.print("이 jsp에서 회원을 처리할 것임");
	//클라이언트인 브라우저가 전송한 파라미터(전송변수 즉 html에서의 name)들을 받는다
	request.setCharacterEncoding("utf-8"); //전송되는 파라미터값들에 대한 인코딩 지정
	String user_id		= request.getParameter("user_id");
	String pass			= request.getParameter("pass");
	String user_name	= request.getParameter("user_name");
	String mail_id		= request.getParameter("mail_id");
	String myserver	= request.getParameter("myserver");
	String mail_server	= request.getParameter("mail_server");
	String tel1			= request.getParameter("tel1");
	String tel2			= request.getParameter("tel2");
	String tel3			= request.getParameter("tel3");
	String social1		= request.getParameter("social1");
	String social2		= request.getParameter("social2");
	String gender		= request.getParameter("gender");

	// 취미는 파라미터가 배열로 되어 있으므로, 배열로 받아야 한다.
	String[] hobby		= request.getParameterValues("hobby");
	out.print("취미 수" + hobby);

	//직접 입력 이메일서버가 있다면, 그걸 우선해주고, 없다면 select 박스의 값을 넣는다.
	String email=null;
	String s=null;
	if(myserver.length()>0){//직접 이메일 주소를 입력했을 경우
		s=myserver;
	}else {
		s=mail_server;
	}

	email = mail_id+ "@" +s; //최종적으로 조립한 email 주소 

	out.print(user_id);
	out.print("<br>");
	out.print(pass);
	out.print("<br>");
	out.print(user_name);
	out.print("<br>");
	out.print(mail_id);
	out.print("<br>");
	out.print(myserver);
	out.print("<br>");
	out.print(mail_server);
	out.print("<br>");
	out.print(social1);
	out.print("<br>");
	out.print(social2);
	out.print("<br>");
	out.print(gender);
	out.print("<br>");

	/* 오라클의 테이블에 레코드 넣기 
		1) 해당 DBMS 제품에 맞는 드라이버 로드
		2) 접속
		3) 쿼리문 날리기
		4) DB관련된 객체 해제
	*/
	//드라이버 로드
	Class.forName("oracle.jdbc.driver.OracleDriver");

	//접속
	Connection con = DriverManager.getConnection(url,user,password);
	//트랜잭션은 con 객체로 제어하는 것임
	//데이터베이스 종류가 여러가지 임과 상관없이 con 객체는 기본적으로 autocommit(true)이 적용되어 있다.
	if(con==null){
		out.print("접속 실패<br>");
	}else {
		out.print("접속 성공<br>");
	}
	
	con.setAutoCommit(false); //자동 커밋 비활성화

	try{
		//쿼리문 생성
		String sql = "insert into member(member_id, user_id, pass, user_name, email, tel1, tel2, tel3, social1, social2, gender)";
		sql+=" values(seq_member.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		//쿼리문 날리기
		//PreparedStatement는 인터페이스이므로, new 로 직접 생설할 수 없다
		//그럼 언제 생성 되나? Connection 객체로 부터 인스턴스를 얻어올 수 있다.
		//즉 접속이 성공되면 얻어올 수 있다.
		PreparedStatement pstmt= con.prepareStatement(sql);

		pstmt.setString(1, user_id);
		pstmt.setString(2, pass);
		pstmt.setString(3, user_name);
		pstmt.setString(4, email);
		pstmt.setString(5, tel1);
		pstmt.setString(6, tel2);
		pstmt.setString(7, tel3);
		pstmt.setString(8, social1);
		pstmt.setString(9, social2);
		pstmt.setString(10, gender);
		//DML 수행 메서드
		int result = pstmt.executeUpdate();
		if(result==0){
			out.print("실패");
		}else {
			out.print("성공");
		}

		//member 테이블에 레코드가 입력된 시점에, pk인 member_id를 가져와야 함
		//select max 문은 너무 위험하다 dbms는 다중사용자 서버이므로, 동시 사용시 데이터의 일관성이 깨질수 있다.
		sql="select seq_member.currval as member_id from dual";
		PreparedStatement pstmt2 = con.prepareStatement(sql);
		ResultSet rs = pstmt2.executeQuery(); //select문 수행
		int member_id = 0;
		if(rs.next()){ //next() 호출시 true라면, 즉 레코드가 존재한다면
			member_id = rs.getInt("member_id");
		}

		PreparedStatement pstmt3 = null;
		//hobby 테이블에 취미 넣기
		for(int i=0; i<hobby.length; i++){
			sql="insert into hobby(hobby_id, member_id, hobby_name)";
			sql+=" values(seq_hobby.nextval, ?, ?)";

			pstmt3=con.prepareStatement(sql);
			pstmt3.setInt(1, member_id);
			pstmt3.setString(2, hobby[i]);
			pstmt3.executeUpdate();
		}
		con.commit();
	}catch(SQLException e){
		//어떤 이유에서건 에러가 발생함
		con.rollback();  //기존에 수행했던 모든 DML은 처음부터 없었던 것으로 돌려놓아라
	}finally{
		con.setAutoCommit(true);
	}
	
	if(rs!=null)rs.close();
	if(pstmt!=null)pstmt.close();
	if(pstmt2!=null)pstmt2.close();
	if(pstmt3!=null)pstmt3.close();
	if(con!=null)con.close();

%>