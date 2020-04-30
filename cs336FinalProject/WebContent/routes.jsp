<%-- 
    Document   : addtrain
    Created on : Apr 27, 2020, 4:12:16 PM
    Author     : silen
--%>

<%@page import="org.json.JSONArray"%>
<%@page import="DataBase.RouteDBHandler"%>
<%@page import="DTO.RouteDTO"%>
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
                    <h1>Routes</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                        <li class="breadcrumb-item active">Routes</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>
    <%ArrayList<RouteDTO> arr;
        RouteDBHandler db = new RouteDBHandler();
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String destination = request.getParameter("destination");
            String origin = request.getParameter("origin");
            if (!origin.equalsIgnoreCase("all") && !destination.equalsIgnoreCase("all")) {
                arr = db.getAllRouteByOriginAndOrigin(origin, destination);
            } else if (!origin.equalsIgnoreCase("all") && destination.equalsIgnoreCase("all")) {
                arr = db.getAllRouteByOrigin(origin);
            } else if (!origin.equalsIgnoreCase("all") && !destination.equalsIgnoreCase("all")) {
                arr = db.getAllRouteByDestination(destination);
            } else {
                arr = db.getAllRoute();
            }
        } else {
            arr = db.getAllRoute();
        }
        ArrayList<String> destinations = db.getDestinations();
        ArrayList<String> origins = db.getAllOrigins();
    %>
    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <!-- left column -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Routes</h3>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <form action="routes.jsp"  method="post">
                                <div class="row">
                                    <div class="col-md-5">
                                        <div class="form-group">
                                            <label>Origin</label>
                                            <select name="origin" class="form-control select2" style="width: 100%;">
                                                <option value="all">All origins</option>
                                                <%if (origins != null) {
                                                        for (String s : origins) {
                                                %>


                                                <option value="<%=s%>"><%= s%></option>
                                                <%}
                                                    }%>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-5">
                                        <div class="form-group">
                                            <label>Destination</label>
                                            <select name="destination" class="form-control select2" style="width: 100%;">
                                                <option value="all">All Destinations</option>
                                                <%if (destinations != null) {
                                                        for (String s : destinations) {
                                                %>


                                                <option value="<%=s%>"><%= s%></option>
                                                <%}
                                                    }%>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-group">
                                            <label >Filter</label>
                                            <Button type="submit" class="btn btn-block btn-outline-danger">Search</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <table id="example1" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Origin</th>
                                        <th>Destination</th>
                                        <th>Fare</th>
                                        <th>Duration(Hours)</th>
                                        <th>Stops</th>
                                            <%if ((login && (staff || admin))) {

                                            %>
                                        <th>Options</th>
                                            <%}%>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%  if (arr != null) {
                                            for (RouteDTO r : arr) {
                                    %>
                                    <tr>
                                        <td><%=r.getId()%></td>
                                        <td><%=r.getName()%></td>
                                        <td><%=r.getOrigin()%></td>
                                        <td> <%=r.getDestination()%></td>
                                        <td><%=r.getFare()%></td>
                                        <td><%=r.getTimeDuration()%></td>
                                        <td>
                                            <%String s = r.getStops();

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
                                        <%if ((login && (staff || admin))) {

                                        %>
                                        <td><a href="editroute.jsp?id=<%=r.getId()%>" class="btn btn-block btn-outline-danger">Edit</a></td>
                                        <%}%>
                                    </tr>
                                    <%}
                                        }%>

                            </table>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!--/.col (left) -->
                    <!-- right column -->

                </div>
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

