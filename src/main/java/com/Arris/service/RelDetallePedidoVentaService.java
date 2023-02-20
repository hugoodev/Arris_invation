package com.Arris.service;

import com.Arris.models.DetallePedido;
import com.Arris.models.Pqrs;
import com.Arris.models.RelDetallePedidoVenta;

import java.util.ArrayList;
import java.util.Optional;

public interface RelDetallePedidoVentaService {
    ArrayList<RelDetallePedidoVenta> getAll();
    Optional<RelDetallePedidoVenta> getById(long id);
    RelDetallePedidoVenta save(RelDetallePedidoVenta relDetallePedidoVenta);
    boolean deleteById(long id);
}
