package com.example.deploytest;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@EnableAspectJAutoProxy
@SpringBootApplication
public class DeployTestApplication {

    public static void main(String[] args) {
        SpringApplication.run(DeployTestApplication.class, args);
    }

}
