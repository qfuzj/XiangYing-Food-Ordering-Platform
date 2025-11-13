package com.xiangying.web.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Date;

@RestController
public class AuthController {

    @Value("${token.secret}")
    private String secret;

    @Value("${token.expireTime:30}") // 分钟
    private int expireTimeMinutes;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest loginRequest) {
        // 简单示例验证：实际应查询数据库并校验密码哈希
        if ("user".equals(loginRequest.getUsername()) && "password".equals(loginRequest.getPassword())) {
            long now = System.currentTimeMillis();
            Date issuedAt = new Date(now);
            Date expiration = new Date(now + expireTimeMinutes * 60L * 1000L);
            String token = Jwts.builder()
                    .setSubject(loginRequest.getUsername())
                    .setIssuedAt(issuedAt)
                    .setExpiration(expiration)
                    .signWith(SignatureAlgorithm.HS256, secret.getBytes())
                    .compact();
            return ResponseEntity.ok(new LoginResponse(token, "Bearer", expireTimeMinutes));
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
    }
}

class LoginRequest {
    private String username;
    private String password;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}

class LoginResponse {
    private String token;
    private String tokenType;
    private int expireMinutes;

    public LoginResponse(String token, String tokenType, int expireMinutes) {
        this.token = token;
        this.tokenType = tokenType;
        this.expireMinutes = expireMinutes;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getTokenType() {
        return tokenType;
    }

    public void setTokenType(String tokenType) {
        this.tokenType = tokenType;
    }

    public int getExpireMinutes() {
        return expireMinutes;
    }

    public void setExpireMinutes(int expireMinutes) {
        this.expireMinutes = expireMinutes;
    }
}