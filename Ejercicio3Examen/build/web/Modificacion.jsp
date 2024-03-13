<%@page import="java.util.ArrayList"%>
<%@page import="misclases.Constructor"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            ArrayList<Constructor> ArrayCredito = (ArrayList<Constructor>) session.getAttribute("credito");
            ArrayList<Constructor> ArrayModif = new ArrayList<>();
            Connection conexion = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conexion = DriverManager.getConnection("jdbc:mysql://localhost/daniel", "Daniel", "Daniel");

                if (ArrayCredito != null) {
                    for (Constructor credito : ArrayCredito) {
                        if (credito.getMediaLimiteCredito() < 47000) {
                            PreparedStatement statement = conexion.prepareStatement("UPDATE Clientes2 SET LimiteCredito = LimiteCredito + 5000 WHERE Pais = ?");
                            statement.setString(1, credito.getPais());
                            statement.executeUpdate();
                            statement.close();
                        }
                    }
                } else {
                    out.println("No se encontraron datos de crédito para mostrar.");
                }
                
                
            
                Statement statement = conexion.createStatement();
                ResultSet result = statement.executeQuery("SELECT Pais, COUNT(*) AS NumeroClientes,  ROUND(AVG(LimiteCredito), 2) AS MediaCredito FROM Clientes2 GROUP BY Pais");

                while (result.next()) {
                    String pais = result.getString("Pais");
                    int numeroClientes = result.getInt("NumeroClientes");
                    double mediaLimiteCredito = result.getDouble("MediaCredito");

                    Constructor constructor = new Constructor(pais, numeroClientes, mediaLimiteCredito);
                    ArrayModif.add(constructor);
                    
                }

                session.setAttribute("credito", ArrayCredito);
            
            }catch (Exception e) {
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
        <table border='1'>
            <tr>
                <th>País</th>
                <th>Número de Clientes</th>
                <th>Media del Límite de Crédito</th>
            </tr>
            <% if (ArrayModif != null) {
                for (Constructor credito : ArrayModif) {%>
            <tr>
                <td><%= credito.getPais()%></td>
                <td><%= credito.getNumeroClientes()%></td>
                <td><%= credito.getMediaLimiteCredito()%></td>
            </tr>
            <%      }
            }%>
        </table>
        <br>

        <a href="index.jsp">Volver al inicio</a>
    </body>
</html>
