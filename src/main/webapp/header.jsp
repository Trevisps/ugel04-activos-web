<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Activos TI | UGEL 04</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="${ctx}/css/estilo.css" rel="stylesheet">
    </head>
    <body>

        <!-- Franja roja institucional -->
        <div class="barra-roja">
            <div class="contenedor barra-roja-interna">
                <div class="logo-minedu">
                    <img src="${ctx}/imagen/logo-minedu.png" alt="Logo MINEDU" height="50">
                </div>
                <div class="drelm">
                    <strong>DRELM | UGEL 04 - Comas</strong>
                    <small>Comas · Carabayllo · Puente Piedra · Ancón · Santa Rosa</small>
                </div>
            </div>
        </div>

        <!-- Sub-barra blanca -->
        <div class="subbarra">
            <div class="contenedor subbarra-interna">
                <h1>Gestión y Distribución de Activos TI</h1>
                <div class="usuario">
                    <i class="bi bi-person-circle"></i>
                    <span>J. Morales (Admin TI)</span>
                </div>
            </div>
        </div>
