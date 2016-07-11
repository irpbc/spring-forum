<%@ page pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<s:message code="general.indexPageTitle" var="title"/>

<page:page jsContext="common" title="${title}">

    <div>
        <c:forEach items="${forums}" var="forum" varStatus="status">

            <div class="forum-top-level ${status.first ? 'first' : ''}">
                <div class="forum-header">
                    <div class="forum-name left">${forum.name}</div>
                    <div class="commands right">

                        <sec:authorize access="hasAuthority('forum_edit')">
                            <c:if test="${not status.first}">
                                <a class="icon" href="<s:url value="/forumRaise?id=${forum.id}"/>">
                                    <img class="icon flip" src="<s:url value="/static/images/up-black-64.png"/>"
                                         data-src-hover="<s:url value="/static/images/up-white-64.png"/>"/>
                                </a>
                            </c:if>
                            <c:if test="${not status.last}">
                                <a class="icon" href="<s:url value="/forumLower?id=${forum.id}"/>">
                                    <img class="icon flip" src="<s:url value="/static/images/down-arrow-black-64.png"/>"
                                         data-src-hover="<s:url value="/static/images/down-arrow-white-64.png"/>"/>
                                </a>
                            </c:if>
                            <a class="icon" href="<s:url value="/forumCreate?parentId=${forum.id}"/>">
                                <img class="icon flip" src="<s:url value="/static/images/plus-black-64.png"/>"
                                     data-src-hover="<s:url value="/static/images/plus-white-64.png"/>"/>
                            </a>
                        </sec:authorize>

                        <sec:authorize access="hasAuthority('forum_delete')">
                            <a class="icon" href="<s:url value="/forumDelete?id=${forum.id}"/>">
                                <img class="icon flip" src="<s:url value="/static/images/trash-can-black-64.png"/>"
                                     data-src-hover="<s:url value="/static/images/trash-can-white-64.png}"/>"/>
                            </a>
                        </sec:authorize>

                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="forum-list">
                    <c:forEach items="${forum.subForums}" var="subForum" varStatus="status">

                        <div class="sub-forum">
                            <div class="sub-forum-name left">
                                <a href="<s:url value="/forum/${subForum.id}-${subForum.name}"/>">${subForum.name}</a>
                            </div>
                            <div class="commands right">
                                <sec:authorize access="hasAuthority('forum_edit')">
                                    <c:if test="${not status.first}">
                                        <a class="icon" href="<s:url value="/forumRaise?id=${subForum.id}"/>">
                                            <img class="icon flip" src="<s:url value="/static/images/up-black-64.png"/>"
                                                 data-src-hover="<s:url value="/static/images/up-white-64.png"/>"/>
                                        </a>
                                    </c:if>
                                    <c:if test="${not status.last}">
                                        <a class="icon" href="<s:url value="/forumLower?id=${subForum.id}"/>">
                                            <img class="icon flip"
                                                 src="<s:url value="/static/images/down-arrow-black-64.png"/>"
                                                 data-src-hover="<s:url value="/static/images/down-arrow-white-64.png"/>"/>
                                        </a>
                                    </c:if>
                                </sec:authorize>
                                <sec:authorize access="hasAuthority('forum_delete')">
                                    <a class="icon" href="<s:url value="/forumDelete?id=${subForum.id}"/>">
                                        <img class="icon flip"
                                             src="<s:url value="/static/images/trash-can-black-64.png"/>"
                                             data-src-hover="<s:url value="/static/images/trash-can-white-64.png}"/>"/>
                                    </a>
                                </sec:authorize>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>
        <div>
            <sec:authorize access="hasAuthority('forum_create')">
                <div class="commands right">
                    <a class="icon" href="<s:url value="/forumCreate?parentId=0"/>">
                        <img class="icon flip"
                             src="<s:url value="/static/images/plus-black-64.png"/>"
                             data-src-hover="<s:url value="/static/images/plus-white-64.png"/>"/>
                    </a>
                </div>
            </sec:authorize>
            <div class="clearfix"></div>
        </div>
    </div>

</page:page>
