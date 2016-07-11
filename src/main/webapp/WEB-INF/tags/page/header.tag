<%@ tag trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="page-header">
    <div class="title">
        <!--<img class="logo" th:src="@{/static/images/logoGray.png}" width="80"
                 th:attr="data-src-hover=@{/static/images/logoColor.png}"/>-->
        <div class="title-text">
            <s:message code="general.forumName"/>
        </div>
    </div>
    <div class="subtitle">
        <s:message code="general.underConstruction"/>
    </div>
    <div class="float-shelf"></div>
</div>