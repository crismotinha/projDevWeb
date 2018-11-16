<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
  <title>Login</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <link rel="stylesheet" type="text/css" href="./styleLogin.css">
  <meta charset="utf-8">
</head>
<body class="text-center">
  <form class="form-signin" action="./login.jsp" method="POST">
    <span class="glyphicon glyphicon-piggy-bank"></span>
    <h1 class="h3 mb-3 font-weight-normal">Login</h1>
    <label for="inputEmail" class="sr-only">Email</label>
    <input type="email" name="inputEmail" class="form-control" placeholder="Email" required autofocus>
    <label for="inputPassword" class="sr-only">Senha</label>
    <input type="password" name="inputPassword" class="form-control" placeholder="Senha" required>
    <button class="btn btn-lg btn-primary btn-block" type="submit" name="login">Entrar</button>
    <br>
    Não tem conta? Preencha Email e Senha e<button type="submit" class="btn btn-link" name="novaConta">clique aqui</button>para criar a sua!</a>
  
    
<% 
    String novaConta = request.getParameter("novaConta"); //se o cara clicou em nova conta, isso vai existir, e não vai ser null
    String login = request.getParameter("login"); //se o cara clicou em login, novaConta vai ser null e login não
    String user = request.getParameter("inputEmail");
    String password = request.getParameter("inputPassword");
    
    //criar nova conta
    if (novaConta != null) {
        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO",
                    "adm", "123456");
    
            PreparedStatement userJaExiste = conn.prepareStatement("select id from Usuario where email = '"+user+"'");
            ResultSet userJaExisteResult = userJaExiste.executeQuery();
            String userIdExistente = "";
            while (userJaExisteResult.next()){
                userIdExistente = userJaExisteResult.getString("id");
            }
            if (!userIdExistente.isEmpty()) {
                System.out.println("ja existe esse user");
                 %>
                    <div class="alert alert-danger" role="alert">
                      Esse email já está cadastrado. Faça login!
                    </div> <%
            } else {
            
            Statement statementUser = conn.createStatement();
            statementUser.executeUpdate("insert into Usuario (email, senha, saldo) values ('"+user+"','"+password+"', 0)");
            System.out.println("Usuário Criado");
            PreparedStatement getUser = conn.prepareStatement("select id from Usuario where email = '"+user+"'");
            ResultSet result = getUser.executeQuery();
            String userId = "";
            while (result.next()){
                userId = result.getString("id");
            }
            int intUserId = Integer.parseInt(userId);
            String conta = String.format("%06d", intUserId);
            Statement statementConta = conn.createStatement();
            statementConta.executeUpdate("insert into Conta (agencia, numero_conta, id_usuario) values ('0001', '"+conta+"', "+userId+")");
            System.out.println("Conta Criada");
            conn.close();
           %>
           <div class="alert alert-success" role="alert">
            Conta criada com sucesso! Faça login agora :)
            </div>
          
          <% }
        } catch (Exception e) {
            System.out.println("Erro" + e.toString());
            %>
          <div class="alert alert-danger" role="alert">
            Algum erro ocorreu ao criar sua conta, tente novamente.
          </div> <%
        };
    }

    if (login != null) { // o cara clicou em login
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BancoXPTO",
                    "adm", "123456");
        PreparedStatement pst = conn.prepareStatement("Select email, senha from Usuario where email=? and senha=?");
        pst.setString(1, user);
        pst.setString(2, password);
        ResultSet rs = pst.executeQuery();                        
        if(rs.next()) {
           HttpSession sessao = request.getSession(true);
           session.setAttribute("email", user);
           session.setAttribute("senha", password);
           response.sendRedirect("home.jsp");
        }
        else {
            System.out.println("user nao existe");
            %>
            <div class="alert alert-danger" role="alert">
                Esse usuário não existe. Crie uma conta!
            </div>
        <%
        }
  }
%>
</form>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>