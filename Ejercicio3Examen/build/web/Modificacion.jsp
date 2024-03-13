<%-- 
    Document   : Modificacion
    Created on : 11 mar 2024, 18:29:42
    Author     : DAW
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="misclases.Constructor"%>
<%@page import="java.sql.*"%>
<%
    ArrayList<Constructor> ArrayCredito = (ArrayList<Constructor>) application.getAttribute("credito");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table border='1'>
            <tr>
                <th>País</th>
                <th>Número de Clientes</th>
                <th>Media del Límite de Crédito</th>
            </tr>
            <%
                if (ArrayCredito != null) {
                    for (Constructor credito : ArrayCredito) {
                        if (credito.getMediaLimiteCredito() < 47000) {
                            try {
                                Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost/daniel", "Daniel", "Daniel");
                                PreparedStatement statement = conexion.prepareStatement("UPDATE Clientes2 SET LimiteCredito = LimiteCredito + 5000 WHERE Pais = ?");
                                statement.setString(1, credito.getPais());
                                statement.executeUpdate();
                                statement.close();
                                conexion.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
            %>
            <tr>
                <td><%= credito.getPais()%></td>
                <td><%= credito.getNumeroClientes()%></td>
                <td><%= credito.getMediaLimiteCredito()%></td>
            </tr>
            <%
                    } 
                } else {
                    out.println("No se encontraron datos de crédito para mostrar.");
                }
            %>

        </table>
        <a href="index.jsp">Volver al inicio</a>
    </body>
</html>