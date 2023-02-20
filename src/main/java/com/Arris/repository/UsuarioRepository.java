package com.Arris.repository;

import com.Arris.models.Rol;
import com.Arris.models.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import javax.persistence.SqlResultSetMapping;
import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.util.List;


@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    public Usuario findByEmail(String email);
    @Transactional
    @Modifying
    @Query("UPDATE Usuario SET id_usuario = :idUsuario, nombre = :nombre, telefono = :telefono, email = :email, direccion = :direccion, password = :password WHERE id_usuario = :idUsuario")
    Long actualizarDatos(long idUsuario, String nombre, Integer telefono, String email, String direccion, PasswordEncoder password);

    @Transactional
    @Modifying
    @Query(value = "SELECT * FROM usuarios inner join roles_usuarios on usuarios.id_usuario=roles_usuarios.id_usuario where id_rol = 1010;",nativeQuery = true)
    List<Usuario> listarClientes();

    @Transactional
    @Modifying
    @Query(value = "SELECT * FROM usuarios inner join roles_usuarios on usuarios.id_usuario=roles_usuarios.id_usuario where id_rol = 1012;",nativeQuery = true)
    List<Usuario> listarEmpleados();

    @Transactional
    @Modifying
    @Query(value = "SELECT * FROM usuarios inner join roles_usuarios on usuarios.id_usuario=roles_usuarios.id_usuario", nativeQuery = true)
    List<Usuario> listarWithrol();




}
