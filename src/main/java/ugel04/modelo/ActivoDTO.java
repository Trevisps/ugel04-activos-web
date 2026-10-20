package ugel04.modelo;

import java.sql.Timestamp;

public class ActivoDTO {

    private int idActivo;
    private String codigoPatrimonial;
    private String categoria;
    private String tipoEquipo;
    private String marca;
    private String modelo;
    private String numeroSerie;
    private String accesorios;
    private Integer idIeAsignada;
    private String estado;
    private String observaciones;
    private Timestamp fechaRegistro;

    // datos del colegio del left join
    private String nombreIe;
    private String distritoIe;

    public ActivoDTO() {
    }

    public int getIdActivo() {
        return idActivo;
    }

    public void setIdActivo(int idActivo) {
        this.idActivo = idActivo;
    }

    public String getCodigoPatrimonial() {
        return codigoPatrimonial;
    }

    public void setCodigoPatrimonial(String codigoPatrimonial) {
        this.codigoPatrimonial = codigoPatrimonial;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getTipoEquipo() {
        return tipoEquipo;
    }

    public void setTipoEquipo(String tipoEquipo) {
        this.tipoEquipo = tipoEquipo;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getNumeroSerie() {
        return numeroSerie;
    }

    public void setNumeroSerie(String numeroSerie) {
        this.numeroSerie = numeroSerie;
    }

    public String getAccesorios() {
        return accesorios;
    }

    public void setAccesorios(String accesorios) {
        this.accesorios = accesorios;
    }

    public Integer getIdIeAsignada() {
        return idIeAsignada;
    }

    public void setIdIeAsignada(Integer idIeAsignada) {
        this.idIeAsignada = idIeAsignada;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public String getNombreIe() {
        return nombreIe;
    }

    public void setNombreIe(String nombreIe) {
        this.nombreIe = nombreIe;
    }

    public String getDistritoIe() {
        return distritoIe;
    }

    public void setDistritoIe(String distritoIe) {
        this.distritoIe = distritoIe;
    }
}
