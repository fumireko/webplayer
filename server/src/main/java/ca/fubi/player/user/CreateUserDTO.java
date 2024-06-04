package ca.fubi.player.user;

import ca.fubi.player.role.EnumRole;

public record CreateUserDTO(
		String username,
		String email,
		String password,
		EnumRole role) {}
