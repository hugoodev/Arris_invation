package com.Arris.service;


import com.Arris.models.RespuestaPqrs;
import com.Arris.repository.RespuestaPqrsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class RespuestaPqrsServiceImp implements RespuestaPqrsService {

    @Autowired
    RespuestaPqrsRepository pqrsRepository;

    @Override
    public ArrayList<RespuestaPqrs> getAll() {
        return (ArrayList<RespuestaPqrs>) pqrsRepository.findAll();
    }

    @Override
    public Optional<RespuestaPqrs> getById(long idRespuesta) {
        return pqrsRepository.findById(idRespuesta);
    }

    @Override
    public RespuestaPqrs save(RespuestaPqrs r) {
        return pqrsRepository.save(r);
    }

    @Override
    public boolean deleteById(long idRespuesta) {
        try {
            Optional<RespuestaPqrs> r = getById(idRespuesta);
            pqrsRepository.delete(r.get());
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
