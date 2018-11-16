<%-- 
    Document   : home.jsp
    Created on : Nov 15, 2018, 9:12:22 PM
    Author     : let
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="icon" href="../../../../favicon.ico">
    <title>Home Page</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="./styleDashboard.css">
  </head>

  <body>
    <nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
      <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">Banco XPTO</a>
      <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
           <form name="logout" method="POST" action ="home.jsp">
                <input type="submit" id="logout" value="Sign out" name="logout">
            </form> 
              <% String logout_form = request.getParameter("logout");
                  if (request.getParameter("logout") != null) {
                    HttpSession sessao = request.getSession(false);
                    sessao.invalidate();
                    response.sendRedirect("login.jsp");
                }
              %>
        </li>
      </ul>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-light sidebar">
          <div class="sidebar-sticky">
            <ul class="nav flex-column">
              <li class="nav-item">
                <a class="nav-link active" href="#">
                  <span data-feather="home"></span>
                  Home <span class="sr-only">(current)</span>
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="file"></span>
                  Novo saque
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="transferencia.jsp">
                  <span data-feather="shopping-cart"></span>
                  Nova transferência
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="users"></span>
                  Novo depósito
                </a>
              </li>
            </ul>
          </div>
        </nav>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <h2>Banco XPTO</h2>
          <h3>Aqui você encontra:</h3>
          <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="width:900px; height:65vh !important;">
            <ol class="carousel-indicators">
              <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
              <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
              <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner h-100 w-100">
              <div class="carousel-item active w-100 h-100">
                <img class="d-block w-100 h-100" src="https://dicasbancarias.com.br/wp-content/uploads/2016/09/golpe-0302-3.jpg" alt="Depósito">
                <div class="carousel-caption d-none d-md-block">
                  <h5>Depósitos</h5>
                </div>
              </div>
              <div class="carousel-item w-100 h-100">
                <img class="d-block w-100 h-100" src="https://abrilveja.files.wordpress.com/2018/01/istock-90631168.jpg" alt="Saque">
                <div class="carousel-caption d-none d-md-block">
                  <h5>Saques</h5>
                </div>
              </div>
              <div class="carousel-item w-100 h-100">
                <img class="d-block w-100 h-100" src="https://www.telefonescelulares.com.br/wp-content/uploads/2016/10/transferencia.jpg" alt="Transferência">
                <div class="carousel-caption d-none d-md-block">
                  <h5>Trasferências</h5>
                </div>
              </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="sr-only">Next</span>
            </a>
          </div>
        </main>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <!-- Icons -->
    <script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>
    <script>
      feather.replace()
    </script>
  </body>
</html>
