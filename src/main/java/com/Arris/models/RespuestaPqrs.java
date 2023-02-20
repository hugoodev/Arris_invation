package com.Arris.models;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "respuesta_pqrs")
public class RespuestaPqrs {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Setter @Getter @Column(name = "id_respuesta")
    private long idRespuesta;
    @Setter @Getter @ManyToOne @JoinColumn(name = "id_pqrs")
    private Pqrs pqrs;
    @Setter @Getter @Column(name = "respuesta")
    private String respuesta;

    public RespuestaPqrs() {
    }

    public RespuestaPqrs(Pqrs pqrs, String respuesta) {
        this.pqrs = pqrs;
        this.respuesta = respuesta;
    }
}
