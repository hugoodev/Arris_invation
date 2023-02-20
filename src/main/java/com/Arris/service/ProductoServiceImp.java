package com.Arris.service;

import com.Arris.models.Producto;
import com.Arris.repository.ProductoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class ProductoServiceImp implements ProductoService {


    @Autowired
    ProductoRepository productoRepository;

    @Override
    public ArrayList<Producto> getAll() {
        return (ArrayList<Producto>) productoRepository.findAll();
    }

    @Override
    public Optional<Producto> getById(long idProducto) {
        return productoRepository.findById(idProducto);
    }

    @Override
    public Producto save(Producto p) {
        return productoRepository.save(p);
    }

    @Override
    public boolean deleteById(long idProducto) {

        try {
            Optional<Producto> p = getById(idProducto);
            productoRepository.delete(p.get());
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
