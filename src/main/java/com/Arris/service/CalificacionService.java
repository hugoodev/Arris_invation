package com.Arris.service;

import com.Arris.models.Calificacion;

import java.util.ArrayList;
import java.util.Optional;

public interface CalificacionService {

    ArrayList<Calificacion> getAllCalificaciones();
    Optional<Calificacion> getCalificacionById(long idCalificacion);
    Calificacion saveCalificacion(Calificacion c);
    boolean deleteCalificacionById(long idCalificacion);

}
