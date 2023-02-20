package com.Arris.models;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "producto")
public class Producto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Getter @Setter @Column(name = "id_producto")
    private long idProducto;
    @Getter @Setter @Column(name = "nombre")
    private String nombre;
    @Getter @Setter @Column(name = "categoria")
    private String categoria;
    @Getter @Setter @Column(name = "precio")
    private double precio;
    @Getter @Setter @Column(name = "estado")
    private String estado;
    @Getter @Setter @Column(name = "disponibles")
    private Integer disponibles;
    @Getter @Setter @Column(name = "imagen")
    private String imagen;

    public Producto() {
    }

    public Producto(String nombre, String categoria, double precio, String estado, Integer disponibles, String imagen) {
        this.estado = estado;
        this.nombre = nombre;
        this.categoria = categoria;
        this.precio = precio;
        this.disponibles = disponibles;
        this.imagen = imagen;
    }
}
