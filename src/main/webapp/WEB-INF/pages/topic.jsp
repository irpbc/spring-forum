<%@ page pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags/components" %>
<%@ taglib prefix="time" uri="http://sargue.net/jsptags/time" %>

<jsp:useBean id="topic" scope="request" type="sforum.web.dto.TopicDTO"/>

<s:message code="page.title.topic" arguments="${topic.name}" var="pageTitle"/>

<page:page jsContext="common" title="${pageTitle}">


    <div>

        <div class="forum-top-level ">
            <div class="forum-header ${topic.locked ? 'locked' : ''}">
                <div class="forum-name left">${topic.name}</div>
                <div class="commands right">
                    <sec:authorize access="hasAuthority('thread_lock')" var="canLockThread"/>
                    <sec:authorize access="hasAuthority('post_create')">
                        <c:if test="${!topic.locked or canLockThread}">
                            <a class="icon" href="<s:url value="/postCreate?threadId=${topic.id}"/>">
                                <img class="icon flip" src="<s:url value="/static/images/note-symbol-black-64.png"/>"
                                     data-src-hover="<s:url value="/static/images/note-symbol-white-64.png"/>"/>
                            </a>
                        </c:if>
                    </sec:authorize>
                    <c:if test="${canLockThread}">
                        <a class="icon" href="<s:url value="/threadSetLocked?id=${topic.id}&locked=${!topic.locked}"/>">
                            <img class="icon flip" src="<s:url value="/static/images/lock-black-64.png"/>"
                                 data-src-hover="<s:url value="/static/images/lock-white-64.png"/>"/>
                        </a>
                    </c:if>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="forum-list">
                <c:set var="pageData" value="${topic.postsPage}"/>
                <c:set var="pageStart" value="${(pageData.number) * pageData.size}"/>
                <table class="post-table">
                    <tbody>
                    <c:forEach items="${pageData.content}" var="post" varStatus="status">

                        <tr class="post-header ${post.deleted ? 'deleted' : ''}" id="${post.id}">
                            <td class="post-date"><time:format value="${post.timestamp}"/></td>
                            <td class="post-link">
                                <a href="<s:url value="/thread/${topic.id}-${topic.name}/page-${pageData.number + 1}#${post.id}"/>"> #${pageStart + status.count} </a>
                            </td>
                        </tr>
                        <tr class="post ${post.deleted ? 'deleted' : ''}">
                            <td class="post-user">
                                <div class="post-user-name">
                                    <a href="<s:url value="/users/${post.user.id}"/>">${post.user.username}</a>
                                </div>
                                <div class="post-user-info">
                                    <c:if test="${post.user.loggedIn}">
                                        <p><s:message code="users.infoBox.online"/></p>
                                    </c:if>
                                    <time:format value="${post.user.joinDate}" var="joinDate"/>
                                    <p><s:message code="users.infoBox.onForumSince"/> ${joinDate}</p>
                                    <p><s:message code="users.infoBox.postCount" arguments="${post.user.postCount}"/></p>
                                </div>
                            </td>
                            <td class="post-body">
                                <div class="post-text"> ${post.text} </div>
                                <div class="post-tools">
                                    <div class="commands right">
                                        <c:if test="${post.editable}">
                                            <a class="icon" href="<s:url value="/postEdit?id=${post.id}&threadId=${topic.id}"/>">
                                                <img class="icon flip" src="<s:url value="/static/images/note-symbol-black-64.png"/>"
                                                     data-src-hover="<s:url value="/static/images/note-symbol-white-64.png"/>"/>
                                            </a>
                                        </c:if>
                                        <c:if test="${post.deletable}">
                                            <c:if test="${not post.deleted}">
                                                <a class="icon" href="<s:url value="/postDelete?id=${post.id}"/>">
                                                    <img class="icon flip" src="<s:url value="/static/images/trash-can-black-64.png"/>"
                                                         data-src-hover="<s:url value="/static/images/trash-can-white-64.png"/>"/>
                                                </a>
                                            </c:if>
                                            <c:if test="${post.deleted}">
                                                <a class="icon" href="<s:url value="/postRevive?id=${post.id}"/>">
                                                    <img class="icon flip" src="<s:url value="/static/images/trash-can-black-64.png"/>"
                                                         data-src-hover="<s:url value="/static/images/trash-can-white-64.png"/>"/>
                                                </a>
                                            </c:if>
                                        </c:if>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <tags:pagination pageData="${pageData}" owner="${topic}" ownerName="thread"/>

            </div>
        </div>

    </div>
</page:page>
