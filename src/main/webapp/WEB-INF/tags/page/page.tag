<%@ tag trimDirectiveWhitespaces="true" %>

<%@ attribute name="title" type="java.lang.String" %>
<%@ attribute name="jsContext" %>
<%@ attribute name="pageContent" fragment="true" %>

<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags/components" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <%--<link rel="stylesheet" lang="text/css" href="<s:url value="/static/css/bootstrap.min.css"/>"/>--%>
    <%--<link rel="stylesheet" lang="text/css" href="<s:url value="/static/css/bootstrap-theme.min.css"/>"/>--%>
    <link rel="stylesheet" lang="text/css" href="<s:url value="/static/css/style.css"/>"/>
    <c:if test="${empty title}">
        <title><s:message code="general.forumName"/></title>
    </c:if>
    <c:if test="${not empty title}">
        <title>${title}</title>
    </c:if>
    <script type="text/javascript">
        window.appContext = "${empty jsContext ? 'common' : jsContext}";
    </script>
</head>
<body>

<page:header/>

<page:navigation/>

<jsp:doBody/>

<page:footer/>

<page:javaScript/>

</body>
</html>
