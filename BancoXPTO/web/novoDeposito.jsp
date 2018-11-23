<%-- 
    Document   : novoDeposito
    Created on : 15/11/2018, 23:44:09
    Author     : DanielDiniz
--%>

<%@page import="java.sql.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Instant"%>

 <%@page import="java.sql.Statement"%>
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
        <title>Novo Depósito</title>
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
          <h3>Novo Depósito</h3>
          <form>
            <div class="form-group">
              <label for="valor">Valor</label>
              <input type="number" min="1" step="any" class="form-control" id="valor" name="value" placeholder="Valor">
            </div>
            <button name="deposito" type="submit" class="btn btn-primary">Realizar Depósito</button>
          </form>
          <br>
          
            <script>
            Var a = (Integer.parseInt(session.getAttribute("id").toString()));
            Var b = session.getAttribute("id");
           console.log(a);
           console.log(b);
           console.log("b");
           </script>
          
          <%
              if(request.getParameter("deposito") != null){
                    double valorDeposito = Double.parseDouble(request.getParameter("value"));
                    double saldo = valorDeposito; // atualiza saldo do usuario usando a session
                        try {
                            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO",
                                    "adm", "123456");
                            
                            // pegando conta do usuario
                            int id_conta;
                            PreparedStatement sql = conn.prepareStatement(
                                    "SELECT ID"
                                  + "   FROM Conta"
                                  + "   WHERE ID_USUARIO = " + 1 // user.id
                            );
                            ResultSet resultado = sql.executeQuery();
                            
                            id_conta = Integer.parseInt(resultado.getString("id")); // não sei porque está dando erro nessa linha, não estou entendendo
                            
                            // inserindo transacao
                            Statement statementUser = conn.createStatement();
                            statementUser.executeUpdate(
                                    "INSERT INTO transacao(valor, descricao, id_conta)"
                                  + "VALUES (" + valorDeposito + ", 'Deposito', " + id_conta + ")"
                            );
                            resultado = sql.executeQuery();
                                                    conn.close();
                            
                            %>
                            <div class="alert alert-success" role="alert">
                                Depósito realizado com sucesso!
                            </div>
                            <%
                        } catch(Exception e){
                            System.out.println("deu merda no deposito " + e);
                            %> 
                            
                            console.log(resultado);
                            
                            <div class="alert alert-danger" role="alert">
                                Algum erro ocorreu ao realizar seu depósito.
                            </div>
                        <% } 
                }%>
                
                
 <script>

console.log("Hello world!");
console.log("b");
</script>

        <script>
           var idContaOrigem = (numeroAgencia(Integer.parseInt(session.getAttribute("id").toString())));
            Var b = session.getAttribute("id");
           console.log(idContaOrigem);
           console.log(b);
          </script>


         
              
            <% // <script>console.log(Integer.parseInt(session.getAttribute("id").toString())));</script>%>
            
        
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

<%
            String agenciaDestino = request.getParameter("agenciaDestino");
            String contaDestino = request.getParameter("contaDeDestino");
            String valorTransferencia = request.getParameter("value");
//	    int idContaOrigem = idConta(numeroAgencia(Integer.parseInt(session.getAttribute("id").toString())), numeroConta(Integer.parseInt(session.getAttribute("id").toString())));
//	    if( (contaDestino != null && agenciaDestino != null) && (valorTransferencia != null)){
//                out.println(transferencia(Integer.parseInt(session.getAttribute("id").toString()), agenciaDestino, contaDestino, valorTransferencia, idContaOrigem));
//	    }
	    
          %>
          
          
       