<%@ tag trimDirectiveWhitespaces="true" %>

<%@ attribute name="pageData" type="org.springframework.data.domain.Page" %>
<%@ attribute name="owner" type="java.lang.Object" rtexprvalue="true" %>
<%@ attribute name="ownerName" type="java.lang.String" rtexprvalue="true" %>


<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${pageData.totalPages gt 1}">

    <div class="paging">
        <c:if test="${not pageData.first}">
            <a href="<s:url value="/${ownerName}/${owner.id}-${owner.name}/page-1"/>">
                <s:message code="page.first"/>
            </a>
            <a href="<s:url value="/${ownerName}/${owner.id}-${owner.name}/page-${pageData.number}"/>">
                <s:message code="page.prev"/>
            </a>
        </c:if>

        <c:forEach begin="0" end="${pageData.totalPages - 1}" var="index">
            <c:if test="${index ne pageData.number}">
                <a href="<s:url value="/${ownerName}/${owner.id}-${owner.name}/page-${index + 1}"/>">${index + 1}</a>
            </c:if>
            <c:if test="${index eq pageData.number}">
                <span>${index + 1}</span>
            </c:if>
        </c:forEach>

        <c:if test="${not pageData.last}">
            <a href="<s:url value="/${ownerName}/${owner.id}-${owner.name}/page-${pageData.number + 2}"/>">
                <s:message code="page.next"/>
            </a>
            <a href="<s:url value="/${ownerName}/${owner.id}-${owner.name}/page-${pageData.totalPages}"/>">
                <s:message code="page.last"/>
            </a>
        </c:if>
    </div>

</c:if>