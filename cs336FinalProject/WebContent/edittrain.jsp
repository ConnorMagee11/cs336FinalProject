<%-- 
    Document   : edittrain
    Created on : Apr 27, 2020, 4:12:16 PM
    Author     : silen
--%>

<%@page import="DataBase.TrainDBHandler"%>
<%@page import="DTO.TrainDTO"%>
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
            response.sendRedirect("trains.jsp");
            return;
        }
    }
    int id = 0;
    try {
        id = Integer.parseInt(id_s);
    } catch (Exception e) {
        response.sendRedirect("trains.jsp");
        return;
    }
    TrainDTO dto;
    TrainDBHandler db = new TrainDBHandler();
    dto = db.getTrainByID(id);
    if (dto == null) {
        response.sendRedirect("trains.jsp");
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
                    <h1>Edit Train</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                        <li class="breadcrumb-item active">Edit Train</li>
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
                            <h3 class="card-title">Train Information</h3>
                        </div>
                        <!-- /.card-header -->
                        <!-- form start -->
                        <form role="form" action="edittrain" method="post">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="tName">Name</label>
                                    <input type="text" required="" value="<%=dto.getName() %>" minlength="3" class="form-control" id="tName" name="tname" placeholder="">
                                </div>
                                <div class="form-group">
                                    <label for="description">Description</label>
                                    <input type="textarea" value="<%=dto.getDescription() %>" minlength="3" name="description" class="form-control" id="description" placeholder="" required="">
                                </div>
                                <input type="hidden" name="id" value="<%=dto.getId() %>">
                                <div class="form-group">
                                    <label for="capacity">Capacity</label>
                                    <input type="number" value="<%=dto.getCapacity() %>" min="1" name="capacity" class="form-control" id="description" placeholder="" required="">
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
<script type="text/javascript">
    $(document).ready(function () {
        bsCustomFileInput.init();
    });
</script>
</body>
</html>

