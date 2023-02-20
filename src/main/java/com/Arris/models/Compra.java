package com.Arris.models;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "compras")
public class Compra {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Getter @Setter @Column(name = "id_compras")
    private long idCompra;
    @Getter @Setter @Column(name = "fecha")
    private java.sql.Date fecha;
    @Getter @Setter @Column(name = "descripcion")
    private String descripcion;
    @Getter @Setter
    @ManyToOne @JoinColumn(name = "id_proveedor")
    private Proveedor proveedor;

    public Compra() {
    }

    public Compra(java.sql.Date fecha, String descripcion, Proveedor proveedor) {
        this.fecha = fecha;
        this.descripcion = descripcion;
        this.proveedor = proveedor;
    }
}
