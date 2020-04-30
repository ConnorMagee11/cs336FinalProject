<%-- 
    Document   : editroute
    Created on : Apr 27, 2020, 4:12:16 PM
    Author     : silen
--%>

<%@page import="org.json.JSONArray"%>
<%@page import="DataBase.RouteDBHandler"%>
<%@page import="DTO.RouteDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>

<%if(!(login && (staff || admin))){
    response.sendRedirect("home.jsp");
    return;
}
%>
<% String id_s = request.getParameter("id");
    if (id_s == null) {
        id_s = (String) request.getAttribute("id");
        if (id_s == null) {
            response.sendRedirect("routes.jsp");
            return;
        }
    }
    int id = 0;
    try {
        id = Integer.parseInt(id_s);
    } catch (Exception e) {
        response.sendRedirect("routes.jsp");
        return;
    }
    RouteDTO dto;
    RouteDBHandler db = new RouteDBHandler();
    dto = db.getRouteByID(id);
    if (dto == null) {
        response.sendRedirect("routes.jsp");
        return;
    }

%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Edit Route</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                        <li class="breadcrumb-item active">Edit Route</li>
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
                            <h3 class="card-title">Route Information</h3>
                        </div>
                        <!-- /.card-header -->
                        <!-- form start -->
                        <form role="form" method="post" action="editroute">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="rName">Name</label>
                                    <input type="text" value="<%=dto.getName()%>" required="" minlength="3" class="form-control" id="rName" name="rname" placeholder="">
                                </div>
                                <div class="form-group">
                                    <label for="origin">Origin</label>
                                    <input type="textarea" value="<%=dto.getOrigin()%>" minlength="3" name="origin" class="form-control" id="origin" placeholder="" required="">
                                </div>
                                <div class="form-group">
                                    <label for="destination">Destination</label>
                                    <input type="textarea" minlength="3" value="<%=dto.getDestination()%>" name="destination" class="form-control" id="destination" placeholder="" required="">
                                </div>
                                <input type="hidden" value="<%=dto.getId()%>" name="id" >
                                <div class="form-group">
                                    <label for="destination">Fare</label>
                                    <input type="textarea" min="0" name="fare" value="<%=dto.getFare()%>"class="form-control" id="fare" placeholder="" required="">
                                </div>
                                <div class="form-group">
                                    <label for="duration">Duration(Hours)</label>
                                    <input type="number" name="duration" value="<%=dto.getTimeDuration()%>" min="0" class="form-control" id="duration" placeholder="" required="">
                                </div>
                                <%if (dto.getStops() == null) {%>

                                <div class="form-group">
                                    <label for="capacity">Stops</label>
                                    <input type="number"  min="0" max="15"  name="snum" class="form-control" id="snum" placeholder="" required="">
                                    <input type="button" onclick="edit()" value="add" />
                                    <br>
                                    <span id="sarea"></span>
                                </div>
                                <%} else {
                                    JSONArray arr = new JSONArray(dto.getStops());
                                %>
                                <div class="form-group">
                                    <label for="capacity">Stops</label>
                                    <input type="number" value="<%=arr.length()%>" min="0" max="15" name="snum" class="form-control" id="snum" placeholder="" required="">
                                    <input type="button" onclick="edit()" value="edit" />
                                    <br>
                                    <span id="sarea"><%for (int i = 0; i < arr.length(); i++) {%>
                                        Stop : <%= i + 1%> <input type="text" name="stations" value="<%= arr.getString(i)%>" required="" minlength="3">
                                        <br>
                                        <%}%></span>
                                </div>
                                <%}%>


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
<script type="text/javascript">
                                        $(document).ready(function () {
                                            bsCustomFileInput.init();
                                        });
</script>
<script>
    function edit() {
        var number = document.getElementById("snum").value;
        var container = document.getElementById("sarea");
        while (container.hasChildNodes()) {
            container.removeChild(container.lastChild);
        }
        for (i = 0; i < number; i++) {
            container.appendChild(document.createTextNode("Stop " + (i + 1) + " : "));
            var input = document.createElement("input");
            input.type = "text";
            input.name = "stations";
            input.setAttribute("required", "");
            input.setAttribute("minlength", "3");
            container.appendChild(input);
            container.appendChild(document.createElement("br"));
        }
    }
</script>
</body>
</html>

