package ugel04.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import ugel04.config.ConexionDB;
import ugel04.modelo.ActivoDTO;
import ugel04.modelo.InstitucionDTO;

public class ActivoDAO implements IActivoDAO {

    private static final String SELECT_ACTIVOS =
            "SELECT a.*, i.nombre_ie, i.distrito "
            + "FROM activos a LEFT JOIN instituciones_educativas i ON a.id_ie_asignada = i.id_ie";

    @Override
    public List<ActivoDTO> listar() throws SQLException {
        List<ActivoDTO> lista = new ArrayList<>();
        String sql = SELECT_ACTIVOS + " ORDER BY a.id_activo DESC";

        try (Connection con = ConexionDB.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(armarActivo(rs));
            }
        }
        return lista;
    }

    @Override
    public List<ActivoDTO> buscar(String texto, String estado, String distrito) throws SQLException {
        List<ActivoDTO> lista = new ArrayList<>();
        List<String> parametros = new ArrayList<>();
        String sql = SELECT_ACTIVOS + " WHERE 1 = 1";

        if (!texto.isEmpty()) {
            sql += " AND (a.codigo_patrimonial LIKE ? OR a.numero_serie LIKE ? OR a.marca LIKE ?"
                    + " OR a.modelo LIKE ? OR i.nombre_ie LIKE ?)";
            for (int i = 0; i < 5; i++) {
                parametros.add("%" + texto + "%");
            }
        }
        if (!estado.isEmpty()) {
            sql += " AND a.estado = ?";
            parametros.add(estado);
        }
        if (!distrito.isEmpty()) {
            sql += " AND i.distrito = ?";
            parametros.add(distrito);
        }
        sql += " ORDER BY a.id_activo DESC";

        try (Connection con = ConexionDB.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            for (int i = 0; i < parametros.size(); i++) {
                ps.setString(i + 1, parametros.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(armarActivo(rs));
                }
            }
        }
        return lista;
    }

    @Override
    public void insertar(ActivoDTO a) throws SQLException {
        String sql = "INSERT INTO activos (codigo_patrimonial, categoria, tipo_equipo, marca, modelo, "
                + "numero_serie, accesorios, id_ie_asignada, estado, observaciones) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionDB.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, a.getCodigoPatrimonial());
            ps.setString(2, a.getCategoria());
            ps.setString(3, a.getTipoEquipo());
            ps.setString(4, a.getMarca());
            ps.setString(5, a.getModelo());
            ps.setString(6, a.getNumeroSerie());
            ps.setString(7, a.getAccesorios());
            if (a.getIdIeAsignada() == null) {
                ps.setNull(8, Types.INTEGER);
            } else {
                ps.setInt(8, a.getIdIeAsignada());
            }
            ps.setString(9, a.getEstado());
            ps.setString(10, a.getObservaciones());
            ps.executeUpdate();
        }
    }

    @Override
    public void actualizar(ActivoDTO a) throws SQLException {
        String sql = "UPDATE activos SET codigo_patrimonial = ?, categoria = ?, tipo_equipo = ?, marca = ?, "
                + "modelo = ?, numero_serie = ?, accesorios = ?, id_ie_asignada = ?, estado = ?, "
                + "observaciones = ? WHERE id_activo = ?";

        try (Connection con = ConexionDB.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, a.getCodigoPatrimonial());
            ps.setString(2, a.getCategoria());
            ps.setString(3, a.getTipoEquipo());
            ps.setString(4, a.getMarca());
            ps.setString(5, a.getModelo());
            ps.setString(6, a.getNumeroSerie());
            ps.setString(7, a.getAccesorios());
            if (a.getIdIeAsignada() == null) {
                ps.setNull(8, Types.INTEGER);
            } else {
                ps.setInt(8, a.getIdIeAsignada());
            }
            ps.setString(9, a.getEstado());
            ps.setString(10, a.getObservaciones());
            ps.setInt(11, a.getIdActivo());
            ps.executeUpdate();
        }
    }

    @Override
    public void darDeBaja(int idActivo, String motivo) throws SQLException {
        String sql = "UPDATE activos SET estado = 'De Baja', id_ie_asignada = NULL, "
                + "observaciones = ? WHERE id_activo = ?";

        try (Connection con = ConexionDB.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, motivo);
            ps.setInt(2, idActivo);
            ps.executeUpdate();
        }
    }

    @Override
    public List<InstitucionDTO> listarInstituciones() throws SQLException {
        List<InstitucionDTO> lista = new ArrayList<>();
        String sql = "SELECT * FROM instituciones_educativas ORDER BY nombre_ie";

        try (Connection con = ConexionDB.getInstancia().getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                InstitucionDTO ie = new InstitucionDTO();
                ie.setIdIe(rs.getInt("id_ie"));
                ie.setCodigoModular(rs.getString("codigo_modular"));
                ie.setNombreIe(rs.getString("nombre_ie"));
                ie.setDistrito(rs.getString("distrito"));
                ie.setDirectorResponsable(rs.getString("director_responsable"));
                ie.setTelefonoContacto(rs.getString("telefono_contacto"));
                lista.add(ie);
            }
        }
        return lista;
    }

    // convierte una fila del ResultSet en un ActivoDTO
    private ActivoDTO armarActivo(ResultSet rs) throws SQLException {
        ActivoDTO a = new ActivoDTO();
        a.setIdActivo(rs.getInt("id_activo"));
        a.setCodigoPatrimonial(rs.getString("codigo_patrimonial"));
        a.setCategoria(rs.getString("categoria"));
        a.setTipoEquipo(rs.getString("tipo_equipo"));
        a.setMarca(rs.getString("marca"));
        a.setModelo(rs.getString("modelo"));
        a.setNumeroSerie(rs.getString("numero_serie"));
        a.setAccesorios(rs.getString("accesorios"));

        int idIe = rs.getInt("id_ie_asignada");
        if (rs.wasNull()) {
            a.setIdIeAsignada(null);
        } else {
            a.setIdIeAsignada(idIe);
        }

        a.setEstado(rs.getString("estado"));
        a.setObservaciones(rs.getString("observaciones"));
        a.setFechaRegistro(rs.getTimestamp("fecha_registro"));
        a.setNombreIe(rs.getString("nombre_ie"));
        a.setDistritoIe(rs.getString("distrito"));
        return a;
    }
}
