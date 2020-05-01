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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author silen
 */
@WebServlet(urlPatterns = {"/changepassword"})
public class changepassword extends HttpServlet {

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
        String message = "Password Successfully Updated";
        String color = "text-success";
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            HttpSession session = request.getSession();
            Boolean login = (Boolean) session.getAttribute("loggedin");
            UserDTO sessiondto = (UserDTO) session.getAttribute("user");
            if (login == null && sessiondto == null && !login) {
                response.sendRedirect("home.jsp");
            }
            UserDBHandler db = new UserDBHandler();
            UserDTO dto = db.getUserByID(sessiondto.getId());
            if (dto != null) {

                /* TODO output your page here. You may use following sample code. */
                String oldPassword = request.getParameter("oldpwd");
                String password = request.getParameter("newpwd");
                String confirmPassword = request.getParameter("newpwd1");
                if (BCrypt.checkpw(oldPassword, dto.getPassword())) {
                    if (password.equals(confirmPassword)) {
                        dto.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
                        db.updateUser(dto);
                        message = "Password Changed Successflly";
                        color = "text-success";
                    } else {
                        message = "Password Not Matched";
                        color = "text-danger";
                    }
                } else {
                    message = "Wrong Old Password.";
                    color = "text-danger";
                }
                request.setAttribute("message", message);
                request.setAttribute("color", color);

                getServletContext().getRequestDispatcher("/changepassword.jsp").forward(request, response);
                return;
            } else {
                response.sendRedirect("home.jsp");
            }

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
        String message = "Something Went Wrong";
        String color = "text-danger";

        request.setAttribute("message", message);
        request.setAttribute("color", color);

        getServletContext().getRequestDispatcher("/changepassword.jsp").forward(request, response);
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
