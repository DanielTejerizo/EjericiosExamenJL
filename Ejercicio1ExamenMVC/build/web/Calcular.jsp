<%@page import="java.util.List"%>
<%@ page import="clases.ConstructorCuenta" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Resultado de la consulta</title>
</head>
<body>
    <h2>Resultado de la consulta</h2>
    <table border="1">
        <tr>
            <th>Nombre de la cuenta</th>
            <th>Número de movimientos</th>
        </tr>
        <% 
            List<ConstructorCuenta> cuentasConMovimientos = (List<ConstructorCuenta>)request.getAttribute("cuentasConMovimientos");
            if (cuentasConMovimientos != null) {
                for (ConstructorCuenta cuenta : cuentasConMovimientos) { 
        %>
            <tr>
                <td><%= cuenta.getNombre() %></td>
                <td><%= cuenta.getNumeroMovimientos() %></td>
            </tr>
        <% 
                }
            } else { 
        %>
            <tr>
                <td colspan="2">No se encontraron cuentas con movimientos</td>
            </tr>
        <% 
            } 
        %>
    </table>
    <br>
    <a href="index.html">Volver al inicio</a>
</body>
</html>


