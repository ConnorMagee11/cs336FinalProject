<%-- 
    Document   : routescheduledetail
    Created on : Apr 28, 2020, 1:52:09 AM
    Author     : silen
--%>

<%@page import="DTO.RouteDTO"%>
<%@page import="DTO.TrainDTO"%>
<%@page import="org.json.JSONArray"%>
<%@page import="DataBase.RouteScheduleDBHandler"%>
<%@page import="DTO.RouteScheduleDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Route Schedule Detail</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                        <li class="breadcrumb-item active">Route Schedules Detail</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>
    <%
        String id_s = request.getParameter("id");
        if (id_s == null) {

            response.sendRedirect("routeschedule.jsp");
            return;
        }
        int id = 0;
        try {
            id = Integer.parseInt(id_s);
        } catch (Exception e) {
            response.sendRedirect("routeschedule.jsp");
            return;
        }
        RouteScheduleDTO rsdto;
        RouteScheduleDBHandler db = new RouteScheduleDBHandler();

        rsdto = db.getRouteScheduleByID(id);
        if (rsdto == null) {
            {

                response.sendRedirect("routeschedule.jsp");
                return;
            }
        }
        TrainDTO tdto=rsdto.getTrain();
        RouteDTO rdto=rsdto.getRoute();

    %>
    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
             <!-- /.row -->
             <div class="row">
                <div class="col-md-12">
                    <!-- left column -->
                    <div class="card-deck">
                        <div class="card-header">
                            <h3 class="card-title">Route Detail</h3>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">

                            <table id="" class="table table-bordered table-striped">
                                <thead>
                                     <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Origin</th>
                                        <th>Destination</th>
                                        <th>Fare</th>
                                        <th>Duration(Hours)</th>
                                        <th>Stops</th>
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                    <%if(rdto!=null){ %>
                                    <tr>
                                        <td><%=rdto.getId()%></td>
                                        <td><%=rdto.getName()%></td>
                                        <td><%=rdto.getOrigin()%></td>
                                        <td> <%=rdto.getDestination()%></td>
                                        <td><%=rdto.getFare()%></td>
                                        <td><%=rdto.getTimeDuration()%></td>
                                        <td>
                                            <%String s = rdto.getStops();

                                                if (s != null) {%>
                                            <ol>
                                                <%
                                                    JSONArray sarr = new JSONArray(s);

                                                    for (int i = 0; i < sarr.length(); i++) {
                                                %>
                                                <li>
                                                    <%=sarr.getString(i)%>
                                                </li>
                                                <%}%>
                                            </ol>
                                            <%} else {%>
                                            <%="N/A"%>
                                            <%}%>
                                        </td>
                                         </tr>
                                    <%} else { %>
                                    <tr><td colspan="7" class="bg-gradient-blue text-bold text-center"> No Record </td></tr>
                                    <%}%>
                                   

                            </table>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!--/.col (left) -->
                    <!-- right column -->

                </div>
            </div>
             <!-- /.row -->
            <div class="row">
                <div class="col-md-12">
                    <!-- left column -->
                    <div class="card-deck">
                        <div class="card-header">
                            <h3 class="card-title">Route Schedule</h3>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">

                            <table id="" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Date</th>
                                        <th>Arrival Time</th>
                                        <th>Departure Time</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%if(rsdto!=null){ %>
                                    <tr>
                                        <td><%=rsdto.getId()%></td>
                                        <td><%=rsdto.getDate() %></td>
                                        <td><%=rsdto.getArrivaltime() %></td>
                                        <td><%=rsdto.getDeparuretime() %></td>
                                        
                                    </tr>
                                    <%} else { %>
                                    <tr><td colspan="4" class="bg-gradient-blue text-bold text-center"> No Record </td></tr>
                                    <%}%>
                                   

                            </table>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!--/.col (left) -->
                    <!-- right column -->

                </div>
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-md-12">
                    <!-- left column -->
                    <div class="card-deck">
                        <div class="card-header">
                            <h3 class="card-title">Train Detail</h3>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">

                            <table id="" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Description</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%if(tdto!=null){ %>
                                    <tr>
                                        <td><%=tdto.getId()%></td>
                                        <td><%=tdto.getName()%></td>
                                        <td><%=tdto.getDescription()%></td>
                                        
                                    </tr>
                                    <%} else { %>
                                    <tr><td colspan="3" class="bg-gradient-blue text-bold text-center"> No Record </td></tr>
                                    <%}%>
                                   

                            </table>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!--/.col (left) -->
                    <!-- right column -->

                </div>
            </div>
           
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
<!-- Select2 -->
<script src="plugins/select2/js/select2.full.min.js"></script>
<!-- DataTables -->
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        bsCustomFileInput.init();
    });
</script>
<script>
    $(function () {
        $("#example1").DataTable({
            "responsive": true,
            "autoWidth": false,
        });
        $('#example2').DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": false,
            "ordering": true,
            "info": true,
            "autoWidth": false,
            "responsive": true,
        });
    });
</script>
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
</body>
</html>

