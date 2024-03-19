package ca.fubi.player.user;

import java.util.List;

import ca.fubi.player.role.Role;

public record RecoveryUserDTO(
        Long id,
        String email,
        List<Role> roles
) {}