package ca.fubi.player.user;

public record RecoveryJwtTokenDTO(
		String token,
		RecoveryUserDTO user) {}
