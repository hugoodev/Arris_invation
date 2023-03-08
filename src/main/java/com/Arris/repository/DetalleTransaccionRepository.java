package com.Arris.repository;

import com.Arris.models.DetalleTransaccion;
import com.Arris.models.TipoDePago;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DetalleTransaccionRepository extends CrudRepository<DetalleTransaccion, Long> {
}
