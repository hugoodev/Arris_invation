package com.Arris.models;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "rel_detalle_pedido_venta")
@ToString

public class RelDetallePedidoVenta {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Setter @Getter @Column(name = "id")
    private long id;
    @Getter @Setter @ManyToOne @JoinColumn(name = "venta")
    private Venta venta;
    @Getter @Setter @ManyToOne @JoinColumn(name = "detalle_pedido")
    private DetallePedido detalle_pedido;

    public RelDetallePedidoVenta(){
    }

    public RelDetallePedidoVenta(Venta venta, DetallePedido detalle_pedido) {
        this.venta = venta;
        this.detalle_pedido = detalle_pedido;
    }
}
