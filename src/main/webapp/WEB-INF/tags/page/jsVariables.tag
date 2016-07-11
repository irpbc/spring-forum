<%@ tag trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

    window.Msg = {
	    username:				"<s:message code="login.username"/>",
	    adminCommandWorking:	"<s:message code="ui.label.admin.working"/>",
    	adminCommandDone:		"<s:message code="ui.label.admin.done"/>",
    	adminCommandError:		"<s:message code="ui.label.admin.error"/>",
    	permissionAssign:		"<s:message code="ui.button.admin.addPermission"/>",
    	permissionRemove:		"<s:message code="ui.button.admin.removePermission"/>"
    };

    window.URLs = {
    	addPermission:			"<s:url value="/admin/addPermission"/>",
    	removePermission:		"<s:url value="/admin/removePermission"/>"
    };

</script>
