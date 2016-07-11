package sforum.security;

/**
 * Created by @ivan.
 */
public final class PermissionConstants {

	public static final String ADMIN_OPERATIONS = "admin_operations";
	public static final String FORUM_CREATE = "forum_create";
	public static final String FORUM_DELETE = "forum_delete";
	public static final String FORUM_EDIT = "forum_edit";
	public static final String POST_CREATE = "post_create";
	public static final String POST_DELETE_OWN = "post_delete_own";
	public static final String POST_DELETE_ANY = "post_delete_any";
	public static final String POST_EDIT_OWN = "post_edit_own";
	public static final String POST_EDIT_ANY = "post_edit_any";
	public static final String POST_MOVE = "post_move";
	public static final String POST_REVIVE_OWN = "post_revive_own";
	public static final String POST_REVIVE_ANY = "post_revive_any";
	public static final String POST_SEE_DELETED_OWN = "post_see_deleted_own";
	public static final String POST_SEE_DELETED_ANY = "post_see_deleted_any";
	public static final String USER_CHANGE_ROLE = "user_change_role";
	public static final String ROLE_CHANGE_PERMISSIONS = "role_change_permissions";
	public static final String THREAD_CREATE = "thread_create";
	public static final String THREAD_DELETE = "thread_delete";
	public static final String THREAD_REVIVE = "thread_revive";
	public static final String THREAD_EDIT = "thread_edit";
	public static final String THREAD_LOCK = "thread_lock";
	public static final String THREAD_MOVE = "thread_move";
	public static final String THREAD_SEE_DELETED = "thread_see_deleted";

	private PermissionConstants() {
	}
}
