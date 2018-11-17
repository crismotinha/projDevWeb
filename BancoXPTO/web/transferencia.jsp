<%-- 
    Document   : transferencia
    Created on : 16/11/2018, 14:51:40
    Author     : Thales
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="icon" href="../../../../favicon.ico">
    <title>Nova Transferência</title>
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
                <a class="nav-link" href="#">
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
                <a class="nav-link active" href="#">
                  <span data-feather="refresh-cw"></span>
                  Nova transferência
                </a>
              </li>
            </ul>
          </div>
        </nav>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <h2>Banco XPTO</h2>
          <h3>Nova Transferência</h3>
          <form action="./transferencia.jsp" method="POST">
            <div class="form-group">
              <div class="form-row">
                <div class="form-group col-md-6">
                  <label for="agOrigem">Agência de Origem</label>
                  <input type="number" class="form-control" id="agOrigem" placeholder="preencherAquiUsandoJava" value="preencherAquiUsandoJava" readonly>
                </div>
                <div class="form-group col-md-6">
                  <label for="ctOrigem">Conta de Origem</label>
                  <input type="number" class="form-control" id="ctOrigem" placeholder="<% out.print(session.getAttribute("email")); %>" value="<% session.getAttribute("email"); %>" readonly>
                </div>
              </div>
              <div class="form-row">
                <div class="form-group col-md-6">
                  <label for="agDestino">Agência de Destino</label>
                  <input type="number" class="form-control" id="agDestino" placeholder="0001" readonly>
                </div>
                <div class="form-group col-md-6">
                  <label for="ctDestino">Conta de Destino</label>
                  <input type="text" class="form-control" id="ctDestino" placeholder="Conta" name="contaDeDestino"><!--Ver número da conta-->
                </div>
              </div>
              <label for="valor">Valor</label>
              <input type="number" min="1" step="any" class="form-control" name="valor" id="valor" placeholder="Valor">
            </div>
            <button type="submit" class="btn btn-primary" >Realizar Transferência</button>
          </form>
          <br>
          <%
            //Se não encontrar a conta ou a agencia de destino
            String contaIncorreta = "<div class=\"alert alert-danger\" role=\"alert\">Agência/Conta de destino não encontrada</div>";
            //Quando der certo mostrar
            String resultadoPositivo = "<div class=\"alert alert-success\" role=\"alert\">Tansferência realizada com sucesso!</div>";
            //Quando der errado mostrar:
            String resultadoNegativo = "<div class=\"alert alert-danger\" role=\"alert\">Algum erro ocorreu ao realizar sua transferência.</div>";
            String contaDestino = new String(request.getParameter("contaDeDestino"));
            String valorTransferencia = request.getParameter("valor");
            if( contaDestino != null){
                //out.println("<script> alert(\"" + contaDestino + ", " + valorTransferencia + "\")</script>");
                try{
                    Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO", "adm", "123456");
                    PreparedStatement localizaConta = conn.prepareStatement("select email, saldo from Usuario where email = '" + session.getAttribute("email") + "'");
                    ResultSet resultado = localizaConta.executeQuery();
                    resultado.next();
                    String conta = resultado.getString("email");
                    Double saldo = resultado.getDouble("saldo");
                    //out.println("<script>console.log(\"" + contaDestino + "\")</script>");
                    PreparedStatement contaDestinoExiste = conn.prepareStatement("select email from Usuario where email = '" + contaDestino + "'" );
                    resultado = contaDestinoExiste.executeQuery();
                    resultado.next();
                    String sqlContaDestino = resultado.getString("email");
                    if ((sqlContaDestino != null) && (conta != null)){
                        //out.println("<script>console.log(\" Entereing a foreign territory\")</script>");
                        //out.println("<script>alert(" + contaDestino + ")</script>");
                        PreparedStatement transferencia = conn.prepareStatement("update Usuario set saldo = saldo +" + valorTransferencia + "where email = '" + contaDestino + "'");
                        PreparedStatement retiradaOrigem = conn.prepareStatement("update usuario set saldo = saldo -" + valorTransferencia + "where email = '" + session.getAttribute("email") + "'");
                        transferencia.executeUpdate();
                        retiradaOrigem.executeUpdate();
                        conn.commit();
                        out.println(resultadoPositivo);
                    }else if (sqlContaDestino == null){
                        out.println("<script>console.log(\" Entereing a foreign territory\")</script>");
                        out.println(contaIncorreta);
                    }
                }
                catch(Exception e){}
                }
          %>
          
          
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

