package com.Arris.repository;

import com.Arris.models.Pqrs;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PqrsRepository extends CrudRepository<Pqrs, Long> {
}
