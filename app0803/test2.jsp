<%@ page contextType="text/html; charset=utf-8"%>

<%!
	//����� ����: �������
	int price=100;

	public int getPrice(){
		return price;
	}
%>
	
<%
	//��ũ��Ʋ�� ���� ()
	out,print("������ "+getPrice());
%>