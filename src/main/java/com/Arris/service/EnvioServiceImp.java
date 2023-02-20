package com.Arris.service;


import com.Arris.models.Envio;
import com.Arris.repository.EnvioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class EnvioServiceImp implements EnvioService {

    @Autowired
    EnvioRepository envioRepository;



    @Override
    public ArrayList<Envio> getAll() {
        return (ArrayList<Envio>) envioRepository.findAll();
    }

    @Override
    public Optional<Envio> getById(long idEnvio) {
        return envioRepository.findById(idEnvio);
    }

    @Override
    public Envio save(Envio e) {
        return envioRepository.save(e);
    }


    @Override
    public boolean deleteById(long idEnvio) {
        try {
            Optional<Envio> e = getById(idEnvio);
            envioRepository.delete(e.get());
            return true;
        }catch (Exception e){
            return false;
        }
    }
}
