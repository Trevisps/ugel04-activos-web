<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<jsp:include page="header.jsp"/>

<main class="contenedor principal">

    <!-- Mensajes -->
    <c:if test="${not empty mensajeOk}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i><c:out value="${mensajeOk}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty mensajeError}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i><c:out value="${mensajeError}"/>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Tarjetas KPI -->
    <section class="kpis">
        <div class="kpi kpi-coral">
            <div class="kpi-texto">
                <span class="kpi-titulo">Total Activos:</span>
                <span class="kpi-numero"><c:out value="${totalActivos}"/></span>
            </div>
            <div class="kpi-circulo"><i class="bi bi-database"></i></div>
        </div>

        <div class="kpi kpi-menta">
            <div class="kpi-texto">
                <span class="kpi-titulo">Disponibles en Almacén:</span>
                <span class="kpi-numero"><c:out value="${enAlmacen}"/></span>
            </div>
            <div class="kpi-circulo"><i class="bi bi-box-seam"></i></div>
        </div>

        <div class="kpi kpi-cielo">
            <div class="kpi-texto">
                <span class="kpi-titulo">Asignados a II.EE.:</span>
                <span class="kpi-numero"><c:out value="${asignados}"/></span>
            </div>
            <div class="kpi-circulo"><i class="bi bi-building"></i></div>
        </div>

        <div class="kpi kpi-ambar">
            <div class="kpi-texto">
                <span class="kpi-titulo">En Mantenimiento / Baja:</span>
                <span class="kpi-numero"><c:out value="${mantenimientoBaja}"/></span>
            </div>
            <div class="kpi-circulo"><i class="bi bi-tools"></i></div>
        </div>
    </section>

    <!-- Búsqueda y filtros -->
    <form method="get" action="${ctx}/activos" class="filtros">
        <div class="buscador">
            <i class="bi bi-search"></i>
            <input type="text" name="q" value="<c:out value='${filtroTexto}'/>"
                   placeholder="Buscar por serie, código SBN, marca o colegio...">
        </div>

        <select name="estado" id="filtroEstado" class="form-select filtro-select">
            <option value="">Estado: Todos</option>
            <c:forEach var="e" items="${listaEstados}">
                <option value="${e}" ${e eq filtroEstado ? 'selected' : ''}>${e}</option>
            </c:forEach>
        </select>

        <select name="distrito" id="filtroDistrito" class="form-select filtro-select">
            <option value="">Distrito / I.E.: Todos</option>
            <c:forEach var="d" items="${listaDistritos}">
                <option value="${d}" ${d eq filtroDistrito ? 'selected' : ''}>${d}</option>
            </c:forEach>
        </select>

        <button type="submit" class="btn-filtro" title="Filtrar"><i class="bi bi-funnel"></i></button>
        <a href="${ctx}/activos" class="btn-filtro" title="Limpiar filtros"><i class="bi bi-x-lg"></i></a>

        <button type="button" class="btn-registrar" title="Añadir un nuevo bien"
                data-bs-toggle="modal" data-bs-target="#modalRegistrar">
            <i class="bi bi-plus-lg"></i> Registrar Nuevo Activo
        </button>
    </form>

    <!-- Ficha de inventario -->
    <section class="ficha">
        <div class="ficha-titulo">
            <h2><i class="bi bi-clipboard-data"></i> Ficha de Inventario Central</h2>
            <span><c:out value="${activos.size()}"/> registro(s)</span>
        </div>

        <div class="tabla-contenedor">
            <table class="tabla">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Código SBN</th>
                        <th>Equipo</th>
                        <th>Marca / Modelo</th>
                        <th>N° de Serie</th>
                        <th>Ubicación / I.E. Destino</th>
                        <th>Kit / Accesorios</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="a" items="${activos}" varStatus="fila">

                        <!-- icono y color según el tipo de equipo -->
                        <c:choose>
                            <c:when test="${a.tipoEquipo eq 'Laptop'}">
                                <c:set var="icono" value="bi-laptop"/><c:set var="colorIcono" value="ico-laptop"/>
                            </c:when>
                            <c:when test="${a.tipoEquipo eq 'Proyector'}">
                                <c:set var="icono" value="bi-projector"/><c:set var="colorIcono" value="ico-proyector"/>
                            </c:when>
                            <c:when test="${a.tipoEquipo eq 'Tablet'}">
                                <c:set var="icono" value="bi-tablet"/><c:set var="colorIcono" value="ico-tablet"/>
                            </c:when>
                            <c:when test="${a.tipoEquipo eq 'Parlante'}">
                                <c:set var="icono" value="bi-speaker"/><c:set var="colorIcono" value="ico-parlante"/>
                            </c:when>
                            <c:when test="${a.tipoEquipo eq 'PC Escritorio'}">
                                <c:set var="icono" value="bi-pc-display"/><c:set var="colorIcono" value="ico-pc"/>
                            </c:when>
                            <c:when test="${a.tipoEquipo eq 'Access Point'}">
                                <c:set var="icono" value="bi-router"/><c:set var="colorIcono" value="ico-ap"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="icono" value="bi-hdd"/><c:set var="colorIcono" value="ico-laptop"/>
                            </c:otherwise>
                        </c:choose>

                        <!-- clase e icono según el estado -->
                        <c:choose>
                            <c:when test="${a.estado eq 'Asignado'}">
                                <c:set var="claseEstado" value="est-asignado"/><c:set var="iconoEstado" value="bi-check-circle-fill"/>
                            </c:when>
                            <c:when test="${a.estado eq 'En Almacén'}">
                                <c:set var="claseEstado" value="est-almacen"/><c:set var="iconoEstado" value="bi-box-seam"/>
                            </c:when>
                            <c:when test="${a.estado eq 'En Tránsito'}">
                                <c:set var="claseEstado" value="est-transito"/><c:set var="iconoEstado" value="bi-truck"/>
                            </c:when>
                            <c:when test="${a.estado eq 'En Retorno'}">
                                <c:set var="claseEstado" value="est-retorno"/><c:set var="iconoEstado" value="bi-arrow-return-left"/>
                            </c:when>
                            <c:when test="${a.estado eq 'En Mantenimiento'}">
                                <c:set var="claseEstado" value="est-mantenimiento"/><c:set var="iconoEstado" value="bi-wrench"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="claseEstado" value="est-baja"/><c:set var="iconoEstado" value="bi-x-octagon-fill"/>
                            </c:otherwise>
                        </c:choose>

                        <tr>
                            <td class="gris">${fila.count}</td>
                            <td><span class="mono codigo"><c:out value="${a.codigoPatrimonial}"/></span></td>
                            <td>
                                <div class="equipo">
                                    <span class="ico-equipo ${colorIcono}"><i class="bi ${icono}"></i></span>
                                    <span class="equipo-nombre"><c:out value="${a.tipoEquipo}"/></span>
                                </div>
                            </td>
                            <td>
                                <strong><c:out value="${a.marca}"/></strong><br>
                                <span class="gris"><c:out value="${a.modelo}"/></span>
                            </td>
                            <td><span class="mono"><c:out value="${a.numeroSerie}"/></span></td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty a.idIeAsignada}">
                                        <span class="almacen-central">[Almacén Central UGEL 04]</span>
                                    </c:when>
                                    <c:otherwise>
                                        <c:out value="${a.nombreIe}"/> (<c:out value="${a.distritoIe}"/>)
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="gris"><c:out value="${a.accesorios}"/></td>
                            <td>
                                <span class="estado ${claseEstado}">
                                    <i class="bi ${iconoEstado}"></i> <c:out value="${a.estado}"/>
                                </span>
                            </td>
                            <td>
                                <div class="acciones">
                                    <button type="button" class="btn-editar btn-editar-activo" title="Editar / Asignar activo"
                                            data-bs-toggle="modal" data-bs-target="#modalEditar"
                                            data-id="${a.idActivo}"
                                            data-codigo="<c:out value='${a.codigoPatrimonial}'/>"
                                            data-serie="<c:out value='${a.numeroSerie}'/>"
                                            data-tipo="<c:out value='${a.tipoEquipo}'/>"
                                            data-marca="<c:out value='${a.marca}'/>"
                                            data-modelo="<c:out value='${a.modelo}'/>"
                                            data-accesorios="<c:out value='${a.accesorios}'/>"
                                            data-estado="<c:out value='${a.estado}'/>"
                                            data-ie="<c:out value='${a.idIeAsignada}'/>"
                                            data-obs="<c:out value='${a.observaciones}'/>">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button type="button" class="btn-baja btn-baja-activo"
                                            data-bs-toggle="modal" data-bs-target="#modalBaja"
                                            data-id="${a.idActivo}"
                                            data-codigo="<c:out value='${a.codigoPatrimonial}'/>"
                                            data-serie="<c:out value='${a.numeroSerie}'/>"
                                            ${a.estado eq 'De Baja' ? 'disabled' : ''}>
                                        Dar de Baja
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty activos}">
                        <tr>
                            <td colspan="9" class="sin-datos">No se encontraron activos.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </section>
</main>

<!-- Modal: registrar activo -->
<div class="modal fade" id="modalRegistrar" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <form class="modal-content" method="post" action="${ctx}/activos" id="formRegistrar">
            <input type="hidden" name="accion" value="registrar">
            <div class="modal-header cabecera-roja">
                <h5 class="modal-title"><i class="bi bi-plus-circle me-2"></i>Registrar Nuevo Activo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label" for="regCodigo">Código patrimonial (SBN)</label>
                        <input type="text" class="form-control mono" id="regCodigo" name="codigoPatrimonial"
                               maxlength="14" pattern="7408-[0-9]{4}-[0-9]{4}" placeholder="7408-0000-0000" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="regSerie">N° de serie</label>
                        <input type="text" class="form-control mono" id="regSerie" name="numeroSerie" maxlength="50" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="regTipo">Tipo de equipo</label>
                        <select class="form-select" id="regTipo" name="tipoEquipo" required>
                            <option value="">-- Seleccione --</option>
                            <c:forEach var="t" items="${listaTipos}">
                                <option value="${t}">${t}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="regCategoria">Categoría (automática)</label>
                        <input type="text" class="form-control" id="regCategoria" readonly>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="regMarca">Marca</label>
                        <input type="text" class="form-control" id="regMarca" name="marca" maxlength="50" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="regModelo">Modelo</label>
                        <input type="text" class="form-control" id="regModelo" name="modelo" maxlength="80" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label" for="regAccesorios">Kit / Accesorios</label>
                        <input type="text" class="form-control" id="regAccesorios" name="accesorios" maxlength="200">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="regEstado">Estado</label>
                        <select class="form-select" id="regEstado" name="estado" required>
                            <c:forEach var="e" items="${listaEstados}">
                                <option value="${e}">${e}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="regIe">Institución Educativa</label>
                        <select class="form-select" id="regIe" name="idIeAsignada">
                            <option value="">[Almacén Central UGEL 04]</option>
                            <c:forEach var="ie" items="${instituciones}">
                                <option value="${ie.idIe}">${ie.nombreIe} (${ie.distrito})</option>
                            </c:forEach>
                        </select>
                        <div class="form-text" id="regIeAyuda"></div>
                    </div>
                    <div class="col-12">
                        <label class="form-label" for="regObs">Observaciones</label>
                        <textarea class="form-control" id="regObs" name="observaciones" rows="2" maxlength="255"></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-danger">Guardar activo</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal: editar / asignar activo -->
<div class="modal fade" id="modalEditar" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <form class="modal-content" method="post" action="${ctx}/activos" id="formEditar">
            <input type="hidden" name="accion" value="actualizar">
            <input type="hidden" name="idActivo" id="editId">
            <div class="modal-header cabecera-roja">
                <h5 class="modal-title"><i class="bi bi-pencil me-2"></i>Editar / Asignar Activo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label" for="editCodigo">Código patrimonial (SBN)</label>
                        <input type="text" class="form-control mono" id="editCodigo" name="codigoPatrimonial"
                               maxlength="14" pattern="7408-[0-9]{4}-[0-9]{4}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="editSerie">N° de serie</label>
                        <input type="text" class="form-control mono" id="editSerie" name="numeroSerie" maxlength="50" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="editTipo">Tipo de equipo</label>
                        <select class="form-select" id="editTipo" name="tipoEquipo" required>
                            <option value="">-- Seleccione --</option>
                            <c:forEach var="t" items="${listaTipos}">
                                <option value="${t}">${t}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="editCategoria">Categoría (automática)</label>
                        <input type="text" class="form-control" id="editCategoria" readonly>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="editMarca">Marca</label>
                        <input type="text" class="form-control" id="editMarca" name="marca" maxlength="50" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="editModelo">Modelo</label>
                        <input type="text" class="form-control" id="editModelo" name="modelo" maxlength="80" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label" for="editAccesorios">Kit / Accesorios</label>
                        <input type="text" class="form-control" id="editAccesorios" name="accesorios" maxlength="200">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="editEstado">Estado</label>
                        <select class="form-select" id="editEstado" name="estado" required>
                            <c:forEach var="e" items="${listaEstados}">
                                <option value="${e}">${e}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="editIe">Institución Educativa</label>
                        <select class="form-select" id="editIe" name="idIeAsignada">
                            <option value="">[Almacén Central UGEL 04]</option>
                            <c:forEach var="ie" items="${instituciones}">
                                <option value="${ie.idIe}">${ie.nombreIe} (${ie.distrito})</option>
                            </c:forEach>
                        </select>
                        <div class="form-text" id="editIeAyuda"></div>
                    </div>
                    <div class="col-12">
                        <label class="form-label" for="editObs">Observaciones</label>
                        <textarea class="form-control" id="editObs" name="observaciones" rows="2" maxlength="255"></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-danger">Guardar cambios</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal: dar de baja -->
<div class="modal fade" id="modalBaja" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <form class="modal-content" method="post" action="${ctx}/activos" id="formBaja">
            <input type="hidden" name="accion" value="darBaja">
            <input type="hidden" name="idActivo" id="bajaId">
            <div class="modal-header cabecera-baja">
                <h5 class="modal-title"><i class="bi bi-exclamation-octagon me-2"></i>Dar de Baja un Activo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p class="mb-3">
                    La baja es lógica: el equipo no se elimina, queda con estado <strong>De Baja</strong>
                    y sin colegio asignado.
                </p>
                <p class="mb-3">
                    Código SBN: <strong class="mono" id="bajaCodigo"></strong><br>
                    N° de serie: <strong class="mono" id="bajaSerie"></strong>
                </p>
                <label class="form-label" for="bajaMotivo">Motivo o N.° de Resolución Directoral</label>
                <textarea class="form-control" id="bajaMotivo" name="motivoBaja" rows="3" maxlength="230"
                          placeholder="Ej.: Obsolescencia - R.D. N.° 0150-2026-UGEL04" required></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-danger">Confirmar baja</button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp"/>
