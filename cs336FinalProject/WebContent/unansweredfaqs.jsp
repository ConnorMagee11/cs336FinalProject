<%-- 
    Document   : users
    Created on : Apr 28, 2020, 5:30:01 AM
    Author     : silen
--%>

<%@page import="DataBase.QuestionDBHandler"%>
<%@page import="DTO.QuestionDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<%if(!(login && (staff || admin))){
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
                    <h1>FAQS</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                        <li class="breadcrumb-item active">FAQS</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>
    <%ArrayList<QuestionDTO> arr;
        QuestionDBHandler db = new QuestionDBHandler();

        arr = db.getAllUnAnsweredQuestion();


    %>
    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <!-- left column -->
                    <div class="card card-info">
                        <div class="card-header">
                            <h3 class="card-title">Questions</h3>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">

                            <table id="example1" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Question</th>
                                        <th>Ask By</th>
                                        <th>Answer Status</th>
                                        <th>Answer</th>
                                        <th>Answer By</th>
                                        <th>Option</th>
                                        

                                    </tr>
                                </thead>
                                <tbody>
                                    <%  if (arr != null) {
                                            for (QuestionDTO r : arr) {
                                    %>
                                    <tr>
                                        <td><%=r.getId()%></td>
                                        <td><%=r.getQuestion() %></td>
                                        <td><%=r.getQuestioner_name() %></td>
                                        <td><%=r.isIs_answered()?"Answered":"Un Answered" %></td>
                                        <td><%=r.getAnswer()!=null?r.getAnswer():"N/A" %></td>
                                        <td><%=r.getAnswerer_name()!=null?r.getAnswerer_name():"N/A" %></td>
                                        <td><a href="answeraquestion.jsp?id=<%=r.getId()%>" class="btn btn-block btn-outline-success">Answer</a></td>
                                       
                                        
                                    </tr>
                                    <%}
                                    } else { %>
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
