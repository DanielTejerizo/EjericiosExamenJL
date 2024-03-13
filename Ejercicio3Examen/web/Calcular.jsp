<%-- 
    Document   : Calcular
    Created on : 11 mar 2024, 18:18:19
    Author     : DAW
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="misclases.Constructor"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Consulta</title>
    </head>

    <body>
        <h1>Consulta</h1>
        <%
            Connection conexion = null;
            ArrayList<Constructor> ArrayCredito = new ArrayList<>();

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conexion = DriverManager.getConnection("jdbc:mysql://localhost/daniel", "Daniel", "Daniel");

                Statement statement = conexion.createStatement();
                ResultSet result = statement.executeQuery("SELECT Pais, COUNT(*) AS NumeroClientes,  ROUND(AVG(LimiteCredito), 2) AS MediaCredito FROM Clientes2 GROUP BY Pais");

                while (result.next()) {
                    String pais = result.getString("Pais");
                    int numeroClientes = result.getInt("NumeroClientes");
                    double mediaLimiteCredito = result.getDouble("MediaCredito");

                    Constructor constructor = new Constructor(pais, numeroClientes, mediaLimiteCredito);
                    ArrayCredito.add(constructor);
                    
                }

                session.setAttribute("credito", ArrayCredito);

                out.println("<table border='1'>");
                out.println("<tr><th>País</th><th>Número de Clientes</th><th>Media del Límite de Crédito</th></tr>");

                for (Constructor constructor : ArrayCredito) {
                    out.println("<tr>");
                    out.println("<td>" + constructor.getPais() + "</td>");
                    out.println("<td>" + constructor.getNumeroClientes() + "</td>");
                    out.println("<td>" + constructor.getMediaLimiteCredito() + "</td>");
                    out.println("</tr>");
                }

                out.println("</table>");

                result.close();
                statement.close();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (conexion != null) {
                    try {
                        conexion.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
        <br>
        <a href="Modificacion.jsp">Modificación</a>
    </body>

</html>
