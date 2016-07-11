<%@ page trimDirectiveWhitespaces="true" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<page:page jsContext="common" title="Bla">

    <div style="margin-top: 15px">

        <h3>Kreiranje foruma</h3>

        <s:url value="/forumSubmit" var="url"/>

        <form:form method="post" action="${url}" modelAttribute="forumForm" cssStyle="margin-top: 15px">

            <form:label path="forumName">Ime foruma</form:label>
            <form:input type="text" path="forumName"/>
            <form:errors path="forumName"/>

            <br/><br/>

            <form:input type="hidden" path="parentId"/>
            <input type="submit" value="<s:message code="ui.button.submitForum"/>"/>

        </form:form>
    </div>

</page:page>
