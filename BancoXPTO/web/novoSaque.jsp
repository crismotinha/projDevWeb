<%-- 
    Document   : novoSaque
    Created on : 15/11/2018, 22:49:07
    Author     : DanielDiniz
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="../../../../favicon.ico">
        <title>Novo Saque</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="./styleDashboard.css">
    </head>
    <body>
            <nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
      <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">Banco XPTO</a>
      <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
          <a class="nav-link" href="#">Sign out</a>
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
                  <span data-feather="activity"></span>
                  Saldo e Extrato
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="arrow-up-circle"></span>
                  Novo depósito
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="arrow-down-circle"></span>
                  Novo saque
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="refresh-cw"></span>
                  Nova transferência
                </a>
              </li>
            </ul>
          </div>
        </nav>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <h2>Banco XPTO</h2>
          <h3>Novo Saque</h3>
          <form>
            <div class="form-group">
              <label for="valor">Valor</label>
              <input type="number" min="1" step="any" class="form-control" id="valor" name ="value" placeholder="Valor">
            </div>
            <button type="submit" class="btn btn-primary" name="saque">Realizar Saque</button>
          </form>
          <br>
          <%
              if(request.getParameter("saque") != null){
                    double valor = Double.parseDouble(request.getParameter("value"));
                    double saldo = 100; // user.saldo
                    if(saldo >= valor){
                        // diminuir saldo a partir da session
                        
                        // insere transacao na conta do usuario
                        try {
                            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO",
                                    "adm", "123456");
                            
                            // pegando conta do usuario
                            int id_conta;
                            PreparedStatement sql = conn.prepareStatement(
                                    "SELECT id"
                                  + "   FROM conta"
                                  + "   WHERE id_usuario = " + 1 // user.id
                            );
                            ResultSet resultado = sql.executeQuery();
                            
                            id_conta = Integer.parseInt(resultado.getString("id")); // não sei porque está dando erro nessa linha, não estou entendendo
                            
                            // inserindo transacao
                            Statement statementUser = conn.createStatement();
                            statementUser.executeUpdate(
                                    "INSERT INTO transacao(valor, descricao, id_conta)"
                                  + "VALUES (" + valor + ", 'Saque', " + id_conta + ")"
                            );
                            resultado = sql.executeQuery();
                            
                            conn.close();
                        } catch(Exception e){
                            System.out.println("deu merda no saque" + e);
                        }
                %><div class="alert alert-success" role="alert">
                  Saque realizado com sucesso!
                </div>
                  <%} else{ %>
                <div class="alert alert-danger" role="alert">
                  Algum erro ocorreu ao realizar seu saque.
                </div>
                <% } 
            }%>
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
