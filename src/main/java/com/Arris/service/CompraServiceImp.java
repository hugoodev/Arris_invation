package com.Arris.service;


import com.Arris.models.Compra;
import com.Arris.repository.CompraRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class CompraServiceImp implements CompraService {


    @Autowired
    CompraRepository compraRepository;


    @Override
    public ArrayList<Compra> getAll() {
        return (ArrayList<Compra>) compraRepository.findAll();
    }

    @Override
    public Optional<Compra> getById(long idCompra) {
        return compraRepository.findById(idCompra);
    }

    @Override
    public Compra save(Compra c) {
        return compraRepository.save(c);
    }

    @Override
    public boolean deleteById(long idCompra) {
        try {
            Optional<Compra> c = getById(idCompra);
            compraRepository.delete(c.get());
            return true;
        }catch (Exception e){
            return false;
        }
    }
}
