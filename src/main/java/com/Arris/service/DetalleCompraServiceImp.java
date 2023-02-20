package com.Arris.service;


import com.Arris.models.DetalleCompra;
import com.Arris.repository.DetalleCompraRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class DetalleCompraServiceImp implements DetalleCompraService {

    @Autowired
    DetalleCompraRepository compraRepository;



    @Override
    public ArrayList<DetalleCompra> getAll() {
        return (ArrayList<DetalleCompra>) compraRepository.findAll();
    }

    @Override
    public Optional<DetalleCompra> getById(long idDetalleCompra) {
        return compraRepository.findById(idDetalleCompra);
    }

    @Override
    public DetalleCompra saveDetalleCompra(DetalleCompra d) {
        return compraRepository.save(d);
    }

    @Override
    public boolean deleteById(long idDetalleCompra) {
        try {
            Optional<DetalleCompra> d = getById(idDetalleCompra);
            compraRepository.delete(d.get());
            return true;
        }catch (Exception e){
            return false;
        }
    }
}
