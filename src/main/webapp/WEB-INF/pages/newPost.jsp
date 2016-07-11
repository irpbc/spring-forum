<%@ page trimDirectiveWhitespaces="true" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<page:page jsContext="common" title="Bla">

    <div style="margin-top: 15px">
        <s:url value="/postSubmit" var="url"/>
        <form:form modelAttribute="postForm" method="post" action="${url}">

            <form:textarea class="post-input" path="text"/>
            <form:errors path="text"/>

            <br/><br/>

            <form:input type="hidden" path="threadId"/>
            <input type="submit" value="<s:message code="ui.button.submitPost"/>"/>

        </form:form>
    </div>

</page:page>
