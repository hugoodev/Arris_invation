package com.Arris.service;


import com.Arris.models.Calificacion;
import com.Arris.repository.CalificacionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class CalificacionServiceImp implements CalificacionService {


    @Autowired
    CalificacionRepository calificacionRepository;


    @Override
    public ArrayList<Calificacion> getAllCalificaciones() {
        return (ArrayList<Calificacion>) calificacionRepository.findAll();
    }

    @Override
    public Optional<Calificacion> getCalificacionById(long idCalificacion) {
        return calificacionRepository.findById(idCalificacion);
    }

    @Override
    public Calificacion saveCalificacion(Calificacion c) {
        return calificacionRepository.save(c);
    }

    @Override
    public boolean deleteCalificacionById(long idCalificacion) {
        try {
            Optional<Calificacion> c = getCalificacionById(idCalificacion);
            calificacionRepository.delete(c.get());
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
