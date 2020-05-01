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
@WebServlet(urlPatterns = {"/editaccount"})
public class editaccount extends HttpServlet {

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
        String message = "Account Successfully Updated";
        String color = "text-success";
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            if (session != null) {
                Boolean login = (Boolean) session.getAttribute("loggedin");
                UserDTO sessiondto = (UserDTO) session.getAttribute("user");
                if (login == null && sessiondto == null && !login) {
                    response.sendRedirect("home.jsp");
                }

                UserDBHandler db = new UserDBHandler();
                UserDTO dto = db.getUserByID(sessiondto.getId());
                dto.setFirst_name(request.getParameter("fname"));
                dto.setLast_name(request.getParameter("lname"));
                String email = dto.getEmail();
                dto.setEmail(request.getParameter("email"));
                dto.setGender(request.getParameter("gender"));
                dto.setAddress(request.getParameter("address"));
                if (db.serachByEmail(dto.getEmail()) == -1 || dto.getEmail().equalsIgnoreCase(email)) {
                    System.out.println(dto.getEmail() + " " + email);
                    if (!db.updateUser(dto)) {
                        message = "Something went Wrong";
                        color = "text-danger";
                    }
                    else{
                        session.setAttribute("user", dto);
                    }

                } else {
                    message = "Email Already Exisit";
                    color = "text-danger";
                }
                if (dto != null) {

                    request.setAttribute("message", message);
                    request.setAttribute("color", color);

                    getServletContext().getRequestDispatcher("/editaccount.jsp").forward(request, response);
                    return;
                } else {
                    response.sendRedirect("home.jsp");
                }
            } else {
                response.sendRedirect("home.jsp");
                return;
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

        getServletContext().getRequestDispatcher("/editaccount.jsp").forward(request, response);
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
