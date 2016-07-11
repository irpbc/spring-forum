<%@ page pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="time" uri="http://sargue.net/jsptags/time" %>

<page:page jsContext="adminPanel">

    <div>
        <h3 class="admin-section">
            <s:message code="ui.label.admin.role" arguments="${role.name}"/>
        </h3>
        <div class="admin-operations">
            <table class="users-table">
                <tbody>
                <c:forEach items="${role.permissions}" var="permission">
                    <tr>
                        <td>${permission.name}</td>
                        <td>
                            <s:url value="${permission.active ? '/admin/removePermission' : '/admin/addPermission'}" var="editUrl"/>
                            <s:message code="${permission.active ? 'ui.button.admin.removePermission' : 'ui.button.admin.addPermission'}" var="editMessage"/>
                            <form class="ajax-command permission" action="${editUrl}" method="post">
                                <span></span>
                                <input type="submit" value="${editMessage}"/>
                                <label class="message"></label>
                                <input type="hidden" name="roleId" value="${role.id}"/>
                                <input type="hidden" name="permissionId" value="${permission.id}"/>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</page:page>

