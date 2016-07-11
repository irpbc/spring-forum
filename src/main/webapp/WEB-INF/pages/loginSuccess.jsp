<%@ page pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="time" uri="http://sargue.net/jsptags/time" %>

<s:message code="login.signup" var="pageTitle"/>

<page:page title="${pageTitle}">

    <div style="margin-top: 15px">
        <h3 style="text-align: center"> Uspešno ste se ulogovali na forum </h3>
    </div>

    <script type="text/javascript">
        <%--window.setTimeout(function() {--%>
            <%--window.location.href = "${referer}";--%>
        <%--}, 2000)--%>
    </script>

</page:page>
