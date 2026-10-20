package ugel04.dao;

import java.sql.SQLException;
import java.util.List;
import ugel04.modelo.ActivoDTO;
import ugel04.modelo.InstitucionDTO;

public interface IActivoDAO {

    List<ActivoDTO> listar() throws SQLException;

    List<ActivoDTO> buscar(String texto, String estado, String distrito) throws SQLException;

    void insertar(ActivoDTO activo) throws SQLException;

    void actualizar(ActivoDTO activo) throws SQLException;

    // baja logica: nunca se hace DELETE
    void darDeBaja(int idActivo, String motivo) throws SQLException;

    List<InstitucionDTO> listarInstituciones() throws SQLException;
}
