package com.Arris.service;


import com.Arris.models.Inventario;
import com.Arris.repository.InventarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class InventarioServiceImp implements InventarioService {

    @Autowired
    InventarioRepository inventarioRepository;

    @Override
    public ArrayList<Inventario> getAll() {
        return (ArrayList<Inventario>) inventarioRepository.findAll();
    }

    @Override
    public Optional<Inventario> getById(long idInventario) {
        return inventarioRepository.findById(idInventario);
    }

    @Override
    public Inventario save(Inventario i) {
        return inventarioRepository.save(i);
    }

    @Override
    public boolean deleteById(long idInventario) {
        try {
            Optional<Inventario> i = getById(idInventario);
            inventarioRepository.delete(i.get());
            return true;
        }catch (Exception e){
            return false;
        }
    }
}
