package com.Arris.service;


import com.Arris.models.DetalleCompra;

import java.util.ArrayList;
import java.util.Optional;

public interface DetalleCompraService {

    ArrayList<DetalleCompra> getAll();
    Optional<DetalleCompra> getById(long idDetalleCompra);
    DetalleCompra saveDetalleCompra(DetalleCompra d);
    boolean deleteById(long idDetalleCompra);
}
