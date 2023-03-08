package com.Arris.repository;

import com.Arris.models.TipoDePago;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TipoDePagoRepository extends JpaRepository<TipoDePago, Long> {
    public TipoDePago findById(long id);
}
