package com.xiangying.web.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LoginController {
    @GetMapping("/a")
    public String home() {
        return "nihao"; // 需要有 index.html 或 index.ftl/index.jsp
    }
}
