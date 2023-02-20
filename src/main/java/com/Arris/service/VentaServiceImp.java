package com.Arris.service;

import com.Arris.models.Venta;
import com.Arris.repository.VentaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class VentaServiceImp implements VentaService {


    @Autowired
    VentaRepository ventaRepository;

    @Override
    public ArrayList<Venta> getAll() {
        return (ArrayList<Venta>) ventaRepository.findAll();
    }

    @Override
    public Optional<Venta> getById(long idVenta) {
        return ventaRepository.findById(idVenta);
    }

    @Override
    public Venta save(Venta v) {
        return ventaRepository.save(v);
    }

    @Override
    public boolean deleteById(long idVenta) {
        try {
            Optional<Venta> v = getById(idVenta);
            ventaRepository.delete(v.get());
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
