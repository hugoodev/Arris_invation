package com.Arris.repository;

import com.Arris.models.DetallePedido;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DetallePedidoRepository extends CrudRepository<DetallePedido, Long> {
}
