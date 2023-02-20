package com.Arris.service;


import com.Arris.models.Proveedor;

import java.util.ArrayList;
import java.util.Optional;

public interface ProveedorService {
    ArrayList<Proveedor> getAll();
    Optional<Proveedor> getById(long idProveedor);
    Proveedor save(Proveedor p);
    boolean deleteById(long idProveedor);
}
