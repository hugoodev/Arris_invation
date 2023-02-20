package com.Arris.service;


import com.Arris.models.Inventario;

import java.util.ArrayList;
import java.util.Optional;

public interface InventarioService {

    ArrayList<Inventario> getAll();
    Optional<Inventario> getById(long idInventario);
    Inventario save(Inventario i);
    boolean deleteById(long idInventario);
}
