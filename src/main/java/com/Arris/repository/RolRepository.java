package com.Arris.repository;

import com.Arris.models.Rol;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

@Repository
public interface RolRepository extends JpaRepository<Rol,Long> {

    @Query(value = "SELECT r FROM Rol r WHERE r.nombreRol = ?1")
    public Rol findByName(String nombreRol);


    @Query(value = "SELECT r FROM Rol r WHERE r.idRol = ?1")
    public Rol findByIdRol(Long idRol);
}
