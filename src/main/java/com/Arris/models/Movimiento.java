package com.Arris.models;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;

@Entity
@Table(name = "movimientos")
@ToString
public class Movimiento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Getter @Setter @Column(name = "id_movimiento")
    private long idMovimiento;

    @Getter @Setter @Column(name = "tipo_de_movimiento")
    private String tipoMovimiento;

}
