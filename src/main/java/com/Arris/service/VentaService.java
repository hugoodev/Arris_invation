package com.Arris.service;


import com.Arris.models.Venta;

import java.util.ArrayList;
import java.util.Optional;

public interface VentaService {
    ArrayList<Venta> getAll();
    Optional<Venta> getById(long idVenta);
    Venta save(Venta v);
    boolean deleteById(long idVenta);
}
