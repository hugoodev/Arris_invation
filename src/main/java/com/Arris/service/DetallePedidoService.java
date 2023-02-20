package com.Arris.service;


import com.Arris.models.DetallePedido;
import com.Arris.repository.DetallePedidoRepository;

import java.util.ArrayList;
import java.util.Optional;

public interface DetallePedidoService {

    ArrayList<DetallePedido> getAll();
    Optional<DetallePedido> getById(long idDetallePedido);
    DetallePedido save(DetallePedido detallePedido);
    boolean deleteById(long idDetallePedido);
}
