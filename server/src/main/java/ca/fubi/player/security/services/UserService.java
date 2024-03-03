package ca.fubi.player.security.services;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import ca.fubi.player.models.Role;
import ca.fubi.player.models.User;
import ca.fubi.player.models.dto.CreateUserDTO;
import ca.fubi.player.models.dto.LoginUserDTO;
import ca.fubi.player.models.dto.RecoveryJwtTokenDTO;
import ca.fubi.player.repository.UserRepository;
import ca.fubi.player.security.SecurityConfiguration;

@Service
public class UserService {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtTokenService jwtTokenService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private SecurityConfiguration securityConfiguration;

    public RecoveryJwtTokenDTO authenticateUser(LoginUserDTO loginUserDto) {
        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken =
                new UsernamePasswordAuthenticationToken(loginUserDto.email(), loginUserDto.password());

        Authentication authentication = authenticationManager.authenticate(usernamePasswordAuthenticationToken);
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        return new RecoveryJwtTokenDTO(jwtTokenService.generateToken(userDetails));
    }

    public void createUser(CreateUserDTO createUserDto) {
    	Set<Role> roles = new HashSet<>();
        roles.add(Role.builder().name(createUserDto.role()).build());
        
        User newUser = User.builder()
                .email(createUserDto.email())
                .password(securityConfiguration.passwordEncoder().encode(createUserDto.password()))
                .roles(roles)
                .build();

        userRepository.save(newUser);
    }
}