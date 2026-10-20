document.addEventListener('DOMContentLoaded', function () {

    // ---------- Formulario de registrar ----------
    var formRegistrar = document.getElementById('formRegistrar');
    var regTipo = document.getElementById('regTipo');
    var regCategoria = document.getElementById('regCategoria');
    var regEstado = document.getElementById('regEstado');
    var regIe = document.getElementById('regIe');
    var regIeAyuda = document.getElementById('regIeAyuda');

    // ---------- Formulario de editar ----------
    var editTipo = document.getElementById('editTipo');
    var editCategoria = document.getElementById('editCategoria');
    var editEstado = document.getElementById('editEstado');
    var editIe = document.getElementById('editIe');
    var editIeAyuda = document.getElementById('editIeAyuda');

    // ---------- Formulario de baja ----------
    var formBaja = document.getElementById('formBaja');
    var bajaMotivo = document.getElementById('bajaMotivo');


    // La categoría depende del tipo de equipo
    function obtenerCategoria(tipo) {
        if (tipo == 'Laptop' || tipo == 'Tablet' || tipo == 'PC Escritorio') {
            return 'Cómputo';
        } else if (tipo == 'Proyector') {
            return 'Proyección';
        } else if (tipo == 'Parlante') {
            return 'Multimedia y Audio';
        } else if (tipo == 'Access Point') {
            return 'Redes';
        }
        return '';
    }

    // RN-04: solo estos estados llevan colegio
    function requiereColegio(estado) {
        return estado == 'En Tránsito' || estado == 'Asignado' || estado == 'En Retorno';
    }

    // Habilita o bloquea el select de colegio según el estado elegido
    function revisarColegio(selectEstado, selectIe, textoAyuda) {
        var estado = selectEstado.value;

        if (requiereColegio(estado)) {
            selectIe.disabled = false;
            selectIe.required = true;
            textoAyuda.textContent = 'Obligatorio: el estado "' + estado + '" necesita una I.E.';
        } else {
            selectIe.value = '';
            selectIe.disabled = true;
            selectIe.required = false;
            textoAyuda.textContent = 'Con el estado "' + estado + '" el equipo queda en el Almacén Central.';
        }
    }


    // ---------- Eventos del registro ----------
    regTipo.addEventListener('change', function () {
        regCategoria.value = obtenerCategoria(regTipo.value);
    });

    regEstado.addEventListener('change', function () {
        revisarColegio(regEstado, regIe, regIeAyuda);
    });

    document.getElementById('modalRegistrar').addEventListener('show.bs.modal', function () {
        formRegistrar.reset();
        regCategoria.value = '';
        revisarColegio(regEstado, regIe, regIeAyuda);
    });

    // ---------- Eventos de la edición ----------
    editTipo.addEventListener('change', function () {
        editCategoria.value = obtenerCategoria(editTipo.value);
    });

    editEstado.addEventListener('change', function () {
        revisarColegio(editEstado, editIe, editIeAyuda);
    });

    // Al abrir el modal se cargan los datos del botón que se presionó
    document.getElementById('modalEditar').addEventListener('show.bs.modal', function (evento) {
        var boton = evento.relatedTarget;
        if (boton == null) {
            return;
        }

        document.getElementById('editId').value = boton.dataset.id;
        document.getElementById('editCodigo').value = boton.dataset.codigo;
        document.getElementById('editSerie').value = boton.dataset.serie;
        editTipo.value = boton.dataset.tipo;
        editCategoria.value = obtenerCategoria(boton.dataset.tipo);
        document.getElementById('editMarca').value = boton.dataset.marca;
        document.getElementById('editModelo').value = boton.dataset.modelo;
        document.getElementById('editAccesorios').value = boton.dataset.accesorios;
        editEstado.value = boton.dataset.estado;
        editIe.value = boton.dataset.ie;
        document.getElementById('editObs').value = boton.dataset.obs;

        revisarColegio(editEstado, editIe, editIeAyuda);

        // revisarColegio limpia el colegio cuando no hace falta, si sí hace falta lo volvemos a poner
        if (requiereColegio(editEstado.value)) {
            editIe.value = boton.dataset.ie;
        }
    });

    // ---------- Baja lógica ----------
    document.getElementById('modalBaja').addEventListener('show.bs.modal', function (evento) {
        var boton = evento.relatedTarget;
        if (boton == null) {
            return;
        }

        document.getElementById('bajaId').value = boton.dataset.id;
        document.getElementById('bajaCodigo').textContent = boton.dataset.codigo;
        document.getElementById('bajaSerie').textContent = boton.dataset.serie;
        bajaMotivo.value = '';
    });

    formBaja.addEventListener('submit', function (evento) {
        if (bajaMotivo.value.trim() == '') {
            evento.preventDefault();
            alert('Debe escribir el motivo o el N.° de Resolución Directoral.');
            bajaMotivo.focus();
        }
    });

    // ---------- Filtros: se aplican apenas se cambia el select ----------
    var filtroEstado = document.getElementById('filtroEstado');
    var filtroDistrito = document.getElementById('filtroDistrito');

    filtroEstado.addEventListener('change', function () {
        filtroEstado.form.submit();
    });

    filtroDistrito.addEventListener('change', function () {
        filtroDistrito.form.submit();
    });

    // Estado inicial de los selects de colegio
    revisarColegio(regEstado, regIe, regIeAyuda);
    revisarColegio(editEstado, editIe, editIeAyuda);
});
