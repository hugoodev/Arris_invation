package com.Arris.repository;

import com.Arris.models.Proveedor;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProveedorRepository extends CrudRepository<Proveedor, Long> {
}
