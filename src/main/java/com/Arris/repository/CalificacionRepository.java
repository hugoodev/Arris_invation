package com.Arris.repository;

import com.Arris.models.Calificacion;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CalificacionRepository extends CrudRepository<Calificacion, Long> {
}
