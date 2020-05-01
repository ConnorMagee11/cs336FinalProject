/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DTO.QuestionDTO;
import DTO.UserDTO;
import DataBase.QuestionDBHandler;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/editaquestion"})
public class editaquestion extends HttpServlet {

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
        String message = "Question Successfully Edited";
        String color = "text-success";
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                /* TODO output your page here. You may use following sample code. */
                HttpSession session = request.getSession();
                Boolean login = (Boolean) session.getAttribute("loggedin");
                String role = (String) session.getAttribute("role");
                UserDTO sessiondto = (UserDTO) session.getAttribute("user");
                if (login == null && sessiondto == null && !login && role == null && role.equalsIgnoreCase("customer")) {
                    response.sendRedirect("home.jsp");
                }
                QuestionDBHandler db = new QuestionDBHandler();
                String id_s = request.getParameter("id");
                int id = Integer.parseInt(id_s);
                String answer = request.getParameter("answer");
                String question = request.getParameter("question");

                QuestionDTO dto = db.getQuestionByID(id);
                dto.setQuestion(question);
                dto.setAnswer(answer);
                dto.setAnswerer_id(sessiondto.getId());
                dto.setIs_answered(true);

                if (!db.updateQuestion(dto)) {
                    message = "Something Went Wrong";
                    color = "text-danger";
                } else {
                    request.setAttribute("message", message);
                    request.setAttribute("color", color);
                    request.setAttribute("id", id_s);
                    getServletContext().getRequestDispatcher("/editquestion.jsp").forward(request, response);
                    return;
                }
                request.setAttribute("message", message);
                request.setAttribute("color", color);
                request.setAttribute("id", id_s);
                getServletContext().getRequestDispatcher("/editquestion.jsp").forward(request, response);
                return;
            } catch (Exception e) {

                message = "Something Went Wrong";
                color = "text-danger";
                request.setAttribute("message", message);
                request.setAttribute("color", color);
                getServletContext().getRequestDispatcher("/editquestion.jsp").forward(request, response);
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

        getServletContext().getRequestDispatcher("/editquestion.jsp").forward(request, response);
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
