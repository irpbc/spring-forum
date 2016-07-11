<%@ tag trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags/components" %>


<nav class="main-nav">
    <a class="left" href="<s:url value="/"/>">
        <s:message code="ui.link.home"/>
    </a>
    <c:if test="${showAdminTools}">
        <menu class="menu left">
            <div class="menu-title">Admin tools</div>
            <ul class="menu-body">
                <sec:authorize access="hasAuthority('thread_see_deleted')">
                    <li>
                        <a href="<s:url value="/showDeletedThreads"/>">
                            <s:message code="${showDeletedThreads ? 'ui.link.hideDeletedThreads' : 'ui.link.showDeletedThreads'}"/>
                        </a>
                    </li>
                </sec:authorize>
                <sec:authorize access="hasAnyAuthority('post_see_deleted_any', 'post_see_deleted_own')">
                    <li>
                        <a href="<s:url value="/showDeletedPosts"/>">
                            <s:message code="${showDeletedPosts ? 'ui.link.hideDeletedPosts' : 'ui.link.showDeletedPosts'}"/>
                        </a>
                    </li>
                </sec:authorize>
            </ul>
        </menu>
    </c:if>

    <sec:authorize access="hasAuthority('admin_operations')">
        <a class="left" href="<s:url value="/adminPanel"/>">
            <s:message code="ui.link.adminPanel"/>
        </a>
    </sec:authorize>

    <menu class="menu right">
        <div class="menu-title">Users</div>
        <ul class="menu-body">
            <li>
                <a href="<s:url value="/users"/>">
                    List of all users
                </a>
            </li>
        </ul>
    </menu>

    <tags:loginMenu/>

    <div class="float-shelf"></div>
</nav>

<%--<nav class="navbar navbar-default">--%>
<%--<div class="container-fluid">--%>

<%--<!-- Collect the nav links, forms, and other content for toggling -->--%>
<%--<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">--%>
<%--<ul class="nav navbar-nav">--%>
<%--<li>--%>
<%--<a href="<s:url value="/"/>">--%>
<%--<s:message code="ui.link.home"/>--%>
<%--</a>--%>
<%--</li>--%>

<%--<sec:authorize access="hasAuthority('show_admin_tools')">--%>
<%--<li class="dropdown">--%>
<%--<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">--%>
<%--Admin tools <span class="caret"></span>--%>
<%--</a>--%>
<%--<ul class="dropdown-menu">--%>
<%--<sec:authorize access="hasAuthority('thread_see_deleted')">--%>
<%--<li>--%>
<%--<a href="<s:url value="/showDeletedThreads"/>">--%>
<%--<s:message code="${showDeletedThreads ? 'ui.link.hideDeletedThreads' : 'ui.link.showDeletedThreads'}"/>--%>
<%--</a>--%>
<%--</li>--%>
<%--</sec:authorize>--%>
<%--<sec:authorize access="hasAnyAuthority('post_see_deleted_any', 'post_see_deleted_own')">--%>
<%--<li>--%>
<%--<a href="<s:url value="/showDeletedPosts"/>">--%>
<%--<s:message code="${showDeletedPosts ? 'ui.link.hideDeletedPosts' : 'ui.link.showDeletedPosts'}"/>--%>
<%--</a>--%>
<%--</li>--%>
<%--</sec:authorize>--%>
<%--</ul>--%>
<%--</li>--%>
<%--</sec:authorize>--%>
<%--<sec:authorize access="hasAuthority('admin_operations')">--%>
<%--<li>--%>
<%--<a href="<s:url value="/adminPanel"/>">--%>
<%--<s:message code="ui.link.adminPanel"/>--%>
<%--</a>--%>
<%--</li>--%>
<%--</sec:authorize>--%>
<%--</ul>--%>
<%--<ul class="nav navbar-nav navbar-right">--%>
<%--<tags:loginMenu/>--%>
<%--<li class="dropdown">--%>
<%--<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">--%>
<%--Users <span class="caret"></span>--%>
<%--</a>--%>
<%--<ul class="dropdown-menu">--%>
<%--<li><a href="<s:url value="/users"/>">List of all users</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--</ul>--%>
<%--</div><!-- /.navbar-collapse -->--%>
<%--</div><!-- /.container-fluid -->--%>
<%--</nav>--%>

<%--<nav class="navbar navbar-default">--%>


<%--<menu class="menu right">--%>
<%--<div class="menu-title">Users</div>--%>
<%--<ul class="menu-body">--%>
<%--<li>--%>
<%--<a href="<s:url value="/users"/>">--%>
<%--List of all users--%>
<%--</a>--%>
<%--</li>--%>
<%--</ul>--%>
<%--</menu>--%>

<%--<tags:loginMenu/>--%>

<%--<div class="float-shelf"></div>--%>
<%--</nav>--%>
