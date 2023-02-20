package com.Arris.models;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.sql.Date;
import java.time.LocalDateTime;

@Entity
@Table(name = "pedido")
@ToString
public class Pedido {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Getter @Setter @Column(name = "id_pedido")
    private long idPedido;
    @Getter @Setter @Column(name = "fecha")
    private Date fecha;
    @Getter @Setter @ManyToOne @JoinColumn(name = "cliente")
    private Usuario cliente;
    @Getter @Setter @ManyToOne @JoinColumn(name = "id_empleado")
    private Usuario empleado;


    public Pedido() {
    }

    public Pedido(Date fecha, Usuario cliente, Usuario empleado) {
        this.fecha = fecha;
        this.cliente = cliente;
        this.empleado = empleado;
    }
}
