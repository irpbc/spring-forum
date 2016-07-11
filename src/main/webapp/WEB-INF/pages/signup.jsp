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

        <h3>Registracija</h3>

        <s:url value="/signup" var="url"/>
        <form:form action="${url}" method="post" modelAttribute="signupForm" cssStyle="margin-top: 15px">

            <table>
                <tbody>
                <tr>
                    <td>
                        <form:label path="username">
                            <s:message code="login.username"/>
                        </form:label>
                    </td>
                    <td><form:input type="text" path="username"/></td>
                    <td><form:errors path="username"/></td>
                </tr>
                <tr>
                    <td>
                        <form:label path="password">
                            <s:message code="login.password"/>
                        </form:label>
                    </td>
                    <td><form:input type="text" path="password"/></td>
                    <td><form:errors path="password"/></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="submit" value="<s:message code="login.login"/>"/>
                    </td>
                </tr>
                </tbody>
            </table>

        </form:form>
    </div>

</page:page>
