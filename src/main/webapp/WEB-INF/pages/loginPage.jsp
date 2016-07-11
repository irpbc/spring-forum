<%@ page trimDirectiveWhitespaces="true" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<s:message code="general.forumName" var="pageTitle"/>

<page:page jsContext="common" title="${pageTitle}">

    <s:url value="/login" var="postUrl"/>

    <form:form method="POST" action="${postUrl}" modelAttribute="loginForm" cssStyle="margin-top: 15px;">

        <div style="margin-bottom: 10px;">
            <form:errors/>
        </div>

        <table cellspacing="4">
            <tr>
                <td><form:label path="username"> <s:message code="login.username"/> </form:label></td>
                <td><form:input type="text" path="username"/></td>
                <td><form:errors path="username"/></td>
            </tr>
            <tr>
                <td><form:label path="password"> <s:message code="login.password"/> </form:label></td>
                <td><form:input type="text" path="password"/></td>
                <td><form:errors path="password"/></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <input type="submit" value="<s:message code="login.login"/>"/>
                    <a href="<s:url value="/signup"/>">
                        <s:message code="login.signup"/>
                    </a>
                </td>
            </tr>
        </table>
    </form:form>

</page:page>
