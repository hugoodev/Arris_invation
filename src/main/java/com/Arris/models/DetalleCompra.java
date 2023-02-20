package com.Arris.models;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;

@Entity
@Table(name = "detalle_de_compras")
@ToString
public class DetalleCompra {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Getter @Setter @Column(name = "id_detalle_compras")
    private long idDetalleCompra;

    @Getter @Setter @Column(name = "cantidad")
    private int cantidad;

    @Getter @Setter @Column(name = "subtotal")
    private double subtotal;

    @Getter @Setter
    @ManyToOne @JoinColumn(name = "id_producto")
    private Producto producto;

    @Getter @Setter
    @ManyToOne @JoinColumn(name = "id_compras")
    private Compra compra;

    @Getter @Setter @JoinColumn(name = "fecha")
    private String fecha;

    public DetalleCompra() {
    }

    public DetalleCompra(int cantidad, double subtotal, Producto producto, Compra compra, String fecha) {
        this.cantidad = cantidad;
        this.subtotal = subtotal;
        this.producto = producto;
        this.compra = compra;
        this.fecha = fecha;
    }
}
