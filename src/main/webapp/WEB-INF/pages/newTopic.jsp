<%@ page pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="time" uri="http://sargue.net/jsptags/time" %>

<page:page jsContext="common" title="Bla">

    <h3 style="margin-top: 15px">Nova tema</h3>

    <div style="margin-top: 15px">
        <s:url value="/threadSubmit" var="url"/>
        <form:form method="post" action="${url}" modelAttribute="threadForm">

            <form:label path="title">Naslov teme</form:label>
            <form:input path="title" type="text"/>
            <form:errors path="title"/>

            <br/><br/>

            <form:label path="firstPostText"> Tekst prve poruke </form:label> <br/><br/>
            <form:textarea path="firstPostText" class="post-input"/> <br/>
            <form:errors path="firstPostText"/>

            <br/><br/>

            <form:input path="forumId" type="hidden"/>
            <input type="submit" value="<s:message code="ui.button.submitPost"/>"/>

            <br/> <br/>

            <form:errors/>

        </form:form>
    </div>
</page:page>
