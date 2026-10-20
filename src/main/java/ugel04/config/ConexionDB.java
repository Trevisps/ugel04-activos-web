package ugel04.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// Singleton: una sola instancia que entrega las conexiones a MySQL
public class ConexionDB {

    private static ConexionDB instancia;

    private final String url = "jdbc:mysql://localhost:3306/ugel04_activos_db"
            + "?useSSL=false&serverTimezone=America/Lima&allowPublicKeyRetrieval=true";
    private final String usuario = "root";
    private final String clave = "root";

    private ConexionDB() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("No se encontro el driver de MySQL: " + e.getMessage());
        }
    }

    public static synchronized ConexionDB getInstancia() {
        if (instancia == null) {
            instancia = new ConexionDB();
        }
        return instancia;
    }

    public Connection getConexion() throws SQLException {
        return DriverManager.getConnection(url, usuario, clave);
    }
}
