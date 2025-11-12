package org.tomliu.webdeploy;

//重写了代码 实习时写的代码在重设电脑时忘记了备份 被删掉了。。。

import java.io.*;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Locale;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.springframework.web.bind.annotation.*;

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    private String message, message2;
    Duration duration;
    private static final Logger LOGGER = LogManager.getLogger(HelloServlet.class);

    public void init() {
        message = "Hello World!";
        message2 = "Hello Java!";
    }

    private static void websitePrinter(HttpServletResponse response,
                                       HttpServletRequest request,
                                       String messages,
                                       String messages2) throws IOException {
        try {
            response.setContentType("text/html");

            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.write("<title>" + messages + "</title>");
            out.write("<head>" + messages2 + "</head>");
            out.write("<h1>" + messages2 + "</h1>");
            out.write("</body>");
            out.write("</html>");

            out.flush();
        } catch (IOException io) {
            LOGGER.error(io.getStackTrace());
        }
    }

    public void doGet(HttpServletRequest request,
                      HttpServletResponse response) throws IOException {
        try {
            websitePrinter(response, request, message, message2);
        } catch (IOException e) {
            LOGGER.error(e.getStackTrace());
        }
    }

    public void doPost(HttpServletRequest request,
                       HttpServletResponse response) throws IOException {
        try {
            websitePrinter(response, request, message, message2);
        } catch (IOException e) {
            LOGGER.error(e.getStackTrace());
        }
    }

    public void doDelete(HttpServletRequest request,
                         HttpServletResponse response) throws IOException {
        try {
            websitePrinter(response, request, message, message2);
        } catch (IOException e) {
            LOGGER.error(e.getStackTrace());
        }
    }

    public void doPut(HttpServletRequest request,
                      HttpServletResponse response) throws IOException {
        try {
            websitePrinter(response, request, message, message2);
        } catch (IOException e) {
            LOGGER.error(e.getStackTrace());
        }
    }

    public void destroy() {

    }

    private void countdownFromToday() throws InterruptedException {
        LocalDateTime targetDateTime = LocalDateTime.of(
                LocalDate.now().getDayOfYear(),
                LocalDate.now().getYear(),
                27, 4, 2, 7
        );

        if (targetDateTime.isBefore(LocalDateTime.now())) {
            targetDateTime = targetDateTime.plusDays(0);
        }

        do {
            LocalDateTime now = LocalDateTime.now();
            duration = Duration.between(now, targetDateTime);

            long days = duration.toDays();
            long hours = duration.toHours() % 24;
            long minutes = duration.toMinutes() % 60;
            long seconds = duration.toSeconds() % 60;

            System.out.printf("\rTime until event %s: %d days, %d hours, %d minutes, %d seconds",
                    targetDateTime.toLocalDate(), days, hours, minutes, seconds);

            if (duration.isNegative() || duration.isZero()) {
                System.out.println("\nGood news: Your time has arrived!");
            }
        } while (! duration.isNegative() || duration.isZero());
        Thread.sleep(1000);
    }

    @RequestMapping(value="request{/countdown}",method=RequestMethod.PATCH)
    public Boolean sayHello(@PathVariable Boolean countdown) {
        LOGGER.debug("Request method has run.");
        try {
            countdownFromToday();
        } catch(Exception e) {
            LOGGER.debug("An error occurred while trying to say hello and countdown.");
            System.out.println(Arrays.toString(e.getStackTrace()));
        }
        return countdown;
    }

    @DeleteMapping(value="delete{/drawShape}")
    public static void drawSomeShapes(@PathVariable String drawShape) {
        drawShape = "*";
    }

    @PutMapping(value="date{/currentDate}")
    public static void whatDayIsIt(@PathVariable LocalDate currentDate) {
        var zhFormatter = DateTimeFormatter.ofPattern("yyyy MMM dd EE HH:mm:ss", Locale.CHINA);
        System.out.println(zhFormatter.format(currentDate));
    }

    @GetMapping(name="helloWorld", value="kitty{/kitty}")
    public static String helloWorld(@PathVariable String kitty) {

        LOGGER.info(kitty);
        kitty = """
                /\\_/\\
                ( o.o )
                 > ^ <
                /\\_\\
                ( o.o )
                 > ^ <
                /\\_/\\
                ( o.o )
                 > ^ <
                """;

        return kitty;
    }

    @PatchMapping("patch/{kitty}")
    public String patch(@PathVariable String kitty) {
        kitty =
                """
                 ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ
                // \\               //\\
                //  \\     /\\_/\\  // \\
                //   \\    ( o.o )  //  \\
                //    \\    > ^ <   //   \\
                //     \\           //    \\
                //      \\          //     \\
                '------------------------  | |
                |                          | |
                |                --------  | |
                |   |----|       |      |  | |
                |   | -|-|       |  |--0|  | |
                |   |----|       |  |   |  | |
                ------------------------------
                a kitty has entered your home.""";
        return kitty;
    }
}
