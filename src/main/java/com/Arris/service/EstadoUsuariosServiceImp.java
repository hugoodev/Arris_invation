package com.Arris.service;

import com.Arris.models.EstadoUsuarios;
import com.Arris.repository.EstadoUsuariosRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class EstadoUsuariosServiceImp implements EstadoUsuariosService {
    @Autowired
    EstadoUsuariosRepository estadoUsuariosRepository;
    @Override
    public ArrayList<EstadoUsuarios> getAll() {
        return (ArrayList<EstadoUsuarios>) estadoUsuariosRepository.findAll();
    }
}
