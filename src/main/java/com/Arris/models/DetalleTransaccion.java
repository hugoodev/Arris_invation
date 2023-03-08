package com.Arris.models;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;

@Entity
@Table(name = "detalle_transaccion")
@ToString
public class DetalleTransaccion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Getter @Setter @Column(name = "id_detalle_transaccion")
    private long idDetalleTransaccion;
    @Setter @Getter @Column(name = "tipo_tarjeta")
    private String tipoTarjeta;
    @Setter @Getter @Column(name = "numero_tarjeta")
    private String numeroTarjeta;
    @Setter @Getter @Column(name = "fecha_caducidad")
    private String fechaCaducidad;
    @Setter @Getter @Column(name = "cod_seguridad")
    private Integer codSeguridad;

    public DetalleTransaccion() {

    }

    public DetalleTransaccion( String tipoTarjeta, String numeroTarjeta, String fechaCaducidad, Integer codSeguridad) {
        this.tipoTarjeta = tipoTarjeta;
        this.numeroTarjeta = numeroTarjeta;
        this.fechaCaducidad = fechaCaducidad;
        this.codSeguridad = codSeguridad;
    }
}
