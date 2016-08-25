<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String appName = null;
File webRoot = new File(System.getenv("TOMCAT_HOME") + "/webapps");
if (webRoot.exists() && webRoot.isDirectory()) {
    String[] apps = webRoot.list();
    if (null != apps && apps.length > 0) {
        for (String app : apps) {
            if (!"ROOT".equals(app)) {
                appName = app;
                break;
            }
        }
    }
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>MicroApp</title>
    <script type="text/javascript">
        <% if (null != appName) { %>
        windows.location="/<%=appName >"
        <% } %>
    </script>
</head>
<body>
</body>
</html>