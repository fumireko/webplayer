package ca.fubi.player.controllers;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ca.fubi.player.models.Role;
import ca.fubi.player.models.User;
import ca.fubi.player.models.dto.CreateUserDTO;
import ca.fubi.player.models.dto.LoginUserDTO;
import ca.fubi.player.models.dto.RecoveryJwtTokenDTO;
import ca.fubi.player.repository.UserRepository;
import ca.fubi.player.security.services.UserService;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600, allowCredentials = "true")
@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private UserRepository userRepository;

    @PostMapping("/signin")
    public ResponseEntity<UserTokenDTO> authenticateUser(@RequestBody LoginUserDTO loginUserDto) {
        RecoveryJwtTokenDTO token = userService.authenticateUser(loginUserDto);
        User u = userRepository.findByEmail(loginUserDto.email()).get();
        return ResponseEntity.ok(new UserTokenDTO(u.getUsername(), u.getEmail(), u.getPassword(), token.token(), u.getRoles()));
    }

    @PostMapping("/signup")
    public ResponseEntity<Void> createUser(@RequestBody CreateUserDTO createUserDto) {
    	System.out.println(createUserDto);
        userService.createUser(createUserDto);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }
    
    @PostMapping("/signout")
    public ResponseEntity<RecoveryJwtTokenDTO> clearToken() {
        ResponseCookie cookie = ResponseCookie.from("auth-user", "")
                .maxAge(0)
                .httpOnly(true)
                .path("/")
                .build();
        
        RecoveryJwtTokenDTO token = new RecoveryJwtTokenDTO(cookie.toString());
        return ResponseEntity.ok()
                .header(HttpHeaders.SET_COOKIE, cookie.toString())
                .body(token);
    }

    @GetMapping("/test")
    public ResponseEntity<String> getAuthenticationTest() {
        return new ResponseEntity<>("Autenticado com sucesso", HttpStatus.OK);
    }

    @GetMapping("/test/customer")
    public ResponseEntity<String> getCustomerAuthenticationTest() {
        return new ResponseEntity<>("Cliente autenticado com sucesso", HttpStatus.OK);
    }

    @GetMapping("/test/administrator")
    public ResponseEntity<String> getAdminAuthenticationTest() {
        return new ResponseEntity<>("Administrador autenticado com sucesso", HttpStatus.OK);
    }

}

record UserTokenDTO (
		String username,
		String email,
		String password,
		String token,
        Set<Role> roles) {}