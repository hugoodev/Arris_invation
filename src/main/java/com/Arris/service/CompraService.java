package com.Arris.service;


import com.Arris.models.Compra;

import java.util.ArrayList;
import java.util.Optional;

public interface CompraService {
    ArrayList<Compra> getAll();
    Optional<Compra> getById(long idCompra);
    Compra save(Compra c);
    boolean deleteById(long idCompra);
}
