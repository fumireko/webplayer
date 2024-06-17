package ca.fubi.player.user;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import ca.fubi.player.SecurityConfiguration;
import ca.fubi.player.role.Role;
import ca.fubi.player.role.RoleRepository;
import ca.fubi.player.user.User;

@Service
public class UserService {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtTokenService jwtTokenService;

    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private SecurityConfiguration securityConfiguration;

    public RecoveryJwtTokenDTO authenticateUser(LoginUserDTO loginUserDto) {
        UsernamePasswordAuthenticationToken authToken = 
        		new UsernamePasswordAuthenticationToken(
        				loginUserDto.email(), 
        				loginUserDto.password()
				);
        User user = userRepository.findByEmail(loginUserDto.email()).get();
        Authentication auth = authenticationManager.authenticate(authToken);
        UserDetailsImpl userDetails = (UserDetailsImpl) auth.getPrincipal();
        return new RecoveryJwtTokenDTO(
        		jwtTokenService.generateToken(userDetails),
        		new RecoveryUserDTO(user.getId(),
        							user.getUsername(),
        							user.getEmail(),
        							user.getRoles())
        		);
    }

    public void createUser(CreateUserDTO createUserDto) {
        User newUser = User.builder()
        		.username(createUserDto.username())
                .email(createUserDto.email())
                .password(securityConfiguration.passwordEncoder().encode(createUserDto.password()))
                .roles(Set.of(Role.builder().name(createUserDto.role()).build()))
                .build();
        newUser.getRoles().forEach(r -> roleRepository.save(r));
        userRepository.save(newUser);
    }
}