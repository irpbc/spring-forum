package sforum.beans;

import org.springframework.beans.factory.DisposableBean;
import sforum.model.User;
import sforum.repository.PermissionRepository;
import sforum.repository.UserRepository;
import sforum.security.PermissionConstants;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.util.Arrays;


public class SessionData implements Externalizable, DisposableBean {

	@Inject
	private UserRepository userRepository;

	@Inject
	private PermissionRepository permissionRepository;

	@Inject
	private Application app;

	private User currentUser;
	private boolean showDeletedThreads;
	private boolean showAllDeletedPosts;
	private boolean showOwnDeletedPosts;

	private boolean editOwnPosts;
	private boolean editAllPosts;
	private boolean deleteAllPosts;
	private boolean deleteOwnPosts;
	private boolean reviveAllPosts;
	private boolean reviveOwnPosts;
	private boolean showAdminTools;
	private boolean lockThreads;

	@PostConstruct
	public void init() {
		synchronized (app) {
			app.unregisteredUsers++;
		}
	}

	@Override
	public void destroy() throws Exception {
		synchronized (app) {
			if (currentUser == null) {
				app.unregisteredUsers--;
			}
		}
	}

	public void setCurrentUser(final User currentUser) {
		this.currentUser = currentUser;

		this.lockThreads = permissionRepository.userHasPermission(currentUser, PermissionConstants.THREAD_LOCK);
		this.editOwnPosts = permissionRepository.userHasPermission(currentUser, PermissionConstants.POST_EDIT_OWN);
		this.editAllPosts = permissionRepository.userHasPermission(currentUser, PermissionConstants.POST_EDIT_ANY);
		this.deleteOwnPosts = permissionRepository.userHasPermission(currentUser, PermissionConstants.POST_DELETE_OWN);
		this.deleteAllPosts = permissionRepository.userHasPermission(currentUser, PermissionConstants.POST_DELETE_ANY);
		this.reviveOwnPosts = permissionRepository.userHasPermission(currentUser, PermissionConstants.POST_REVIVE_OWN);
		this.reviveAllPosts = permissionRepository.userHasPermission(currentUser, PermissionConstants.POST_REVIVE_ANY);
		this.showAdminTools = permissionRepository.userHasAnyPermission(currentUser,
			  Arrays.asList(PermissionConstants.THREAD_SEE_DELETED, PermissionConstants.POST_SEE_DELETED_ANY, PermissionConstants.POST_SEE_DELETED_OWN));
	}

	public void reset() {
		currentUser = null;
		lockThreads = false;
		showAllDeletedPosts = false;
		showOwnDeletedPosts = false;
		showDeletedThreads = false;
		editAllPosts = false;
		editOwnPosts = false;
		deleteAllPosts = false;
		deleteOwnPosts = false;
		reviveOwnPosts = false;
		reviveAllPosts = false;
		showAdminTools = false;
	}

	@Override
	public void writeExternal(final ObjectOutput out) throws IOException {
		if (currentUser != null) {
			out.writeBoolean(true);
			out.writeLong(currentUser.getId());
		} else {
			out.writeBoolean(false);
		}
		out.writeBoolean(showAllDeletedPosts);
		out.writeBoolean(showOwnDeletedPosts);
		out.writeBoolean(showDeletedThreads);
		out.writeBoolean(editAllPosts);
		out.writeBoolean(editOwnPosts);
		out.writeBoolean(deleteAllPosts);
		out.writeBoolean(deleteOwnPosts);
		out.writeBoolean(reviveAllPosts);
		out.writeBoolean(reviveOwnPosts);
		out.writeBoolean(showAdminTools);
		out.writeBoolean(lockThreads);
	}

	@Override
	public void readExternal(final ObjectInput in) throws IOException, ClassNotFoundException {
		final boolean hasUser = in.readBoolean();
		if (hasUser) {
			setCurrentUser(userRepository.findOne(in.readLong()));
		}
		showAllDeletedPosts = in.readBoolean();
		showOwnDeletedPosts = in.readBoolean();
		showDeletedThreads = in.readBoolean();
		editAllPosts = in.readBoolean();
		editOwnPosts = in.readBoolean();
		deleteAllPosts = in.readBoolean();
		deleteOwnPosts = in.readBoolean();
		reviveAllPosts = in.readBoolean();
		reviveOwnPosts = in.readBoolean();
		showAdminTools = in.readBoolean();
		lockThreads = in.readBoolean();
	}

	public User getCurrentUser() {
		return currentUser;
	}

	public boolean isDeleteAllPosts() {
		return deleteAllPosts;
	}

	public boolean isDeleteOwnPosts() {
		return deleteOwnPosts;
	}

	public boolean isShowAllDeletedPosts() {
		return showAllDeletedPosts;
	}

	public void setShowAllDeletedPosts(final boolean showAllDeletedPosts) {
		this.showAllDeletedPosts = showAllDeletedPosts;
	}

	public boolean isShowOwnDeletedPosts() {
		return showOwnDeletedPosts;
	}

	public void setShowOwnDeletedPosts(final boolean showOwnDeletedPosts) {
		this.showOwnDeletedPosts = showOwnDeletedPosts;
	}

	public boolean isShowDeletedThreads() {
		return showDeletedThreads;
	}

	public void setShowDeletedThreads(final boolean showDeletedThreads) {
		this.showDeletedThreads = showDeletedThreads;
	}

	public boolean isEditOwnPosts() {
		return editOwnPosts;
	}

	public void setEditOwnPosts(final boolean editOwnPosts) {
		this.editOwnPosts = editOwnPosts;
	}

	public boolean isEditAllPosts() {
		return editAllPosts;
	}

	public void setEditAllPosts(final boolean editAllPosts) {
		this.editAllPosts = editAllPosts;
	}

	public boolean isReviveAllPosts() {
		return reviveAllPosts;
	}

	public boolean isReviveOwnPosts() {
		return reviveOwnPosts;
	}

	public boolean isShowAdminTools() {
		return showAdminTools;
	}

	public boolean isLockThreads() {
		return lockThreads;
	}
}
