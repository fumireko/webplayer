package ca.fubi.player.user;

import java.io.IOException;
import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.filter.OncePerRequestFilter;

import com.fasterxml.jackson.databind.ObjectMapper;

import ca.fubi.player.ResponseMessageDTO;
import ca.fubi.player.SecurityConfiguration;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class UserAuthenticationFilter extends OncePerRequestFilter {

    @Autowired
    private JwtTokenService jwtTokenService;

    @Autowired
    private UserRepository userRepository;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        if (!isEndpointPublic(request)) {
            String token = recoveryToken(request);
            try {
                if (token != null) {
                    String subject = jwtTokenService.getSubjectFromToken(token);
                    User user = userRepository.findByEmail(subject)
                            .orElseThrow(() -> new RuntimeException("Usuário não encontrado."));
                    UserDetailsImpl userDetails = new UserDetailsImpl(user);
                    Authentication authentication = new UsernamePasswordAuthenticationToken(userDetails, null,
                            userDetails.getAuthorities());
                    SecurityContextHolder.getContext().setAuthentication(authentication);
                } else {
                    throw new RuntimeException("O token está ausente.");
                }
            } catch (Exception e) {
                ResponseMessageDTO errorResponse = new ResponseMessageDTO(e.getMessage());
                ObjectMapper mapper = new ObjectMapper();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write(mapper.writeValueAsString(errorResponse));
                response.getWriter().flush();
                return;
            }
        }
        filterChain.doFilter(request, response);
    }

    private String recoveryToken(HttpServletRequest request) {
        String authorizationHeader = request.getHeader("Authorization");
        if (authorizationHeader != null)
            return authorizationHeader.replace("Bearer ", "");
        return null;
    }

    private boolean isEndpointPublic(HttpServletRequest request) {
    	AntPathMatcher pathMatcher = new AntPathMatcher();
    	boolean a = Arrays.stream(SecurityConfiguration.ENDPOINTS_WITH_AUTHENTICATION_NOT_REQUIRED)
                .anyMatch(pattern -> pathMatcher.match(pattern, request.getRequestURI()));
    	System.out.println(request.getRequestURI() + " " + a);
        return a;
    }

}
