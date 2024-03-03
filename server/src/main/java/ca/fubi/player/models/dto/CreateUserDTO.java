package ca.fubi.player.models.dto;

import ca.fubi.player.models.enums.EnumRole;

public record CreateUserDTO (
		String email,
		String password,
		EnumRole role
){}
