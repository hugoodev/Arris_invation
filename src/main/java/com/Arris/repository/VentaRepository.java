package com.Arris.repository;

import com.Arris.models.Venta;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VentaRepository extends CrudRepository<Venta, Long> {
}
