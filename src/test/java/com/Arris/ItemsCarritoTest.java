package com.Arris;

import com.Arris.models.ItemsCarrito;
import com.Arris.models.Producto;
import com.Arris.models.Usuario;
import com.Arris.repository.ItemsCarritoRepository;
import org.apache.commons.math3.stat.descriptive.summary.Product;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

@RunWith(SpringRunner.class)
@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@Rollback(false)
public class ItemsCarritoTest {
    @Autowired
    private ItemsCarritoRepository itemsCarritoRepository;
    @Autowired
    private TestEntityManager entityManager;
    @Test
    public void TestAddOneCartItem() {
        Producto producto = entityManager.find(Producto.class,9014);
        Usuario usuario = entityManager.find(Usuario.class, 777);

        ItemsCarrito nuevoItem = new ItemsCarrito();
        nuevoItem.setProducto(producto);
        nuevoItem.setUsuario(usuario);
        nuevoItem.setCantidad(2);

        ItemsCarrito saveItemsCarrito = itemsCarritoRepository.save(nuevoItem);

        assertTrue(saveItemsCarrito.getId() > 0);
    }
    @Test
    public void testGetCartItemsByUsuario() {
        Usuario usuario = new Usuario();
        usuario.setIdUsuario(777);

        List<ItemsCarrito> itemsCarrito =itemsCarritoRepository.findByUsuario(usuario);

        assertEquals(2,itemsCarrito.size());
    }
}
