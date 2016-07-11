<%@ page pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="time" uri="http://sargue.net/jsptags/time" %>

<s:message code="page.title.users" var="pageTitle"/>

<page:page jsContext="common" title="${pageTitle}">
    <div>
        <table class="users-table">
            <thead>
            <tr>
                <th><s:message code="users.table.username"/></th>
                <th><s:message code="users.table.joinDate"/></th>
                <th><s:message code="users.table.birthDate"/></th>
                <th><s:message code="users.table.age"/></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${users}" var="user">
                <tr>
                    <td><a href="<s:url value="/users/${user.id}"/>"> ${user.username} </a></td>
                    <td> <time:format value="${user.joinDate}"/> </td>
                    <td> ${user.dateOfBirth} </td>
                    <td> ${user.age} </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</page:page>
