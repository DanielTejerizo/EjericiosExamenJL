/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

/**
 *
 * @author DAW
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class Cuentas {
    private static final String DIRECCION = "jdbc:mysql://localhost:3306/cuentas";
    private static final String USUARIO = "Daniel";
    private static final String CONTRASENIA = "Daniel";

    public List<ConstructorCuenta> obtenerCuentasConMasMovimientos() {
    List<ConstructorCuenta> cuentas = new ArrayList<>();
    
    try (Connection conn = DriverManager.getConnection(DIRECCION, USUARIO, CONTRASENIA)) {
        String query = "SELECT CUENTAS.NOMBRE_CTA, COUNT(*) as NUMERO_MOVIMIENTOS FROM CUENTAS c, movimientos m where c.COD_BANCO=m.COD_BANCO AND c.COD_SUCUR=m.COD_SUCUR AND c.NUM_CTA=m.NUM_CTA\n" +
                        "group by NOMBRE_CTA having count(*)=(select max(n)" +
                        "from (select count(*) n" +
                        "from movimientos" +
                        "group by COD_BANCO, COD_SUCUR, NUM_CTA) c1 )";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    ConstructorCuenta cuenta = new ConstructorCuenta();
                    cuenta.setNombre(resultSet.getString("NOMBRE_CTA"));
                    cuenta.setNumeroMovimientos(resultSet.getInt("NUMERO_MOVIMIENTOS"));
                    cuentas.add(cuenta);
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return cuentas;
    }
}