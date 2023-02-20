package com.Arris.service;


import com.Arris.models.Pedido;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.ArrayList;
import java.util.Optional;

public interface PedidoService {
    ArrayList<Pedido> getAll();
    Optional<Pedido> getById(long idPedido);
    Pedido save(Pedido p);
    boolean deleteById(long idPedido);
}
