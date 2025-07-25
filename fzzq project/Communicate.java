package com.hanyu;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        try {
            System.out.print("请您输入下要执行的command: ");
            Scanner scanner = new Scanner(System.in);
            String commands = scanner.nextLine();

            ProcessBuilder builder = new ProcessBuilder();
            builder.command(commands.split(" "));

            scanner.close();
            System.out.println("您输入的command是: " + commands);

            Process process = builder.start();
            builder.redirectErrorStream(true);

            BufferedInputStream inputStream = new BufferedInputStream(process.getInputStream());
            BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));

            String line;
            while((line = reader.readLine()) != null) {
                System.out.println(line);
            }

            reader.close();
            inputStream.close();
            int exitCode = process.waitFor();
            if (exitCode != 0) { System.out.println("Process exited with code: " + exitCode); }

        } catch (IOException | InterruptedException e) {
            System.out.println("The program has encountered an error: " + e.getMessage());
        }
    }
}