package com.example.deploytest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller("users")
public class UserController {
    @GetMapping
    public String users() {
        return "user";
    }

}
