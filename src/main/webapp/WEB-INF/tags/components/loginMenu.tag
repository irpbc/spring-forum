<%@ tag trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--<c:if test="${userIsLoggedIn}">--%>
<%--<li>--%>
<%--<s:message code="login.loggedintext" arguments="${username}"/>--%>
<%--</li>--%>
<%--</c:if>--%>
<%--<c:if test="${not userIsLoggedIn}">--%>
<%--<li class="dropdown">--%>
<%--<a href="#" class="dropdown-toggle" data-toggle="dropdown">--%>
<%--<s:message code="login.login"/>--%>
<%--</a>--%>
<%--<div class="dropdown-menu">--%>
<%--<form class="login-box menu-body stay-open" method="POST" action="<s:url value="/login"/>">--%>
<%--<input type="hidden" name="fromLoginPage" value="false"/>--%>
<%--<table>--%>
<%--<tbody>--%>
<%--<tr>--%>
<%--<td><s:message code="login.username"/></td>--%>
<%--<td><input type="text" name="username"/></td>--%>
<%--</tr>--%>
<%--<tr>--%>
<%--<td><s:message code="login.password"/></td>--%>
<%--<td><input type="text" name="password"/></td>--%>
<%--</tr>--%>
<%--<tr>--%>
<%--<td></td>--%>
<%--<td>--%>
<%--<input type="submit" value="<s:message code="login.login"/>"/>--%>
<%--<a href="<s:url value="/signup"/>">--%>
<%--<s:message code="login.signup"/>--%>
<%--</a>--%>
<%--</td>--%>
<%--</tr>--%>
<%--</tbody>--%>
<%--</table>--%>
<%--</form>--%>
<%--</div>--%>
<%--</li>--%>
<%--</c:if>--%>

<menu class="menu right">

    <div class="menu-title">
        <c:if test="${userIsLoggedIn}">
            <s:message code="login.loggedintext" arguments="${username}"/>
        </c:if>
        <c:if test="${not userIsLoggedIn}">
            <s:message code="login.login"/>
        </c:if>
    </div>
    <c:if test="${not userIsLoggedIn}">
        <form class="login-box menu-body stay-open" method="POST" action="<s:url value="/login"/>">
            <input type="hidden" name="fromLoginPage" value="false"/>
            <table>
                <tbody>
                <tr>
                    <td><s:message code="login.username"/></td>
                    <td><input type="text" name="username"/></td>
                </tr>
                <tr>
                    <td><s:message code="login.password"/></td>
                    <td><input type="text" name="password"/></td>
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
                </tbody>
            </table>
        </form>
    </c:if>

    <c:if test="${userIsLoggedIn}">
        <ul class="menu-body">
            <li>
                <a href="<s:url value="/user?id=${userId}"/>">
                    <s:message code="ui.link.userProfile"/>
                </a>
            </li>
            <li>
                <a href="<s:url value="/logout"/>"><s:message code="login.logout"/></a>
            </li>
        </ul>
    </c:if>

</menu>
