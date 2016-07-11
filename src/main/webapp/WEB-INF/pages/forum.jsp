<%@ page pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags/components" %>


<page:page jsContext="common" title="${forum.name}">

    <div>
        <div class="forum-top-level ">
            <div class="forum-header">
                <div class="forum-name left">${forum.name}</div>
                <div class="commands right">
                    <sec:authorize access="hasAuthority('thread_create')">
                        <a class="icon" href="<s:url value="/threadCreate?forumId=${forum.id}"/>">
                            <img class="icon flip" src="<s:url value="/static/images/plus-black-64.png"/>"
                                 data-src-hover="<s:url value="/static/images/plus-white-64.png}"/>"/>
                        </a>
                    </sec:authorize>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="forum-list">
                <c:set var="topics" value="${pageData.content}"/>
                <sec:authorize access="hasAuthority('thread_lock')" var="canLockThread"/>
                <c:forEach items="${topics}" var="topic" varStatus="status">
                    <div class="sub-forum ${topic.deleted ? 'deleted' : ''} ${topic.locked ? 'locked' : ''}">
                        <div class="sub-forum-name left">
                            <a href="<s:url value="/thread/${topic.id}-${topic.name}"/>">${topic.name}</a>
                        </div>
                        <div class="commands right">
                            <sec:authorize access="hasAuthority('thread_edit')">

                            </sec:authorize>
                            <c:if test="${canLockThread}">
                                <a class="icon" href="<s:url value="/threadSetLocked?id=${topic.id}&locked=${!topic.locked}"/>">
                                    <img class="icon flip" src="<s:url value="/static/images/lock-black-64.png"/>"
                                         data-src-hover="<s:url value="/static/images/lock-white-64.png"/>"/>
                                </a>
                            </c:if>
                            <sec:authorize access="hasAuthority('thread_delete')">
                                <c:if test="${topic.deleted}">
                                    <s:url var="url" value="/threadRevive?id=${topic.id}&page=${pageData.number + 1}"/>
                                </c:if>
                                <c:if test="${not topic.deleted}">
                                    <s:url var="url" value="/threadDelete?id=${topic.id}&page=${pageData.number + 1}"/>
                                </c:if>
                                <a class="icon" href="${url}">
                                    <img class="icon flip" src="<s:url value="/static/images/trash-can-black-64.png"/>"
                                         data-src-hover="<s:url value="/static/images/trash-can-white-64.png"/>"/>
                                </a>
                            </sec:authorize>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </c:forEach>
            </div>

            <tags:pagination pageData="${pageData}" owner="${forum}" ownerName="forum"/>

        </div>

    </div>
</page:page>
