<%@ page import="java.io.*" %>
<%
    String id = request.getParameter("id");
    byte[] imgData = null;

    try {
        FileInputStream fin = new FileInputStream(id);
        imgData = new byte[fin.available()];
        fin.read(imgData);
        fin.close();

        response.setContentType("image/jpeg");
        // Display image inline in browser
        response.setHeader("Content-Disposition", "inline");

        OutputStream o = response.getOutputStream();
        o.write(imgData);
        o.flush();
        o.close();
    } catch (Exception e) {
        out.println("Unable To Display image");
        out.println("Image Display Error=" + e.getMessage());
    }
%>
