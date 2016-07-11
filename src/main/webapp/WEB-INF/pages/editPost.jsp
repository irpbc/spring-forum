<%@ page pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<page:page jsContext="common" title="Bla">

    <div>
        <s:url value="/postEditSubmit" var="url"/>
        <form:form modelAttribute="editPostForm" method="post" action="${url}">

            <form:textarea path="text" class="post-input" />
            <form:errors path="text"/>
            <br/><br/>

            <form:hidden path="postId"/>
            <form:hidden path="threadId"/>

            <input type="submit" value="<s:message code="ui.button.submitEditPost"/>"/>

        </form:form>
    </div>

</page:page>
