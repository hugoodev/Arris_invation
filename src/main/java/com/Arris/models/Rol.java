package com.Arris.models;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Collection;

@Entity
@Table(name = "roles")
public class Rol implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Setter @Getter @Column(name = "id_rol")
    private long idRol;

    @Setter @Getter @Column(name = "nombre_de_rol")
    private String nombreRol;



    public Rol() {
    }

    public Rol(long idRol, String nombreRol) {
        this.idRol = idRol;
        this.nombreRol = nombreRol;
    }

    public Rol(String nombreRol) {
        this.nombreRol = nombreRol;
    }
}
