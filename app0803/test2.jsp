<%@ page contextType="text/html; charset=utf-8"%>

<%!
	//선언부 영역: 멤버영역
	int price=100;

	public int getPrice(){
		return price;
	}
%>
	
<%
	//스크립틀릿 영역 ()
	out,print("가격은 "+getPrice());
%>