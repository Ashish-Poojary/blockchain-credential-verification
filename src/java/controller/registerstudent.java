/*
 * Student Registration Servlet
 * Handles student registration and account creation
 */
package controller;

import dbconnection.Dbconnection;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import mail.SendMailExample;

/**
 *
 * @author user
 */
@WebServlet(name = "registerstudent", urlPatterns = {"/registerstudent"})
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
public class registerstudent extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Process student registration
            String usn = request.getParameter("usn");
            String t1=request.getParameter("t1").trim();
             String t2=request.getParameter("t2").trim();
            //String t3=request.getParameter("t3").trim();
            String t4=request.getParameter("t4").trim();
           
            Random r=new Random();
            String t5=""+r.nextInt(10)+r.nextInt(10)+r.nextInt(10)+r.nextInt(10)+r.nextInt(10)+r.nextInt(10);
            t5.trim();
            
            System.out.println(usn);
            System.out.println(t1);
            System.out.println(t2);
            System.out.println(t5);
            
            InputStream inputStream = null;
            Part filePart = request.getPart("t3");
            if (filePart != null) {

            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());


            inputStream = filePart.getInputStream();
            }
            
            HttpSession session=request.getSession();
            Connection con=new Dbconnection().getConnection();
            
            PreparedStatement pst=con.prepareStatement("select * from student where usn=?");
            pst.setString(1,usn);
          
            ResultSet rs=pst.executeQuery();
            
            if (rs.next())
            {
                response.sendRedirect("registerstudent.jsp?msg=EXIST");
            }
            
            new SendMailExample().sendMail(t4, "Your Login ID is " + usn + "\nYour password is " + t5);

            
            PreparedStatement pst2=con.prepareStatement("insert into student values(?,?,?,?,?,?)");
            pst2.setString(1,usn);
            pst2.setString(2,t1);
            pst2.setString(3,t2);
            pst2.setString(4,t4);
            pst2.setString(5,t5);
           
           
            File f=new File("C:\\studentcertificate");
                System.out.println(f.getPath());
                if (!f.exists())
                    f.mkdir();
              
            byte[] b = new byte[inputStream.available()];
                inputStream.read(b);
                //pst2.setBytes(6, b);
                filePart.write(f.getPath()+"\\"+usn+".jpg");
               pst2.setString(6,f.getPath()+"\\"+usn+".jpg");
                
            pst2.executeUpdate();
            
            response.sendRedirect("registerstudent.jsp?msg=SUCCESS");
        
        
        }
        catch(Exception e)
        {
            System.out.println(e);
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
