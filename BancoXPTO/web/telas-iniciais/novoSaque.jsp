<%-- 
    Document   : novoSaque
    Created on : 15/11/2018, 22:49:07
    Author     : DanielDiniz
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
                <a class="nav-link" href="./home.jsp">
                  <span data-feather="home"></span>
                  Home 
                  <span class="sr-only">(current)</span>
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="saldoExtrato.jsp">
                  <span data-feather="activity"></span>
                  Saldo e Extrato
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link active" href="novoSaque.jsp">
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
                <a class="nav-link" href="novoDeposito.jsp">
                  <span data-feather="users"></span>
                  Novo depósito
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
              <input type="number" min="1" step="any" class="form-control" id="valor" name ="valorSaque" placeholder="Valor">
            </div>
            <button type="submit" class="btn btn-primary" name="saque">Realizar Saque</button>
          </form>
          <br>
          <%
              if(request.getParameter("saque") != null){
                    try {
                        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO",
                                "adm", "123456");
                        
                        ResultSet resultado;
                        
                        /* Valor que deseja sacar */
                        double valorSaque = Double.parseDouble(request.getParameter("valorSaque"));
                        
                        /* Id do usuário */
                        int user_id = Integer.parseInt(session.getAttribute("id").toString());
                        System.out.println("Id user: " + user_id);
                        
                        /* Obtendo id da conta do usuário */
                        PreparedStatement sql = conn.prepareStatement(
                                "SELECT id"
                              + "   FROM conta"
                              + "   WHERE id_usuario = " + user_id // user.id
                        );
                        resultado = sql.executeQuery();
                        int id_conta = -1;
                        if(resultado.next()){
                            id_conta = Integer.parseInt(resultado.getString("id"));
                            System.out.println("Id da conta obtido: " + id_conta);
                        }
                        
                        /* Obtendo saldo atual do usuário */
                        sql = conn.prepareStatement(
                                "SELECT saldo"
                              + "   FROM usuario"
                              + "   WHERE id = " + user_id
                        );
                        resultado = sql.executeQuery();
                        double saldoAtual = 0;
                        if(resultado.next()){
                            saldoAtual = Double.parseDouble(resultado.getString("saldo"));
                            System.out.println("Saldo atual: " + saldoAtual);
                        }
                        
                        if(saldoAtual < valorSaque){
                            %>
                            <div class="alert alert-danger" role="alert">
                            Você não possui essa quantia!
                            </div>
                            <%
                        } else{
                            /* Criando transação */
                            if(id_conta >= 0){
                                /* Obtendo data e hora */
                                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");  
                                Date date = new Date();

                                Statement statementUser = conn.createStatement();
                                statementUser.executeUpdate(
                                        "INSERT INTO transacao(valor, descricao, id_conta)"
                                      + "VALUES (" + -valorSaque + ", 'Saque-" + formatter.format(date) + "', " + id_conta + ")"
                                );
                                resultado = sql.executeQuery();
                                System.out.println("Transação criada");
                            }

                            /* Atualizando saldo */
                            double novoSaldo = saldoAtual - valorSaque;
                            sql = conn.prepareStatement(
                                    "UPDATE usuario"
                                  + "   SET saldo = " + novoSaldo
                                  + "   WHERE id = " + user_id
                            );
                            sql.executeUpdate();
                            %>
                            <div class="alert alert-success" role="alert">
                            Depósito realizado com sucesso!
                            </div>
                            <%
                        }
                        conn.close();
                        %>
                        <%
                    } catch(Exception e){
                        System.out.println("Não foi possível realizar o saque " + e);
                        %> 
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