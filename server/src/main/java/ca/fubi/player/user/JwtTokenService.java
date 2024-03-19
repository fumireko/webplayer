package ca.fubi.player.user;

import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTVerificationException;

@Service
public class JwtTokenService {

    @Value("${app.jwtSecret}")
    private String secretKey;

    @Value("${app.jwtExpirationHours}")
    private long jwtExpirationHours;

    @Value("${app.jwtIssuer}")
    private String issuer;
    
    @Value("${app.timezone}")
    private String timeZone;

    public String generateToken(UserDetailsImpl user) {
        try {
            Algorithm algorithm = Algorithm.HMAC256(secretKey);
            return JWT.create()
                    .withIssuer(issuer)
                    .withIssuedAt(creationDate())
                    .withExpiresAt(expirationDate())
                    .withSubject(user.getUsername())
                    .sign(algorithm);
        } catch (JWTCreationException exception){
            throw new JWTCreationException("Error generating token.", exception);
        }
    }

    public String getSubjectFromToken(String token) {
        try {
            Algorithm algorithm = Algorithm.HMAC256(secretKey);
            return JWT.require(algorithm)
                    .withIssuer(issuer)
                    .build()
                    .verify(token)
                    .getSubject();
        } catch (JWTVerificationException exception){
            throw new JWTVerificationException("Token is invalid or has already expired.");
        }
    }

    private Instant creationDate() {
        return ZonedDateTime.now(ZoneId.of(timeZone)).toInstant();
    }

    private Instant expirationDate() {
        return ZonedDateTime.now(ZoneId.of(timeZone)).plusHours(jwtExpirationHours).toInstant();
    }

}
