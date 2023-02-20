package com.Arris.service;

import com.Arris.models.Pedido;
import com.Arris.models.Proveedor;
import com.Arris.models.RelDetallePedidoVenta;
import com.Arris.repository.RelDetallePedidoVentaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;
@Service
public class RelDetallePedidoVentaImp implements RelDetallePedidoVentaService {
    @Autowired
    RelDetallePedidoVentaRepository relDetallePedidoVentaRepository;

    @Override
    public ArrayList<RelDetallePedidoVenta> getAll() {return (ArrayList<RelDetallePedidoVenta>) relDetallePedidoVentaRepository.findAll();}

    @Override
    public Optional<RelDetallePedidoVenta> getById(long id) {
        return relDetallePedidoVentaRepository.findById(id);
    }

    @Override
    public RelDetallePedidoVenta save(RelDetallePedidoVenta p) {
        return relDetallePedidoVentaRepository.save(p);
    }

    @Override
    public boolean deleteById(long id) {
        try {
            Optional<RelDetallePedidoVenta> p = getById(id);
            relDetallePedidoVentaRepository.delete(p.get());
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
