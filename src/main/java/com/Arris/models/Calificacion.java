package com.Arris.models;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "calificacion")
@ToString
public class Calificacion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Getter @Setter @Column(name = "id_calificacion")
    private long idCalificacion;
    @Getter @Setter @Column(name = "descripcion")
    private String descripcion;

    public Calificacion() {
    }

    public Calificacion(String descripcion) {
        this.descripcion = descripcion;
    }
}
