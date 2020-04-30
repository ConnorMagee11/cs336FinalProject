<%-- 
    Document   : sidebar
    Created on : Apr 27, 2020, 7:56:42 PM
    Author     : silen
--%>

<%@page import="DTO.UserDTO"%>
<% //Session
    String role = (String) session.getAttribute("role");
    UserDTO sessiondto = (UserDTO) session.getAttribute("user");
    Boolean login = (Boolean) session.getAttribute("loggedin");
    Boolean staff = false, admin = false, customer = false;
    if (login == null) {
        login = false;
    }
    if (role != null) {
        if (role.equalsIgnoreCase("staff")) {
            staff = true;
        } else if (role.equalsIgnoreCase("admin")) {
            admin = true;
        } else if (role.equalsIgnoreCase("customer")) {
           customer = true;
        }

    }


%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4">

    <!-- Sidebar -->
    <div class="sidebar">
        <!-- Sidebar user panel (optional) -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <div class="image">
                <img src="dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
            </div>
            <div class="info">
                <%if (login) {%>

                <a href="#" class="d-block"><%= sessiondto.getFirst_name()%></a>
                <%} else {%>
                <a href="#" class="d-block"><%= "Guest User"%></a>
                <%}%>
            </div>
        </div>
        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                <!-- Add icons to the links using the .nav-icon class
                     with font-awesome or any other icon font library -->


                <li class="nav-item has-treeview">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-copy"></i>
                        <p>
                            Routes
                            <i class="fas fa-angle-left right"></i>

                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="routes.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Routes</p>
                            </a>
                        </li>
                        <%if (login && (staff || admin)) {%>
                        <li class="nav-item">
                            <a href="addroute.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Add Route</p>
                            </a>
                        </li>
                        <%}%>

                    </ul>
                </li>
                <li class="nav-item has-treeview">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-copy"></i>
                        <p>
                            Routes Schedule
                            <i class="fas fa-angle-left right"></i>

                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="routeschedule.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Route Schedules</p>
                            </a>
                        </li>
                        <%if (login && (staff || admin)) {%>
                        <li class="nav-item">
                            <a href="addrouteschedule.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Add Route Schedule</p>
                            </a>
                        </li>
                        <%}%>
                    </ul>
                </li>
                <li class="nav-item has-treeview">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-copy"></i>
                        <p>
                            Trains
                            <i class="fas fa-angle-left right"></i>

                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="trains.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Trains</p>
                            </a>
                        </li>
                        <%if (login && (staff || admin)) {%>
                        <li class="nav-item">
                            <a href="addtrain.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Add Train</p>
                            </a>
                        </li>
                        <%}%>




                    </ul>
                </li>
                <%if (login && (staff || admin)) {%>
                <li class="nav-item has-treeview">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-copy"></i>
                        <p>
                            User
                            <i class="fas fa-angle-left right"></i>

                        </p>
                    </a>

                    <ul class="nav nav-treeview">
                        <%if (login && admin) {%>
                        <li class="nav-item">
                            <a href="users.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Users</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="customservicestaffs.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Customer Service Staff</p>
                            </a>
                        </li>
                        <%}%>
                        <li class="nav-item">
                            <a href="customers.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Customer </p>
                            </a>
                        </li>
                        <%if (login && admin) {%>
                        <li class="nav-item">
                            <a href="addstaff.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Add Customer Service Staff</p>
                            </a>
                        </li>
                        <%}%>

                    </ul>
                </li>
                <%}%>
                <li class="nav-item has-treeview">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-copy"></i>
                        <p>
                            Faqs
                            <i class="fas fa-angle-left right"></i>

                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="faqs.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Faqs</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="answeredfaqs.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Answered Questions</p>
                            </a>
                        </li>

                        
                        <%if (login && (staff || admin)) {%>
                        <li class="nav-item">
                            <a href="unansweredfaqs.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Un Answered Questions</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="answerbyfaqs.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Answer By Me</p>
                            </a>
                        </li>
                        <%}%>
                        <%if (login && !(staff || admin)) {%>
                        <li class="nav-item">
                            <a href="askedfaqs.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Ask By Me</p>
                            </a>
                        </li>

                        <li class="nav-item">
                            <a href="askquestion.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Ask Question</p>
                            </a>
                        </li>
                        <%}%>




                    </ul>
                </li>
                <li class="nav-item has-treeview">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-copy"></i>
                        <p>
                            Accounts
                            <i class="fas fa-angle-left right"></i>

                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <%if (login) {%>
                        <li class="nav-item">
                            <a href="changepassword.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Change password</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="editaccount.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Edit Account</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="logout" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Logout</p>
                            </a>
                        </li>
                        <%} else {%>
                        <li class="nav-item">
                            <a href="login.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Login</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="register.jsp" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Create Account</p>
                            </a>
                        </li>
                        <%}%>
                    </ul>
                </li>

            </ul>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>
