package ca.fubi.player.models.dto;

import java.util.List;

import ca.fubi.player.models.Role;

public record RecoveryUserDTO(
        Long id,
        String email,
        List<Role> roles
) {}