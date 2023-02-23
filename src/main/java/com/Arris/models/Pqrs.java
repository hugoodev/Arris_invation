package com.Arris.models;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "pqrs",  schema = "lipems")
@ToString
public class Pqrs {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Getter @Setter @Column(name = "id_pqrs")
    private long idPqrs;
    @Getter @Setter @Column(name = "tipo_pqrs")
    private String tipoPqrs;
    @Getter @Setter @Column(name = "descripcion_pqrs")
    private String descripcionPqrs;
    @Getter @Setter @Column(name = "estado_pqrs")
    private String estadoPqrs;
    @Getter @Setter @Column(name = "fecha_ingresada")
    private String fechaIngresada;
    @Getter @Setter @Column(name = "fecha_respuesta")
    private String fechaRespuesta;
    @Getter @Setter @ManyToOne @JoinColumn(name = "id_venta")
    private Venta venta;
    @Getter @Setter @Column(name = "respuesta")
    private String respuesta;
    @Getter @Setter @Column(name = "encargado_res")
    private String encargadoRes;

    public Pqrs() {
    }

    public Pqrs(String tipoPqrs, String descripcionPqrs, String estadoPqrs, String fechaIngresada, String fechaRespuesta, Venta venta, String respuesta, String encargadoRes) {
        this.tipoPqrs = tipoPqrs;
        this.descripcionPqrs = descripcionPqrs;
        this.estadoPqrs = estadoPqrs;
        this.fechaIngresada = fechaIngresada;
        this.fechaRespuesta = fechaRespuesta;
        this.venta = venta;
        this.respuesta = respuesta;
        this.encargadoRes = encargadoRes;
    }
}
