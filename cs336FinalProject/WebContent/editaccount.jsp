<%-- 
    Document   : editaccount
    Created on : Apr 27, 2020, 4:12:16 PM
    Author     : silen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>

<%if (!(login && sessiondto != null)) {
        response.sendRedirect("home.jsp");
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
                    <h1>Edit Account</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                        <li class="breadcrumb-item active">Edit Account</li>
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
                            <h3 class="card-title">Account Information</h3>
                        </div>
                        <!-- /.card-header -->
                        <!-- form start -->
                        <form role="form" action="editaccount" method="post">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="fname">First Name</label>
                                    <input value="<%=sessiondto.getFirst_name()%>" type="text" class="form-control" required="" name="fname" placeholder="Fisrt name" >
                                </div>
                                <div class="form-group">
                                    <label for="fname">Last Name</label>
                                    <input type="text" value="<%=sessiondto.getLast_name()%>" class="form-control" required="" name="lname" placeholder="Last name" >
                                </div>
                                <div class="form-group">
                                    <label for="description">Email</label>
                                    <input type="email" value="<%=sessiondto.getEmail()%>" required="" name="email" class="form-control" placeholder="Email">
                                </div>

                                <div class="form-group">
                                    <label for="">Address</label>
                                    <input type="text" value="<%=sessiondto.getAddress()%>"class="form-control" required="" name="address" placeholder="Address">
                                </div>
                                <div class="form-group">

                                    <label for="">Gender</label>
                                    <%if (sessiondto.getGender().equalsIgnoreCase("male")) {%>
                                    <div class="input-group mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" checked="" type="radio" value="Male" name="gender">
                                            <label class="form-check-label">Male</label>
                                        </div>
                                        &nbsp&nbsp
                                        <div class="form-check">

                                            <input class="form-check-input" type="radio" value="Fe Male" name="gender">
                                            <label class="form-check-label">Fe Male</label>
                                        </div>

                                    </div>
                                    <%} else {%>
                                      <div class="input-group mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input"  type="radio" value="Male" name="gender">
                                            <label class="form-check-label">Male</label>
                                        </div>
                                        &nbsp&nbsp
                                        <div class="form-check">

                                            <input class="form-check-input" type="radio" checked="" value="Fe Male" name="gender">
                                            <label class="form-check-label">Fe Male</label>
                                        </div>

                                    </div>
                                    <%}%>
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

