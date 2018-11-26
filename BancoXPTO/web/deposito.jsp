<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Instant"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Object logado = session.getAttribute("id"); 
    if (logado == null) {
        response.sendRedirect("login.jsp");
    }
    else { %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="icon" href="../../../../favicon.ico">
    <title>Depósito</title>
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
                <a class="nav-link" href="saldoExtrato.jsp">
                  <span data-feather="activity"></span>
                  Saldo e Extrato
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link active" href="deposito.jsp">
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
          <h3>Depósito</h3>
          <form action="./deposito.jsp" method="POST">
            <div class="form-group">
              <div class="form-row">
                <div class="form-group col-md-6">
                  <label for="agOrigem">Agência de Depósito</label>
                  <input type="text" class="form-control" id="agOrigem" placeholder="<% out.println(numeroAgencia(Integer.parseInt(session.getAttribute("id").toString()))); %>" value="<% out.println(numeroAgencia(Integer.parseInt(session.getAttribute("id").toString()))); %>" readonly>
                </div>
                <div class="form-group col-md-6">
                  <label for="ctOrigem">Conta de Depósito</label>
                  <input type="text" class="form-control" id="ctOrigem" placeholder="<%out.println(numeroConta(Integer.parseInt(session.getAttribute("id").toString()))); %>" value=" <% out.println(numeroConta(Integer.parseInt(session.getAttribute("id").toString()))); %>" readonly>
                </div>
              </div>
              <div class="form-row">
                
               </div>
              <label for="valor">Valor</label>
              <input type="number" min="1" step="any" class="form-control" name="valor" id="valor" placeholder="Valor" required>
            </div>
            <button type="submit" class="btn btn-primary" >Depósito em Conta</button>
          </form>
          <br>
        <%
            String agenciaDestino = numeroAgencia(Integer.parseInt(session.getAttribute("id").toString()));
            String contaDestino = numeroConta(Integer.parseInt(session.getAttribute("id").toString()));
            String valorTransferencia = request.getParameter("valor");
	    int idContaOrigem = idConta(numeroAgencia(Integer.parseInt(session.getAttribute("id").toString())), numeroConta(Integer.parseInt(session.getAttribute("id").toString())));
	    if( (contaDestino != null && agenciaDestino != null) && (valorTransferencia != null)){
                out.println(deposito(Integer.parseInt(session.getAttribute("id").toString()), agenciaDestino, contaDestino, valorTransferencia, idContaOrigem));
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
<% } %>
<%!
    
    public String deposito(int idOrigem, String agenciaDestino, String contaDestino, String vaalor, int idContaOrigem){
        String valorInferior = "<div class=\"alert alert-danger\" role=\"alert\">Deposito de valor inferior a 1.</div>";
        String contaIncorreta = "<div class=\"alert alert-danger\" role=\"alert\">Agência/Conta de destino não encontrada</div>";
        String resultadoPositivo = "<div class=\"alert alert-success\" role=\"alert\">Operação realizada com sucesso!</div>";
 	String resultadoException = "<div class=\"alert alert-danger\" role=\"alert\">Algum erro ocorreu ao realiar sua operações. Por favor tente mais tarde ou entre em contato com sua agência</div>";
	String agenciaOrigem  = numeroAgencia(idOrigem);
	String contaOrigem = numeroConta(idOrigem);
	Double valor = Double.parseDouble(vaalor);
	int idDestino = idUsuarioConta(agenciaDestino, contaDestino);
  
        if(idDestino > 0 && valor >= 0){     //checar se o id da conta existe, para o depósito não ficar voando
	    try{
		Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO", "adm", "123456");
		PreparedStatement selectFundos = conn.prepareStatement("select saldo from usuario where id = ?");
		if (valor>0){                //garante depósito de valor posivo e maior que 0
		    PreparedStatement deposito = conn.prepareStatement("update Usuario set saldo = saldo + ? where id = ?");
		    deposito.setDouble(1, valor);
		    deposito.setInt(2, idDestino);
		    String horaData = Instant.now().toString();
		    String data = horaData.substring(0, 10);
                    String hora =  horaData.substring(11, 16);
		    PreparedStatement regTransacaoDest = conn.prepareStatement("insert into transacao (valor, descricao, id_conta) values ( " + valor + ", 'DEP de Agência: " + numeroAgencia(idOrigem) + " - Conta: " + numeroConta(idOrigem) + "/ Data: " + data + " - Hora: " + hora + "', " + idContaOrigem + ")");
		    regTransacaoDest.executeUpdate();
                    deposito.executeUpdate();
		    conn.commit();
		}
		else return valorInferior;
		conn.close();
	    }
	    catch(Exception e){
		return ("<script>console.log(\"" + e.toString() + "\")</script> \n" + resultadoException );
	    }
	    return resultadoPositivo;
	}
	else if (idDestino == -1) return contaIncorreta;

	else return valorInferior; 
    }

    int idUsuarioConta(String agencia, String conta){
	int contaEncontrada = 0;
	try{
	    Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO", "adm", "123456");
	    PreparedStatement localizaUsuario = conn.prepareStatement("SELECT * FROM Conta WHERE agencia = ? AND numero_conta = ?");
            localizaUsuario.setString(1, agencia);
	    localizaUsuario.setString(2, conta);
	    ResultSet result = localizaUsuario.executeQuery();
	    result.next();
	    contaEncontrada = result.getInt("id_usuario");
	    conn.close();
	}
	catch(Exception e){
	    contaEncontrada = -1;
	    return contaEncontrada;
	}
	return contaEncontrada;
    }

    int idConta(String agencia, String conta){
	int contaEncontrada = 0;
	try{
	    Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO", "adm", "123456");
	    PreparedStatement localizaUsuario = conn.prepareStatement("SELECT * FROM Conta WHERE agencia = ? AND numero_conta = ?");
            localizaUsuario.setString(1, agencia);
	    localizaUsuario.setString(2, conta);
	    ResultSet result = localizaUsuario.executeQuery();
	    result.next();
	    contaEncontrada = result.getInt("id");
	    conn.close();
	}
	catch(Exception e){
	    contaEncontrada = -1;
	    return contaEncontrada;
	}
	return contaEncontrada;
    }

    public String numeroConta(int id){
        String conta;
        try{
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO", "adm", "123456");
            PreparedStatement localizaConta = conn.prepareStatement("select numero_conta from conta where id_usuario = ?");
            localizaConta.setInt(1, id);
            ResultSet resultado = localizaConta.executeQuery();
            resultado.next();
            conta = resultado.getString("numero_conta");
            conn.close();
        }
        catch(Exception e){
            return e.toString();
        }
        return conta;
    } 

    public String numeroAgencia(int id){
        String agencia;
        try{
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO", "adm", "123456");
            PreparedStatement localizaAgencia = conn.prepareStatement("select agencia from conta where id_usuario = ?");
            localizaAgencia.setInt(1, id);
            ResultSet resultado = localizaAgencia.executeQuery();
            resultado.next();
            agencia = resultado.getString("agencia");
	    conn.close();
        }
        catch(Exception e){
            return e.toString();
        }
        return agencia;
    }
%>
