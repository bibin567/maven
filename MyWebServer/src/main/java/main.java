package com.example.server;

import java.io.IOException;
import java.io.OutputStream;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

public class MyWebServer {
    public static void main(String[] args) throws IOException {
        HttpServer server = HttpServer.create();
        server.bind(null, 80, 0);
        server.createContext("/", new HelloHandler());
        server.start();
        System.out.println("Server started on port 80");
    }

    static class HelloHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            String response = "Hello, World!";
            exchange.sendResponseHeaders(200, response.length());
            OutputStream os = exchange.getResponseBody();
            os.write(response.getBytes());
            os.close();
        }
    }
}
