<% page contentType="text/html;charset=utf-8"%>
<%!
	Int price=5;

	Public Int getPrice(){
		return price
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
</head>
<body>
가격은<%=getPrice()%>입니다.
</body>
</html>
