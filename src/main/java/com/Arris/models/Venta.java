package com.Arris.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "venta")
public class Venta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Setter @Getter @Column(name = "id_venta")
    private long idVenta;
    @Setter @Getter @Column(name = "producto")
    private String producto;
    @Setter @Getter @Column(name = "fecha")
    private Date fecha;
    @Setter @Getter @Column(name = "impuesto")
    private long impuesto;
    @JsonIgnore @Setter @Getter @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "id_pedido")
    private Pedido pedido;
    @Getter @Setter @Column(name = "envio")
    private String envio;

    public Venta() {
    }

    public Venta(String producto, Date fecha, long impuesto, Pedido pedido,String envio) {
        this.producto = producto;
        this.fecha = fecha;
        this.impuesto = impuesto;
        this.pedido = pedido;
        this.envio = envio;
    }
}
