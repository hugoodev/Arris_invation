package com.Arris.models;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "tipo_de_pago")
@ToString
public class TipoDePago implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Setter @Getter @Column(name = "id_tipo_de_pago")
    private long idTipoDePago;
    @Setter @Getter @Column(name = "nombre")
    private String nombre;

    public TipoDePago(String nombre) {
        this.nombre = nombre;
    }
    public TipoDePago() {

    }
}
