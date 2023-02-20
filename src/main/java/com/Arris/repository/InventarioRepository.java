package com.Arris.repository;

import com.Arris.models.Inventario;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InventarioRepository extends CrudRepository<Inventario, Long> {
}
