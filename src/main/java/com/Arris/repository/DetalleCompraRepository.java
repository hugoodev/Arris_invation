package com.Arris.repository;

import com.Arris.models.DetalleCompra;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DetalleCompraRepository extends CrudRepository<DetalleCompra, Long> {
}
