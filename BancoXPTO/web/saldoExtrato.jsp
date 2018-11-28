<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Object user = session.getAttribute("id"); 
    if (user == null) {
        response.sendRedirect("login.jsp");
    }
    else { %>
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
                <a class="nav-link" href="home.jsp">
                  <span data-feather="home"></span>
                  Home <span class="sr-only">(current)</span>
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link active" href="saldoExtrato.jsp">
                  <span data-feather="activity"></span>
                  Saldo e Extrato
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="deposito.jsp">
                  <span data-feather="arrow-up-circle"></span>
                  Novo depósito
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="saque.jsp">
                  <span data-feather="arrow-down-circle"></span>
                  Novo saque
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="transferencia.jsp">
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
                  <p class="card-text">
                      Seu saldo atual é R$
                      <%
                          try {
                            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO",
                                    "adm", "123456");
                            
                            /* Id do usuário */
                            int user_id = Integer.parseInt(session.getAttribute("id").toString());
                            
                            /* Obtendo saldo atual do usuário */
                             PreparedStatement sql = conn.prepareStatement(
                                      "SELECT saldo"
                                    + "   FROM usuario"
                                    + "   WHERE id = " + user_id
                              );
                              ResultSet resultado = sql.executeQuery();
                              
                              if(resultado.next()){
                                double saldoAtual = Double.parseDouble(resultado.getString("saldo"));
                                out.println("<b>" + saldoAtual + "</b>");
                              }
                              
                          } catch (Exception e){
                              System.out.println("Erro no banco:");
                          }
                      %>
                  </p>
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
                            int user_id = Integer.parseInt(session.getAttribute("id").toString());;
                            try {
                                Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO",
                                        "adm", "123456");
                                
                                PreparedStatement sql = conn.prepareStatement(
                                        "SELECT t.descricao AS Descricao, t.valor AS Valor"
                                      + "   FROM conta AS c INNER JOIN transacao as t ON c.id = t.id_conta"
                                      + "   WHERE c.id_usuario = " + user_id
                                );
                                ResultSet transacoes = sql.executeQuery();
                                while(transacoes.next()){
                                %>
                                    <tr>
                                        <% String texto = transacoes.getString("Descricao"); %>
                                        <td>
                                            <%
                                                /* Isso aqui é pra caso já tenha Descrições sem a data no Banco,
                                                   daí se não houver data ele não dá erro 
                                                   (é temporário, só para os testes)*/
                                                
                                                /* Imprimindo Descrição */
                                                if(texto.indexOf("|") != -1){
                                                    out.println(texto.substring(texto.indexOf("|")+1,texto.length()));
                                                } else {
                                                    out.println("");    
                                                }
                                            %>
                                        </td>
                                        <td>
                                            <%
                                                /* Isso aqui é pra caso já tenha Descrições sem a data no Banco,
                                                   daí se não houver data ele não dá erro 
                                                   (é temporário, só para os testes)*/
                                                
                                                /* Imprimindo Data */
                                                if(texto.indexOf("|") != -1){
                                                    out.println(texto.substring(0,texto.indexOf("|")));
                                                } else {
                                                    out.println("");    
                                                }
                                            %>
                                        </td>
                                        <td><%=transacoes.getString("Valor")%></td>
                                    </tr>
                                <%
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
<%} // fecha a session
%>