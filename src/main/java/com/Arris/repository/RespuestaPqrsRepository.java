package com.Arris.repository;

import com.Arris.models.RespuestaPqrs;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RespuestaPqrsRepository extends CrudRepository<RespuestaPqrs, Long> {
}
