<%@ page pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="time" uri="http://sargue.net/jsptags/time" %>

<s:message code="page.title.users" var="pageTitle"/>

<page:page jsContext="userPage" title="${pageTitle}">

    <div>

        <table class="users-table">
            <tbody>
            <tr>
                <td><s:message code="users.table.username"/></td>
                <td> ${user.username} </td>
            </tr>
            <tr>
                <td><s:message code="users.table.role"/></td>
                <sec:authorize access="hasAuthority('user_change_role')" var="canChangeRole"/>
                <c:if test="${not canChangeRole}">
                    <td> ${user.role.name} </td>
                </c:if>
                <c:if test="${canChangeRole}">
                    <td>
                        <form class="ajax-command" action="<s:url value="/admin/setUserRole"/>" method="get">
                            <select name="roleId">
                                <c:forEach items="${roles}" var="role">
                                    <option value="${role.id}"
                                        ${user.role.id eq role.id ? 'selected="selected"' : ''}">
                                        ${role.name}
                                    </option>
                                </c:forEach>
                            </select>
                            <input type="hidden" name="userId" value="${user.id}"/>
                            <input type="submit" value="Change"/>
                            <label class="message"></label>
                        </form>
                    </td>
                </c:if>
            </tr>
            <tr>
                <td><s:message code="users.table.joinDate"/></td>
                <td> ${user.joinDate} </td>
            </tr>
            <tr>
                <td><s:message code="users.table.birthDate"/></td>
                <td> ${user.dateOfBirth} </td>
            </tr>
            <c:if test="${not empty userAge}">
                <tr>
                    <td><s:message code="users.table.age"/></td>
                    <td> ${userAge} </td>
                </tr>
            </c:if>
            <tr>
                <td><s:message code="users.table.postCount"/></td>
                <td> ${user.postCount} </td>
            </tr>
            </tbody>
        </table>

    </div>
</page:page>
