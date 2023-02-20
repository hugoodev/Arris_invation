package com.Arris.models;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "calificacion")
@ToString
public class Calificacion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Getter @Setter @Column(name = "id_calificacion")
    private long idCalificacion;
    @Getter @Setter @Column(name = "fecha")
    private Date fecha;
    @Getter @Setter @Column(name = "descripcion")
    private String descripcion;
    @Getter @Setter @Column(name = "valoracion", length = 100)
    private int valoracion;
    @Getter @Setter
    @ManyToOne @JoinColumn(name = "id_pedido")
    private Pedido pedido;

    public Calificacion() {
    }

    public Calificacion(Date fecha, String descripcion, int valoracion, Pedido pedido) {
        this.fecha = fecha;
        this.descripcion = descripcion;
        this.valoracion = valoracion;
        this.pedido = pedido;
    }
}
