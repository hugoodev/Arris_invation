package com.Arris.service;


import com.Arris.models.Producto;

import java.util.ArrayList;
import java.util.Optional;

public interface ProductoService {

    ArrayList<Producto> getAll();
    Optional<Producto> getById(long idProducto);
    Producto save(Producto p);
    boolean deleteById(long idProducto);
}
