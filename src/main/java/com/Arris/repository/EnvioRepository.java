package com.Arris.repository;

import com.Arris.models.Envio;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EnvioRepository extends CrudRepository<Envio, Long> {
}
