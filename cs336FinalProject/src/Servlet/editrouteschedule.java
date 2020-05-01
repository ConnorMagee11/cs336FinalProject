/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DTO.RouteScheduleDTO;
import DataBase.RouteScheduleDBHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author silen
 */
@WebServlet(urlPatterns = {"/editrouteschedule"})
public class editrouteschedule extends HttpServlet {

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
        String message = "Route Schedule Successfully Updated";
        String color = "text-success";
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                /* TODO output your page here. You may use following sample code. */
                String route_s, train_s, date, arrival, departure;
                route_s = request.getParameter("route");
                int route = Integer.parseInt(route_s);
                train_s = request.getParameter("train");
                int train = Integer.parseInt(train_s);
                date = request.getParameter("date");
                arrival = request.getParameter("atime");
                departure = request.getParameter("dtime");
                java.util.Date d = null;
                Time atime = null;
                Time dtime = null;
                String id_s = request.getParameter("id");
                int id = Integer.parseInt(id_s);
                d = new SimpleDateFormat("yyyy-MM-dd").parse(date);
                DateFormat df = new SimpleDateFormat("HH:mm");
                dtime = new Time(df.parse(departure).getTime());
                atime = new Time(df.parse(arrival).getTime());
                java.sql.Date sqlDate = new java.sql.Date(d.getTime());

                RouteScheduleDTO dto = new RouteScheduleDTO();
                dto.setArrivaltime(atime);
                dto.setDeparuretime(dtime);
                dto.setDate(sqlDate);
                dto.setRoute_id(route);
                dto.setTrain_id(train);
                dto.setId(id);
                RouteScheduleDBHandler db = new RouteScheduleDBHandler();
                if (!db.updateRouteSchedule(dto)) {
                    message = "Something Went Wrong";
                    color = "text-danger";
                }
                request.setAttribute("message", message);
                request.setAttribute("color", color);
                request.setAttribute("id", id_s);
                getServletContext().getRequestDispatcher("/editrouteschedule.jsp").forward(request, response);
                return;
                //out.println(dto);

            } catch (Exception e) {
                message = "Something Went Wrong";
                color = "text-danger";

            }
            request.setAttribute("message", message);
            request.setAttribute("color", color);

            getServletContext().getRequestDispatcher("/editrouteschedule.jsp").forward(request, response);
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

        getServletContext().getRequestDispatcher("/editrouteschedule.jsp").forward(request, response);
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
