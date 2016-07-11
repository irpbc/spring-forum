<%@ page trimDirectiveWhitespaces="true" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<s:message code="general.forumName" var="pageTitle"/>

<page:page jsContext="adminPanel" title="${pageTitle}">

    <s:url value="/admin" var="adminUrl"/>

    <h3 class="admin-section"><s:message code="ui.label.admin.operations"/></h3>
    <div class="admin-operations" style="border-bottom: 1px solid gray; padding-bottom: 10px">
        <form class="ajax-command" action="${adminUrl}/recountPostsForUsers" method="get">
            <input type="submit" value="<s:message code="ui.button.admin.recountPostsForUsers"/>"/>
            <label><s:message code="ui.label.admin.userId"/></label>
            <input type="number" name="userId"/>
            <label class="message"></label>
        </form>
        <form class="ajax-command" action="${adminUrl}/recountPostsForThreads" method="get">
            <input type="submit" value="<s:message code="ui.button.admin.recountPostsForThreads"/>"/>
            <label><s:message code="ui.label.admin.userId"/></label>
            <input type="number" name="threadId"/>
            <label class="message"></label>
        </form>
        <form class="ajax-command" action="${adminUrl}/recountPostsForForums" method="get">
            <input type="submit" value="<s:message code="ui.button.admin.recountPostsForForums"/>"/>
            <label><s:message code="ui.label.admin.threadId"/></label>
            <input type="number" name="forumId"/>
            <label class="message"></label>
        </form>
        <form class="ajax-command" action="${adminUrl}/recountThreads" method="get">
            <input type="submit" value="<s:message code="ui.button.admin.recountThreads"/>"/>
            <label><s:message code="ui.label.admin.forumId"/></label>
            <input type="number" name="forumId"/>
            <label class="message"></label>
        </form>
        <form class="ajax-command" action="${adminUrl}/logoutUser" method="get">
            <input type="submit" value="<s:message code="ui.button.admin.logoutUser"/>"/>
            <label><s:message code="ui.label.admin.userId"/></label>
            <input type="number" name="userId"/>
            <label class="message"></label>
        </form>
    </div>
    <h3 class="admin-section"><s:message code="ui.label.admin.roles"/></h3>
    <div class="roles" style="border-bottom: 1px solid gray; padding-bottom: 10px">
        <c:forEach items="${roles}" var="role">
            <p class="role">
                <a href="${adminUrl}/role?roleId=${role.id}">${role.name}</a>
            </p>
        </c:forEach>
    </div>
    <h3 class="admin-section">Dodaj ulogu</h3>
    <form:form modelAttribute="roleForm" action="${adminUrl}/addRole" method="post">

        <form:label path="code"><s:message code="ui.label.admin.roleId"/></form:label>
        <form:input path="code" type="text"/>
        <form:errors path="code"/><br/> <br/>

        <form:label path="name"><s:message code="ui.label.admin.roleName"/></form:label>
        <form:input path="name" type="text" />
        <form:errors path="name"/> <br/>  <br/>

        <input type="submit" value="<s:message code="ui.button.admin.addRole"/>"/>
        <form:errors />
    </form:form>

</page:page>
