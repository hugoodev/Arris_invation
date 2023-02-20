package com.Arris.service;

import com.Arris.models.DetallePedido;
import com.Arris.repository.DetallePedidoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class DetallePedidoServiceImp implements DetallePedidoService {

    @Autowired
    DetallePedidoRepository detallePedidoRepository;


    @Override
    public ArrayList<DetallePedido> getAll() {
        return (ArrayList<DetallePedido>) detallePedidoRepository.findAll();
    }

    @Override
    public Optional<DetallePedido> getById(long idDetallePedido) {
        return detallePedidoRepository.findById(idDetallePedido);
    }

    @Override
    public DetallePedido save(DetallePedido detallePedido) {
        return detallePedidoRepository.save(detallePedido);
    }

    @Override
    public boolean deleteById(long idDetallePedido) {
        try {
            Optional<DetallePedido> detallePedido = getById(idDetallePedido);
            detallePedidoRepository.delete(detallePedido.get());
            return true;
        }catch (Exception e){
            return false;
        }
    }
}
