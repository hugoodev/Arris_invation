package com.Arris.models;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "estado_usuarios")
public class EstadoUsuarios {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Getter @Setter @Column(name = "id_estado")
    private long idEstado;
    @Getter @Setter @Column(name = "nombre")
    private String nombre;

    EstadoUsuarios(){}

    public EstadoUsuarios(long idEstado, String nombre) {
        this.idEstado = idEstado;
        this.nombre = nombre;
    }
}
