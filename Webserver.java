//import com.sun.net.httpserver.HttpServer;
//import com.sun.net.httpserver.HttpExchange;
//import com.sun.net.httpserver.HttpHandler;
//
//import java.io.IOException;
//import java.io.OutputStream;
//
//public class WebServer {
//    public static void main(String[] args) throws IOException {
//        HttpServer server = HttpServer.create(new InetSocketAddress(8080), 0);
//        server.createContext("/", new MyHandler());
//        server.setExecutor(null);
//        server.start();
//        System.out.println("Web server started on port 8080...");
//    }
//
//    static class MyHandler implements HttpHandler {
//        @Override
//        public void handle(HttpExchange exchange) throws IOException {
//            String response = "Sample Java Web Server";
//            exchange.sendResponseHeaders(200, response.getBytes().length);
//            OutputStream os = exchange.getResponseBody();
//            os.write(response.getBytes());
//            os.close();
//        }
//    }
//}
