package com.Arris.controllers;


import com.Arris.models.*;
import com.Arris.repository.PedidoRepository;
import com.Arris.repository.TipoDePagoRepository;
import com.Arris.repository.UsuarioRepository;
import com.Arris.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping
public class PasarelaPagoController {

    @Autowired
    DetallePedidoService detallePedidoService;
    @Autowired
    UsuarioService usuarioService;
    @Autowired
    UsuarioRepository usuarioRepository;
    @Autowired
    PedidoService pedidoService;
    @Autowired
    PedidoRepository pedidoRepository;
    @Autowired
    CarritoDeComprasService carritoDeComprasService;
    @Autowired
    TipoDePagoRepository tipoDePagoRepository;
    @Autowired
    DetalleTransaccionService detalleTransaccionService;
    @Autowired
    private MailServiceImp emailPort;
    @PostMapping("/transaccion/crear/pedido")
    public String crearPedidoCliente(DetalleTransaccion detalleTransaccion,Pedido pedido,Authentication auth, RedirectAttributes redirectAttrs,MailRequest emailBody) {

        String email = auth.getName();
        long id = 0;
        List<Usuario> usuarios = usuarioService.listarUsuarios();
        for (Usuario user : usuarios){
            if(user.getEmail().equals(email)){
                id = user.getIdUsuario();
                System.out.println("######" + user.getNombre() + user.getIdUsuario());
            }
        }
        Usuario usuario = usuarioRepository.findById(id);
        List<ItemsCarrito> itemsCarrito = carritoDeComprasService.listCartItems(usuario);
        int cantidad = itemsCarrito.size();
        pedido.setCliente(usuario);
        pedidoService.save(pedido);
        long idPedido = pedido.getIdPedido();

        detalleTransaccionService.save(detalleTransaccion);

        TipoDePago tipoDePago = tipoDePagoRepository.findById(2);

        for (ItemsCarrito it : itemsCarrito) {
            DetallePedido detallePedidos = new DetallePedido();
            detallePedidos.setTipoDePago(tipoDePago);
            detallePedidos.setDetalleTransaccion(detalleTransaccion);
            detallePedidos.setPedido(pedido);
            detallePedidos.setCantidad(it.getCantidad());
            detallePedidos.setEnvio("si");
            detallePedidos.setProducto(it.getProducto());
            detallePedidos.setEstado("Activo");
            detallePedidoService.save(detallePedidos);
            carritoDeComprasService.removeProducto(detallePedidos.getProducto().getIdProducto(),usuario);
            emailBody.setEmail("mrloquendojodido@gmail.com");
            emailBody.setSubject("se realizo un nuevo pedido!! #"+detallePedidos.getIdDetallePedido());
            emailBody.setContent(
                    "<h1>Hola Admin <strong>" + auth.getName() + "</strong>, esperamos que te encuentres bien </h1><br/>" +
                            "<h1>Cliente: <strong>" + detallePedidos.getPedido().getCliente().getNombre() + "</strong></h1><br/>" +
                            "<h1>El pedido que registraste tiene los siguientes productos: </h1><strong><h2>" + detallePedidos.getProducto().getNombre() + "</strong></h2><br/>"+
                            "<h1>Cantidad: </h1><strong><h2>" + detallePedidos.getCantidad() + "</strong></h2><br/>"+
                            "<h1>El total del pedido es: </h1><strong><h2>$" + (detallePedidos.getCantidad() * detallePedidos.getProducto().getPrecio() + (detallePedidos.getCantidad() * detallePedidos.getProducto().getPrecio() * 0.19)) +"</strong></h2>"+
                            "<h1> Envio:</h1> <strong><h2>" + detallePedidos.getEnvio() + "</h2></strong>" +
                            "<h1> Recuerda que esta compra se realizo a traves de la web</h1>"
            );
            emailPort.sendEmail(emailBody);

            emailBody.setEmail("hugo.garcia29@misena.edu.co");
            emailBody.setSubject("Acabas de realizar una compra!! #"+detallePedidos.getIdDetallePedido());
            emailBody.setContent(
                    "<h1>Hola <strong>" + detallePedidos.getPedido().getCliente().getNombre() + "</strong>, esperamos que te encuentres bien </h1><br/>" +
                            "<h1>El pedido tiene los siguientes productos: </h1><strong><h2>" + detallePedidos.getProducto().getNombre() + "</strong></h2><br/>"+
                            "<h1>Cantidad: </h1><strong><h2>" + detallePedidos.getCantidad() + "</strong></h2><br/>"+
                            "<h1>El total del pedido es: </h1><strong><h2>$" + (detallePedidos.getCantidad() * detallePedidos.getProducto().getPrecio() + (detallePedidos.getCantidad() * detallePedidos.getProducto().getPrecio() * 0.19)) +"</strong></h2>"+
                            "<h1> Envio:</h1> <strong><h2>" + detallePedidos.getEnvio() + "</h2></strong>"+
                            "<h1> Recuerda que esta compra se realizo a traves de la web, todos tus datos estan protegidos e cifrados</h1>"
            );

            emailPort.sendEmail(emailBody);
        }
        redirectAttrs
                .addFlashAttribute("mensaje", "Hiciste '" + cantidad + "' compras a traves de la web. ¡Gracias! Cuando recibas el producto no olvides calificar, esto nos ayuda a mejorar.")
                .addFlashAttribute("clase", "success");
        if (auth.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))){
            return "redirect:/gestion_ventas_admin";
        }
        if (auth.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_EMPLEADO"))){
            return "redirect:/gestion_ventas_empleado";
        }
        if (auth.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_CLIENTE"))){
            return "redirect:/compras_cliente";
        }
        return "redirect:/compras_cliente";
    }


}
