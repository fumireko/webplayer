package ca.fubi.player.models.dto;

import ca.fubi.player.models.enums.EnumRole;

public record CreateUserDTO (
	String username,
    String email,
    String password,
    EnumRole role
) {
    @Override
    public String toString() {
        return String.format("CreateUserDTO[username=%s, email=%s, password=%s, role=%s]", username, email, password, role);
    }
}
