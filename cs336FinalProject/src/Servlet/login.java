/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DTO.UserDTO;
import DataBase.UserDBHandler;
import Utility.BCrypt;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author silen
 */
@WebServlet(urlPatterns = {"/login"})
public class login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific message occurs
     * @throws IOException if an I/O message occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String message = "Somethind went wrong";
        String color = "text-danger";
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                /* TODO output your page here. You may use following sample code. */
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                UserDBHandler db = new UserDBHandler();
                if (db.serachByEmail(email) == -1) {
                    message = "Email Wrong";
                } else {
                    UserDTO dto = db.getUserByID(db.serachByEmail(email));
                    System.out.println(BCrypt.hashpw("allok123", BCrypt.gensalt()));
                    if (dto != null && BCrypt.checkpw(password, dto.getPassword())) {
                        dto.setPassword(null);
                        HttpSession session = request.getSession();
                        session.setAttribute("role", dto.getUserType().getName());
                        session.setAttribute("loggedin", true);
                        session.setAttribute("user", dto);

                        response.sendRedirect("home.jsp");
                        return;
                    } else {
                        message = "Password Wrong.";
                    }
                }

                request.setAttribute("message", message);
                request.setAttribute("color", color);
                getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
                return;

            } catch (Exception e) {
                e.printStackTrace();
                message = "An Unexpected message occured";
            }
            request.setAttribute("message", message);
            request.setAttribute("color", color);
            getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific message occurs
     * @throws IOException if an I/O message occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("message", "Something went wrong");
        request.setAttribute("color", "text-danger");
        getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
        return;
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific message occurs
     * @throws IOException if an I/O message occurs
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
