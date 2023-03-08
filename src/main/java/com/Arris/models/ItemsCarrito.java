package com.Arris.models;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;

@Entity
@Table(name = "items_carrito")
@ToString
public class ItemsCarrito {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Getter @Setter @Column(name = "id_item")
    private long id;
    @Getter @Setter
    @ManyToOne
    @JoinColumn(name = "id_producto")
    private Producto producto;
    @Getter @Setter
    @ManyToOne
    @JoinColumn(name = "usuario")
    private Usuario usuario;
    @Getter @Setter @Column(name = "cantidad")
    private Integer cantidad;

    public ItemsCarrito() {
    }

    public ItemsCarrito(long id, Producto producto,Usuario usuario, Integer cantidad) {
        this.id = id;
        this.producto = producto;
        this.usuario = usuario;
        this.cantidad = cantidad;
    }
    @Transient
    public double getSubtotal() {
        double subtotal = this.producto.getPrecio() * cantidad;
        double iva = subtotal * 0.19;
        double total = subtotal + iva;

        return total;
    }
}
