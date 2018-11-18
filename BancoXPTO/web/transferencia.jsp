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
                <a class="nav-link" href="home.jsp">
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
                  <input type="number" class="form-control" id="agOrigem" placeholder="<%= numeroAgencia(session.getAttribute("email").toString()) %>" value="<%= numeroAgencia(session.getAttribute("email").toString()) %>" readonly>
                </div>
                <div class="form-group col-md-6">
                  <label for="ctOrigem">Conta de Origem</label>
                  <input type="number" class="form-control" id="ctOrigem" placeholder="<%= numeroConta(session.getAttribute("email").toString()) %>" value="<%= numeroConta(session.getAttribute("email").toString()) %>" readonly>
                </div>
              </div>
              <div class="form-row">
                <div class="form-group col-md-6">
                  <label for="agDestino">Agência de Destino</label>
                  <input type="number" class="form-control" id="agDestino" placeholder="Agência" name="agenciaDestino">
                </div>
                <div class="form-group col-md-6">
                  <label for="ctDestino">Conta de Destino</label>
                  <input type="number" class="form-control" id="ctDestino" placeholder="Conta" name="contaDeDestino" required><!--Ver número da conta-->
                </div>
              </div>
              <label for="valor">Valor</label>
              <input type="number" min="1" step="any" class="form-control" name="valor" id="valor" placeholder="Valor" required>
            </div>
            <button type="submit" class="btn btn-primary" >Realizar Transferência</button>
          </form>
          <br>
          <%
            String agenciaDestino = request.getParameter("agenciaDestino");
            String contaDestino = request.getParameter("contaDeDestino");
            String valorTransferencia = request.getParameter("valor");
	    int idContaOrigem = idConta(numeroAgencia(session.getAttribute("email").toString()), numeroConta(session.getAttribute("email").toString()));
            if( (contaDestino != null && agenciaDestino != null) && valorTransferencia != null){
                out.println(transferencia(session.getAttribute("email").toString(), agenciaDestino, contaDestino, valorTransferencia, idContaOrigem));
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

<%!
    
    public String transferencia(String emailOrigem, String agenciaDestino, String contaDestino, String vaalor, int idContaOrigem){
        String contaIncorreta = "<div class=\"alert alert-danger\" role=\"alert\">Agência/Conta de destino não encontrada</div>";
        String resultadoPositivo = "<div class=\"alert alert-success\" role=\"alert\">Tansferência realizada com sucesso!</div>";
        String resultadoNegativo = "<div class=\"alert alert-danger\" role=\"alert\">Algum erro ocorreu ao realizar sua transferência.</div>";
	Double valor = Double.parseDouble(vaalor);
	int idDestino = idUsuarioConta(agenciaDestino, contaDestino);
	if(idDestino > 0){
	    try{
		Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO", "adm", "123456");
		PreparedStatement transferencia = conn.prepareStatement("update Usuario set saldo = saldo + ? where id = ?");
		transferencia.setDouble(1, valor);
		transferencia.setInt(2, idDestino);
		PreparedStatement retiradaOrigem = conn.prepareStatement("update usuario set saldo = saldo - ? where email = ?");
		retiradaOrigem.setDouble(1, valor);
		retiradaOrigem.setString(2, emailOrigem);
		PreparedStatement regTransacaoOrg = conn.prepareStatement("insert into transacao (valor, descricao, id_conta) values ( -" + valor + ", 'TEC - Banco XPTO - Agência: " + agenciaDestino + " - Conta: " + contaDestino + "'," + idConta(agenciaDestino, contaDestino) + ")");
		PreparedStatement regTransacaoDest = conn.prepareStatement("insert into transacao (valor, descricao, id_conta) values ( " + valor + ", 'TEC - Banco XPTO - Agência: " + agenciaDestino + " - Conta: " + contaDestino + "', " + idContaOrigem + ")");
		regTransacaoDest.executeUpdate();
		regTransacaoOrg.executeUpdate();
		transferencia.executeUpdate();
		retiradaOrigem.executeUpdate();
		conn.commit();
		conn.close();
	    }
	    catch(Exception e){
		return e.toString();
	    }
	    return resultadoPositivo;
	}
	else if (idDestino == -1) return contaIncorreta;
	//else if (idDestino == -1) return contaIncorreta;
	else return resultadoNegativo; 
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

    

    public Double getSaldoOrigem(String email){
        Double saldo = 0.0;
        try{
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO", "adm", "123456");
            PreparedStatement localizaUsuario = conn.prepareStatement("select saldo from Usuario where email = ?");
            localizaUsuario.setString(1, email);
            ResultSet resultado = localizaUsuario.executeQuery();
            resultado.next();
            saldo = resultado.getDouble("saldo");
            conn.close();
        }
        catch(Exception e){
            return saldo;
        }
        return saldo;
    }

    public String numeroConta(String email){
        String conta;
        try{
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO", "adm", "123456");
            PreparedStatement localizaUsuario = conn.prepareStatement("select id from Usuario where email = ?");
            localizaUsuario.setString(1, email);
            ResultSet resultado = localizaUsuario.executeQuery();
            PreparedStatement localizaConta = conn.prepareStatement("select numero_conta from conta where id_usuario = ?");
            resultado.next();
            localizaConta.setString(1, resultado.getString("id"));
            resultado = localizaConta.executeQuery();
            resultado.next();
            conta = resultado.getString("numero_conta");
            conn.close();
        }
        catch(Exception e){
            return e.toString();
        }
        return conta;
    } 

    public String numeroAgencia(String email){
        String agencia;
        try{
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO", "adm", "123456");
            PreparedStatement localizaUsuario = conn.prepareStatement("select id from Usuario where email = ?");
            localizaUsuario.setString(1, email);
            ResultSet resultado = localizaUsuario.executeQuery();
            PreparedStatement localizaAgencia = conn.prepareStatement("select agencia from conta where id_usuario = ?");
            resultado.next();
            localizaAgencia.setString(1, resultado.getString("id"));
            resultado = localizaAgencia.executeQuery();
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

