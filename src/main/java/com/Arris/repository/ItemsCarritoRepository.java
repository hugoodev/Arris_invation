package com.Arris.repository;

import com.Arris.models.ItemsCarrito;
import com.Arris.models.Producto;
import com.Arris.models.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ItemsCarritoRepository extends JpaRepository<ItemsCarrito, Long> {
    public List<ItemsCarrito> findByUsuario (Usuario usuario);

    public ItemsCarrito findByUsuarioAndProducto(Usuario usuario, Producto producto);
}
