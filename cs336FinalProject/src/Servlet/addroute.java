/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DTO.RouteDTO;
import DataBase.RouteDBHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;

/**
 *
 * @author silen
 */
@WebServlet(urlPatterns = {"/addroute"})
public class addroute extends HttpServlet {

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
        String message = "Route Successfully Added";
        String color = "text-success";
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                /* TODO output your page here. You may use following sample code. */
                String name = request.getParameter("rname");
                String origin = request.getParameter("origin");
                String destination = request.getParameter("destination");
                String[] stations = request.getParameterValues("stations");
                String fare_s = request.getParameter("fare");
                float fare = Float.parseFloat(fare_s);
                String duration_s = request.getParameter("duration");
                float duration = Float.parseFloat(duration_s);

                RouteDTO dto = new RouteDTO();
                RouteDBHandler db = new RouteDBHandler();

                dto.setDestination(destination);
                dto.setOrigin(origin);
                dto.setName(name);
                dto.setFare(fare);
                dto.setTimeDuration(duration);
                if (stations != null) {
                    ArrayList<String> arr = new ArrayList<String>(Arrays.asList(stations));
                    JSONArray jarr = new JSONArray(arr);

                    dto.setStops(jarr.toString());
                }
                if (!db.insertRoute(dto)) {
                    message = "Something Went Wrong";
                    color = "text-danger";
                }
                request.setAttribute("message", message);
                request.setAttribute("color", color);

                getServletContext().getRequestDispatcher("/addroute.jsp").forward(request, response);
                return;
                //out.println(dto);
            } catch (Exception e) {
                message = "Something Went Wrong";
                color = "text-danger";

            }
            request.setAttribute("message", message);
            request.setAttribute("color", color);

            getServletContext().getRequestDispatcher("/addroute.jsp").forward(request, response);
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

        getServletContext().getRequestDispatcher("/addroute.jsp").forward(request, response);
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
