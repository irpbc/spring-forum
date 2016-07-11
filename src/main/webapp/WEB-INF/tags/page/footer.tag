<%@ tag trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="footer">

    <div>
        <p><s:message code="users.homePage.usersOnline"
                      arguments="${totalUsers},${loggedInUsers.size()},${visitors}"/></p>

        <p>
            <c:forEach items="${loggedInUsers}" var="user">
                <a href="<s:url value="/users/${user.userId}"/>">${user.username}</a>
            </c:forEach>
        </p>
    </div>

</footer>