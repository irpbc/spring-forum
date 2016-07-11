package sforum.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sforum.model.Role;
import sforum.repository.ConfigRepository;
import sforum.repository.RoleRepository;

import javax.annotation.PostConstruct;

@Service
public class ConfigurationService {

	@Autowired
	ConfigRepository configRepository;

	@Autowired
	RoleRepository roleRepository;

	private String rootPassword;

	private int postsPageSize;
	private int threadsPageSize;

	@PostConstruct
	public void initProperties() {
		rootPassword = configRepository.findOne("rootPassword").getValue();
		postsPageSize = Integer.parseInt(configRepository.findOne("postsPageSize").getValue());
		threadsPageSize = Integer.parseInt(configRepository.findOne("threadsPageSize").getValue());
	}

	public Role getStartingRole() {
		return roleRepository.findOneByCode("noob");
	}

	public String getRootPassword() {
		return rootPassword;
	}

	public int getPostsPageSize() {
		return postsPageSize;
	}

	public int getThreadsPageSize() {
		return threadsPageSize;
	}
}
