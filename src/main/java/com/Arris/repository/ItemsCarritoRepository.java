package com.Arris.repository;

import com.Arris.models.ItemsCarrito;
import com.Arris.models.Producto;
import com.Arris.models.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ItemsCarritoRepository extends JpaRepository<ItemsCarrito, Long> {
    public List<ItemsCarrito> findByUsuario (Usuario usuario);

    public ItemsCarrito findByUsuarioAndProducto(Usuario usuario, Producto producto);

    @Query("UPDATE ItemsCarrito i SET i.cantidad = ?1 WHERE i.producto.idProducto = ?2 "
            + "AND i.usuario.idUsuario = ?3")
    @Modifying
    public void updateCantidad (Integer cantidad, long productoId, long usuarioId);

    @Query("DELETE FROM ItemsCarrito i WHERE i.usuario.idUsuario = ?1 AND i.producto.idProducto = ?2")
    @Modifying
    public void deleteByUsuarioYProducto(long usuarioId, long productoId);
}
