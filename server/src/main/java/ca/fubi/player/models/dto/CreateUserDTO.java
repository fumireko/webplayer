package ca.fubi.player.models.dto;

import java.util.Set;

import ca.fubi.player.models.Role;
import ca.fubi.player.models.enums.EnumRole;

public record CreateUserDTO (
        String username,
        String email,
        String password,
        Set<Role> roles
) {
    public CreateUserDTO {
    	System.out.println(this.toString());
        if (username == null || username.isEmpty()) {
            throw new IllegalArgumentException("Username cannot be null or empty");
        }
        if (email == null || email.isEmpty()) {
            throw new IllegalArgumentException("Email cannot be null or empty");
        }
        if (password == null || password.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty");
        }
        if (roles == null) {
            throw new IllegalArgumentException("Role cannot be null");
        }
    }

    @Override
    public String toString() {
        return String.format("CreateUserDTO[username=%s, email=%s, password=%s, role=%s]", username, email, password, roles);
    }
}
