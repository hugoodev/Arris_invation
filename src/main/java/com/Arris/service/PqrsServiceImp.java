package com.Arris.service;

import com.Arris.models.Pqrs;
import com.Arris.repository.PqrsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class PqrsServiceImp implements PqrsService {

    @Autowired
    PqrsRepository pqrsRepository;

    @Override
    public ArrayList<Pqrs> getAll() {
        return (ArrayList<Pqrs>) pqrsRepository.findAll();
    }

    @Override
    public Optional<Pqrs> getById(long idPqrs) {
        return pqrsRepository.findById(idPqrs);
    }

    @Override
    public Pqrs save(Pqrs p) {
        return pqrsRepository.save(p);
    }

    @Override
    public boolean deleteById(long idPqrs) {
        try {
            Optional<Pqrs> p = getById(idPqrs);
            pqrsRepository.delete(p.get());
            return true;
        }catch (Exception e){
            return false;
        }

    }
}
