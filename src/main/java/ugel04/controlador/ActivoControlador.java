package ugel04.controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;
import ugel04.dao.ActivoDAO;
import ugel04.dao.IActivoDAO;
import ugel04.modelo.ActivoDTO;
import ugel04.modelo.InstitucionDTO;

@WebServlet(name = "ActivoControlador", urlPatterns = {"/activos"})
public class ActivoControlador extends HttpServlet {

    private IActivoDAO dao = new ActivoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // los mensajes se guardan en la sesion antes de redirigir, aqui se pasan a la vista
        HttpSession sesion = request.getSession();
        request.setAttribute("mensajeOk", sesion.getAttribute("mensajeOk"));
        request.setAttribute("mensajeError", sesion.getAttribute("mensajeError"));
        sesion.removeAttribute("mensajeOk");
        sesion.removeAttribute("mensajeError");

        String texto = leer(request, "q");
        String estado = leer(request, "estado");
        String distrito = leer(request, "distrito");

        List<ActivoDTO> todos = new ArrayList<>();
        List<ActivoDTO> activos = new ArrayList<>();
        List<InstitucionDTO> instituciones = new ArrayList<>();

        try {
            todos = dao.listar();
            instituciones = dao.listarInstituciones();
            if (texto.isEmpty() && estado.isEmpty() && distrito.isEmpty()) {
                activos = todos;
            } else {
                activos = dao.buscar(texto, estado, distrito);
            }
        } catch (SQLException e) {
            request.setAttribute("mensajeError", "Error al consultar la base de datos: " + e.getMessage());
        }

        // contadores de las tarjetas KPI (siempre sobre el total, sin filtros)
        int enAlmacen = 0;
        int asignados = 0;
        int mantenimientoBaja = 0;
        for (ActivoDTO a : todos) {
            String e = a.getEstado();
            if (e.equals("En Almacén")) {
                enAlmacen++;
            } else if (e.equals("Asignado") || e.equals("En Tránsito") || e.equals("En Retorno")) {
                asignados++;
            } else {
                mantenimientoBaja++;
            }
        }

        request.setAttribute("activos", activos);
        request.setAttribute("instituciones", instituciones);
        request.setAttribute("totalActivos", todos.size());
        request.setAttribute("enAlmacen", enAlmacen);
        request.setAttribute("asignados", asignados);
        request.setAttribute("mantenimientoBaja", mantenimientoBaja);
        request.setAttribute("listaEstados", listaEstados());
        request.setAttribute("listaDistritos", listaDistritos());
        request.setAttribute("listaTipos", listaTipos());
        request.setAttribute("filtroTexto", texto);
        request.setAttribute("filtroEstado", estado);
        request.setAttribute("filtroDistrito", distrito);

        request.getRequestDispatcher("/inicio.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession sesion = request.getSession();
        String accion = leer(request, "accion");

        try {
            if (accion.equals("registrar")) {
                ActivoDTO activo = leerActivo(request);
                dao.insertar(activo);
                sesion.setAttribute("mensajeOk", "Activo " + activo.getCodigoPatrimonial() + " registrado correctamente.");

            } else if (accion.equals("actualizar")) {
                ActivoDTO activo = leerActivo(request);
                activo.setIdActivo(aEntero(leer(request, "idActivo")));
                if (activo.getIdActivo() == 0) {
                    throw new IllegalArgumentException("No se indico que activo se va a editar.");
                }
                dao.actualizar(activo);
                sesion.setAttribute("mensajeOk", "Activo " + activo.getCodigoPatrimonial() + " actualizado correctamente.");

            } else if (accion.equals("darBaja")) {
                int id = aEntero(leer(request, "idActivo"));
                String motivo = leer(request, "motivoBaja");
                if (id == 0) {
                    throw new IllegalArgumentException("No se indico que activo se va a dar de baja.");
                }
                if (motivo.isEmpty()) {
                    throw new IllegalArgumentException("Debe indicar el motivo o el N.° de Resolucion Directoral.");
                }
                String observacion = "Baja: " + motivo;
                if (observacion.length() > 255) {
                    observacion = observacion.substring(0, 255);
                }
                dao.darDeBaja(id, observacion);
                sesion.setAttribute("mensajeOk", "El activo fue dado de baja correctamente.");

            } else {
                throw new IllegalArgumentException("Accion no reconocida.");
            }

        } catch (IllegalArgumentException e) {
            sesion.setAttribute("mensajeError", e.getMessage());
        } catch (SQLIntegrityConstraintViolationException e) {
            // codigo patrimonial o numero de serie repetidos
            String detalle = String.valueOf(e.getMessage());
            if (detalle.contains("codigo_patrimonial")) {
                sesion.setAttribute("mensajeError", "Ya existe un activo con ese codigo patrimonial.");
            } else if (detalle.contains("numero_serie")) {
                sesion.setAttribute("mensajeError", "Ya existe un activo con ese numero de serie.");
            } else {
                sesion.setAttribute("mensajeError", "No se pudo guardar: " + detalle);
            }
        } catch (SQLException e) {
            sesion.setAttribute("mensajeError", "Error en la base de datos: " + e.getMessage());
        }

        // redirigimos para que al recargar la pagina no se repita el POST
        response.sendRedirect(request.getContextPath() + "/activos");
    }

    // ---------------------------------------------------------------------

    // arma el ActivoDTO con los datos del formulario y valida las reglas
    private ActivoDTO leerActivo(HttpServletRequest request) {
        ActivoDTO a = new ActivoDTO();

        String codigo = leer(request, "codigoPatrimonial");
        if (!codigo.matches("7408-[0-9]{4}-[0-9]{4}")) {
            throw new IllegalArgumentException("El codigo patrimonial debe tener el formato 7408-XXXX-XXXX.");
        }
        a.setCodigoPatrimonial(codigo);

        String tipo = leer(request, "tipoEquipo");
        String categoria = obtenerCategoria(tipo);
        if (categoria.isEmpty()) {
            throw new IllegalArgumentException("Seleccione un tipo de equipo.");
        }
        a.setTipoEquipo(tipo);
        a.setCategoria(categoria);

        a.setMarca(leerObligatorio(request, "marca", "Marca"));
        a.setModelo(leerObligatorio(request, "modelo", "Modelo"));
        a.setNumeroSerie(leerObligatorio(request, "numeroSerie", "N.° de serie"));

        String accesorios = leer(request, "accesorios");
        if (accesorios.isEmpty()) {
            accesorios = "Sin accesorios";
        }
        a.setAccesorios(accesorios);

        String observaciones = leer(request, "observaciones");
        if (observaciones.isEmpty()) {
            observaciones = "Operativo sin observaciones";
        }
        a.setObservaciones(observaciones);

        // RN-04: coherencia entre estado y colegio
        String estado = leer(request, "estado");
        if (!listaEstados().contains(estado)) {
            throw new IllegalArgumentException("Seleccione un estado valido.");
        }
        a.setEstado(estado);

        if (estado.equals("En Tránsito") || estado.equals("Asignado") || estado.equals("En Retorno")) {
            int idIe = aEntero(leer(request, "idIeAsignada"));
            if (idIe == 0) {
                throw new IllegalArgumentException("El estado '" + estado + "' exige elegir una Institucion Educativa.");
            }
            a.setIdIeAsignada(idIe);
        } else {
            // En Almacén, En Mantenimiento y De Baja no tienen colegio
            a.setIdIeAsignada(null);
        }

        return a;
    }

    private String leerObligatorio(HttpServletRequest request, String campo, String nombre) {
        String valor = leer(request, campo);
        if (valor.isEmpty()) {
            throw new IllegalArgumentException("El campo " + nombre + " es obligatorio.");
        }
        return valor;
    }

    private String obtenerCategoria(String tipo) {
        if (tipo.equals("Laptop") || tipo.equals("Tablet") || tipo.equals("PC Escritorio")) {
            return "Cómputo";
        } else if (tipo.equals("Proyector")) {
            return "Proyección";
        } else if (tipo.equals("Parlante")) {
            return "Multimedia y Audio";
        } else if (tipo.equals("Access Point")) {
            return "Redes";
        }
        return "";
    }

    private List<String> listaEstados() {
        List<String> lista = new ArrayList<>();
        lista.add("En Almacén");
        lista.add("En Tránsito");
        lista.add("Asignado");
        lista.add("En Retorno");
        lista.add("En Mantenimiento");
        lista.add("De Baja");
        return lista;
    }

    private List<String> listaDistritos() {
        List<String> lista = new ArrayList<>();
        lista.add("Comas");
        lista.add("Carabayllo");
        lista.add("Puente Piedra");
        lista.add("Ancón");
        lista.add("Santa Rosa");
        return lista;
    }

    private List<String> listaTipos() {
        List<String> lista = new ArrayList<>();
        lista.add("Laptop");
        lista.add("Tablet");
        lista.add("PC Escritorio");
        lista.add("Proyector");
        lista.add("Parlante");
        lista.add("Access Point");
        return lista;
    }

    private String leer(HttpServletRequest request, String nombre) {
        String valor = request.getParameter(nombre);
        if (valor == null) {
            return "";
        }
        return valor.trim();
    }

    private int aEntero(String texto) {
        try {
            return Integer.parseInt(texto);
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
