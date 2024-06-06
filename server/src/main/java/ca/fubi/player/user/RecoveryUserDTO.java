package ca.fubi.player.user;

import java.util.Set;

import ca.fubi.player.role.Role;

public record RecoveryUserDTO(
		Long id,
		String username,
		String email,
		Set<Role> roles) {}
