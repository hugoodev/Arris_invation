package com.Arris.models;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;

@Entity
@Table(name = "detalle_de_pedido")
@ToString
public class DetallePedido {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Getter @Setter @Column(name = "id_detalle_pedido")
    private long idDetallePedido;
    @Getter @Setter @Column(name = "cantidad")
    private int cantidad;
    @Getter @Setter @Column(name = "precio")
    private double precio;
    @Getter @Setter @Column(name = "total")
    private double total;
    @Getter @Setter @ManyToOne @JoinColumn(name = "id_producto")
    private Producto producto;
    @Getter @Setter @ManyToOne @JoinColumn(name = "id_pedido")
    private Pedido pedido;
    @Getter @Setter @Column(name = "estado")
    private String estado;
    @Getter @Setter @Column(name = "envio")
    private String envio;
    @Getter @Setter @Column(name = "fecha")
    private String fecha;
    @Getter @Setter @ManyToOne@JoinColumn(name = "calificacion")
    private Calificacion calificacion;
    @Getter @Setter @Column(name = "encargado")
    private String encargado;

    public DetallePedido() {
    }

    public DetallePedido(long idDetallePedido, int cantidad, double precio, double total, Producto producto, Pedido pedido, String estado, String envio, String fecha, Calificacion calificacion, String encargado) {
        this.idDetallePedido = idDetallePedido;
        this.cantidad = cantidad;
        this.precio = precio;
        this.total = total;
        this.producto = producto;
        this.pedido = pedido;
        this.estado = estado;
        this.envio = envio;
        this.fecha = fecha;
        this.calificacion = calificacion;
        this.encargado = encargado;
    }
}
