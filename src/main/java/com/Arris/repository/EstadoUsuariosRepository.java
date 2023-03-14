package com.Arris.repository;

import com.Arris.models.DetalleCompra;
import com.Arris.models.EstadoUsuarios;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public interface EstadoUsuariosRepository extends CrudRepository<EstadoUsuarios, Long> {
}
