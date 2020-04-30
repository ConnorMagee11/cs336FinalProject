<%-- 
    Document   : editrouteschedule
    Created on : Apr 28, 2020, 1:50:55 AM
    Author     : silen
--%>

<%@page import="DataBase.RouteScheduleDBHandler"%>
<%@page import="DTO.RouteScheduleDTO"%>
<%@page import="DTO.TrainDTO"%>
<%@page import="DTO.RouteDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DataBase.TrainDBHandler"%>
<%@page import="DataBase.RouteDBHandler"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<%if(!(login && (staff || admin))){
    response.sendRedirect("home.jsp");
    return;
}
%>
<!-- Content Wrapper. Contains page content -->

<% String id_s = request.getParameter("id");
    if (id_s == null) {
        id_s = (String) request.getAttribute("id");
        if (id_s == null) {
            response.sendRedirect("routeschedule.jsp");
            return;
        }
    }
    int id = 0;
    try {
        id = Integer.parseInt(id_s);
    } catch (Exception e) {
        response.sendRedirect("routeschedule.jsp");
        return;
    }
    RouteScheduleDTO dto;
    RouteScheduleDBHandler db = new RouteScheduleDBHandler();
    dto = db.getRouteScheduleByID(id);
    if (dto == null) {
        response.sendRedirect("routeschedule.jsp");
        return;
    }

%>
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Edit Route Schedule</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                        <li class="breadcrumb-item active">Edit Route Schedule</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <!-- left column -->
                <div class="col-md-2"></div>
                <div class="col-md-8">
                    <%String message = (String) request.getAttribute("message");
                        String color = (String) request.getAttribute("color");
                        if (message != null) {
                    %>
                    <span class="text-center text-bold center <%=color%>" style="margin-left: 45%"><%=message%></span>
                    <%}%>
                    <!-- general form elements -->
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">Rout Schedule</h3>
                        </div>
                        <!-- /.card-header -->
                        <%RouteDBHandler rdb = new RouteDBHandler();
                            TrainDBHandler tdb = new TrainDBHandler();
                            ArrayList<RouteDTO> rarr = rdb.getAllRoute();
                            ArrayList<TrainDTO> tarr = tdb.getAllTrain(); %>

                        <!-- form start -->
                        <form role="form" action="editrouteschedule" method="post">
                            <div class="card-body">
                                <div class="form-group">
                                    <input type="hidden" value="<%=dto.getId() %>" name="id">
                                    <label>Route</label>
                                    <select name="route" class="form-control select2" required="" style="width: 100%;">

                                        <%if (rarr != null) {
                                                String selected = "";
                                                for (RouteDTO r : rarr) {
                                                    if (r.getId() == dto.getRoute_id()) {
                                                        selected = "selected=\"\"";
                                                    } else {
                                                        selected = "";
                                                    }

                                        %>


                                        <option <%=selected%> value="<%=r.getId()%>"><%= r.getName() + " " + r.getOrigin() + " to " + r.getDestination()%></option>
                                        <%}
                                            }%>

                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Train</label>
                                    <select name="train" class="form-control select2" style="width: 100%;">
                                        <%if (rarr != null) {
                                                String selected = "";
                                                for (TrainDTO r : tarr) {
                                                    if (r.getId() == dto.getTrain_id()) {
                                                        selected = "selected=\"\"";
                                                    } else {
                                                        selected = "";
                                                    }

                                        %>


                                        <option <%=selected%> value="<%=r.getId()%>"><%= r.getName()%></option>
                                        <%}
                                            }%>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="date1">Date</label>
                                    <input type="date"  value="<%=dto.getDate() %>" name="date" class="form-control" id="date1" placeholder="" required="">
                                </div>
                                <div class="form-group">
                                    <label for="atime">Arrival Time</label>
                                    <input type="time" name="atime" value="<%=dto.getArrivaltime() %>" class="form-control" id="date1" placeholder="" required="">
                                </div>
                                <div class="form-group">
                                    <label for="dtime">Departure Time</label>
                                    <input type="time" name="dtime" value="<%=dto.getDeparuretime() %>" class="form-control" id="date1" placeholder="" required="">
                                </div>



                            </div>
                            <!-- /.card-body -->

                            <div class="card-footer">
                                <button type="submit" class="btn btn-primary">Submit</button>
                            </div>
                        </form>
                    </div>
                    <!-- /.card -->







                </div>
                <!--/.col (left) -->
                <!-- right column -->

            </div>
            <!-- /.row -->
        </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<!-- Control Sidebar -->
<aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
</aside>
<!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- bs-custom-file-input -->
<script src="plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Select2 -->
<script src="plugins/select2/js/select2.full.min.js"></script>
<!-- Bootstrap4 Duallistbox -->
<script src="plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
<!-- InputMask -->
<script src="plugins/moment/moment.min.js"></script>
<script src="plugins/inputmask/min/jquery.inputmask.bundle.min.js"></script>
<!-- date-range-picker -->
<script src="plugins/daterangepicker/daterangepicker.js"></script>
<!-- bootstrap color picker -->
<script src="plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<script>
    $(function () {
        //Initialize Select2 Elements
        $('.select2').select2({
            theme: 'bootstrap4'
        })

        //Initialize Select2 Elements
        $('.select2bs4').select2({
            theme: 'bootstrap4'
        })
        $('#date1').datepicker({
            uiLibrary: 'bootstrap4'
        });






    })
</script>
<script type="text/javascript">
    $(document).ready(function () {
        bsCustomFileInput.init();
    });
</script>
</body>
</html>

