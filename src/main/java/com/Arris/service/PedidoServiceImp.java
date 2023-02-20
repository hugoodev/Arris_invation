package com.Arris.service;


import com.Arris.models.Pedido;
import com.Arris.repository.PedidoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class PedidoServiceImp implements PedidoService {

    @Autowired
    PedidoRepository pedidoRepository;

    @Override
    public ArrayList<Pedido> getAll() {
        return (ArrayList<Pedido>) pedidoRepository.findAll();
    }

    @Override
    public Optional<Pedido> getById(long idPedido) {
        return pedidoRepository.findById(idPedido);
    }

    @Override
    public Pedido save(Pedido p) {
        return pedidoRepository.save(p);
    }

    @Override
    public boolean deleteById(long idPedido) {
        try {
            Optional<Pedido> p = getById(idPedido);
            pedidoRepository.delete(p.get());
            return true;
        }catch (Exception e){
            return false;
        }
    }
}
