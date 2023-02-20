package com.Arris.models;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "proveedores")
public class Proveedor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Getter @Setter @Column(name = "id_proveedor")
    private long idProveedor;
    @Getter @Setter @Column(name = "nombre_de_proveedor")
    private String nombreProveedor;
    @Getter @Setter @Column(name = "telefono")
    private long telefono;
    @Getter @Setter @Column(name = "direccion")
    private String direccion;

    public Proveedor() {
    }

    public Proveedor(String nombreProveedor, long telefono, String direccion) {
        this.nombreProveedor = nombreProveedor;
        this.telefono = telefono;
        this.direccion = direccion;
    }
}
