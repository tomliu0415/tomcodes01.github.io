package com.hanyu.servercode;

import java.sql.Connection;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import org.springframework.web.bind.annotation.*;
import org.springframework.boot.web.servlet.error.ErrorController;

@SpringBootApplication
public class ServerCodeApplication implements ErrorController {

    private Connection db;
    private static final String hello = "Hello, world!";

    private static final String helloWorld = "hello world";
    private static final Logger LOGGER = LogManager.getLogger("logger");

    public static void main(String[] args) {
        SpringApplication.run(ServerCodeApplication.class, args);
    }

    @RequestMapping(value = "hi{hello}", method = RequestMethod.GET)
    public String sayHello(@PathVariable String hello) {
        LOGGER.debug("REQUEST method ran.");
        return hello + ", World. Your request was successful.(Request Mapping)";
    }

    @PostMapping(value = "hello{hello}")
    public String helloWorld(@PathVariable String hello) {
        LOGGER.debug("POST method ran.");
        return hello + ", World. Your request was successful. (Post Mapping)";
    }

    @DeleteMapping(value = "greetings{hello}")
    public String deleteHello(@PathVariable String hello) {
        LOGGER.debug("DELETE method ran.");
        return hello + ", World. Your request was successful.(Delete Mapping)";
    }

    @GetMapping(value = "cat{kitty}")
    public String asciiArt(@PathVariable String kitty) {
        LOGGER.debug("PUT method ran");
        kitty = "Kitties!";
        return """
                 /\\_/\\
                ( o.o )
                 > ^ <
                
                 /\\_/\\
                ( o.o )
                 > ^ <
                
                 /\\_/\\
                ( o.o )
                 > ^ <
               
                """
                + kitty
                ;
    }
}
