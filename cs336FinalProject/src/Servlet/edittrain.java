/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DTO.TrainDTO;
import DataBase.TrainDBHandler;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author silen
 */
@WebServlet(urlPatterns = {"/login"})
public class edittrain extends HttpServlet {

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

        String message = "Train Successfully Added";
        String color = "text-success";
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            try {
                /* TODO output your page here. You may use following sample code. */
                String name = request.getParameter("tname");
                String description = request.getParameter("description");

                String capacity_s = request.getParameter("capacity");
                int capacity = Integer.parseInt(capacity_s);

                String id_s = request.getParameter("id");
                int id = Integer.parseInt(id_s);

                TrainDTO dto = new TrainDTO();
                TrainDBHandler db = new TrainDBHandler();

                dto.setName(name);
                dto.setCapacity(capacity);
                dto.setDescription(description);
                dto.setId(id);

                if (!db.updateTrain(dto)) {
                    message = "Something Went Wrong";
                    color = "text-danger";
                }
                request.setAttribute("id", id_s);
                request.setAttribute("message", message);
                request.setAttribute("color", color);

                getServletContext().getRequestDispatcher("/edittrain.jsp").forward(request, response);
                return;
                //out.println(dto);

            } catch (Exception e) {
                message = "Something Went Wrong";
                color = "text-danger";

            }
            request.setAttribute("message", message);
            request.setAttribute("color", color);

            getServletContext().getRequestDispatcher("/edittrain.jsp").forward(request, response);
            return;
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

        getServletContext().getRequestDispatcher("/edittrain.jsp").forward(request, response);
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
