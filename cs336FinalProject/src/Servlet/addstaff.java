/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DTO.UserDTO;
import DataBase.UserDBHandler;
import DataBase.UserTypeDBHandler;
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
@WebServlet(urlPatterns = {"/addstaff"})
public class addstaff extends HttpServlet {

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
        String message = "Account Successfully Created";
        String color = "text-success";
        try (PrintWriter out = response.getWriter()) {
            try {
                /* TODO output your page here. You may use following sample code. */
                UserDTO dto = new UserDTO();
                dto.setFirst_name(request.getParameter("fname"));
                dto.setLast_name(request.getParameter("lname"));
                UserTypeDBHandler tdb = new UserTypeDBHandler();
                dto.setEmail(request.getParameter("email"));
                System.out.println(request.getParameter("password"));
                dto.setPassword(BCrypt.hashpw(request.getParameter("password"), BCrypt.gensalt()));
                dto.setGender(request.getParameter("gender"));
                dto.setAddress(request.getParameter("address"));

                UserDBHandler db = new UserDBHandler();

                if (db.serachByEmail(dto.getEmail()) == -1) {
                    dto.setUser_type(tdb.searchType("staff"));
                    db.insertUser(dto);

                } else {
                    message = "Email Already Exisit";
                    color = "text-danger";
                }
                request.setAttribute("message", message);
                request.setAttribute("color", color);
                getServletContext().getRequestDispatcher("/addstaff.jsp").forward(request, response);
                return;
            } catch (Exception e) {
                e.printStackTrace();
                message = "An Unexpected error occured";

                color = "text-danger";
            }
            request.setAttribute("message", message);
            request.setAttribute("color", color);
            getServletContext().getRequestDispatcher("/addstaff.jsp").forward(request, response);
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

        getServletContext().getRequestDispatcher("/addstaff.jsp").forward(request, response);
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
