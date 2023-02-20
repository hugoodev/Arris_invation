package com.Arris.models;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "inventario")
@ToString
public class Inventario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Getter @Setter @Column(name = "id_inventario")
    private long idInventario;
    @Getter @Setter @Column(name = "fecha")
    private Date fecha;
    @Getter @Setter @Column(name = "cantidad")
    private int cantidad;
    @Getter @Setter @Column(name = "descripcion")
    private String descripcion;
    @Getter @Setter
    @ManyToOne
    @JoinColumn (name = "id_movimiento")
    private Movimiento movimiento;
    @Getter @Setter
    @ManyToOne
    @JoinColumn(name = "id_producto")
    private Producto producto;

    public Inventario() {
    }

    public Inventario(Date fecha, int cantidad, String descripcion, Movimiento movimiento, Producto producto) {
        this.fecha = fecha;
        this.cantidad = cantidad;
        this.descripcion = descripcion;
        this.movimiento = movimiento;
        this.producto = producto;
    }
}
