package com.Arris.service;

import com.Arris.models.Proveedor;
import com.Arris.repository.ProveedorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class ProveedorServiceImp implements ProveedorService {

    @Autowired
    ProveedorRepository proveedorRepository;

    @Override
    public ArrayList<Proveedor> getAll() {
        return (ArrayList<Proveedor>) proveedorRepository.findAll();
    }

    @Override
    public Optional<Proveedor> getById(long idProveedor) {
        return proveedorRepository.findById(idProveedor);
    }

    @Override
    public Proveedor save(Proveedor p) {
        return proveedorRepository.save(p);
    }

    @Override
    public boolean deleteById(long idProveedor) {
        try {
            Optional<Proveedor> p = getById(idProveedor);
            proveedorRepository.delete(p.get());
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
