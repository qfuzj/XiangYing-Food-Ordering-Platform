package com.xiangying.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {
    @GetMapping("/a")
    public String home() {
        return "forward:/index2.html"; // 服务器内部转发，保留 Authorization 头与 Authentication，避免 302 丢失 token
    }
}
