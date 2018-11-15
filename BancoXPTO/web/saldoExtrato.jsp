<%-- 
    Document   : saldoExtrato
    Created on : 15/11/2018, 19:23:03
    Author     : DanielDiniz
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="../../../../favicon.ico">
        <title>Saldo e Extrato</title>
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
          <h3>Saldo e Extrato</h3>
          <div class="card-deck">
              <div class="card">
                <div class="card-body">
                  <h5 class="card-title">Saldo</h5>
                  <p class="card-text">R$90,00</p>
                </div>
              </div>
              <div class="card">
                <div class="card-body">
                  <h5 class="card-title">Extrato</h5>
                  <div class="table-responsive">
                    <table class="table table-striped table-sm">
                      <thead>
                        <tr>
                          <th>Data</th>
                          <th>Descrição</th>
                          <th>Valor</th>
                        </tr>
                      </thead>
                      <tbody>
                        <% 
                            //float saldo = user.saldo;
                            try {
                                Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO",
                                        "adm", "123456");
                                PreparedStatement sql = conn.prepareStatement(
                                        "SELECT t.descricao AS Descricao t.valor AS Valor"
                                      + "   FROM conta AS c INNER JOIN transacao as t ON c.id = t.id_conta"
                                      + "   WHERE c.id_usuario = " + "user.id"
                                );
                                ResultSet resultado = sql.executeQuery();
                                while(resultado.next()){
                                    if(Integer.parseInt(resultado.getString("qtd_Estoque"))==0){
                                        %><tr style="color:red; font-weight: bold;">
                                            <td><%=resultado.getString("id_produto")%></td>
                                            <td><%=resultado.getString("nome")%></td>
                                            <td>R$<%=resultado.getString("preco")%></td>
                                            <td><%=resultado.getString("qtd_Estoque")%></td>
                                            <td><%=resultado.getString("percentual_desconto")%></td>
                                            <td></td>
                                        </tr>
                                       <%
                                    } else {
                                        %><tr>
                                            <td><%=resultado.getString("id_produto")%></td>
                                            <td><%=resultado.getString("nome")%></td>
                                            <td>R$<%=resultado.getString("preco")%></td>
                                            <td><%=resultado.getString("qtd_Estoque")%></td>
                                            <td><%=resultado.getString("percentual_desconto")%></td>
                                            <td><button>Publicar no site</button></td>
                                        </tr>
                                    <%}
                                }
                                sql.close();
                                conn.close();
                            } catch(Exception e) {
                                System.out.println("Erro no banco:" + e.toString());
                            }
                        %>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
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
