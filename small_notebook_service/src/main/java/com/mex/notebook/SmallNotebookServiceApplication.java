package com.mex.notebook;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
@EnableAsync
public class SmallNotebookServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(SmallNotebookServiceApplication.class, args);
    }

}
