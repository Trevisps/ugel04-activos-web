package ugel04.modelo;

public class InstitucionDTO {

    private int idIe;
    private String codigoModular;
    private String nombreIe;
    private String distrito;
    private String directorResponsable;
    private String telefonoContacto;

    public InstitucionDTO() {
    }

    public int getIdIe() {
        return idIe;
    }

    public void setIdIe(int idIe) {
        this.idIe = idIe;
    }

    public String getCodigoModular() {
        return codigoModular;
    }

    public void setCodigoModular(String codigoModular) {
        this.codigoModular = codigoModular;
    }

    public String getNombreIe() {
        return nombreIe;
    }

    public void setNombreIe(String nombreIe) {
        this.nombreIe = nombreIe;
    }

    public String getDistrito() {
        return distrito;
    }

    public void setDistrito(String distrito) {
        this.distrito = distrito;
    }

    public String getDirectorResponsable() {
        return directorResponsable;
    }

    public void setDirectorResponsable(String directorResponsable) {
        this.directorResponsable = directorResponsable;
    }

    public String getTelefonoContacto() {
        return telefonoContacto;
    }

    public void setTelefonoContacto(String telefonoContacto) {
        this.telefonoContacto = telefonoContacto;
    }
}
