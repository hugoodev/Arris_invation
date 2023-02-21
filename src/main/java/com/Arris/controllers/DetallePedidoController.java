package com.Arris.controllers;

import com.Arris.models.*;
import com.Arris.repository.UsuarioRepository;
import com.Arris.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.data.jpa.repository.Query;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.GrantedAuthoritiesContainer;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.lang.model.element.Element;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.security.Principal;
import java.sql.SQLException;
import java.util.*;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.stream.Collectors;

import org.apache.commons.lang3.ArrayUtils;

@Controller
@RequestMapping
public class DetallePedidoController {

    @Autowired
    DetallePedidoService detallePedidoService;


    @Autowired
    UsuarioService usuarioService;


    @Autowired
    PedidoService pedidoService;

    @Autowired
    ProductoService productoService;

    @Autowired
    EnvioService envioService;

    @Autowired
    VentaService ventaService;

    @Autowired
    private MailServiceImp emailPort;

    @GetMapping("/alla")
    public ArrayList<DetallePedido> getAllDetallePedidos(){
        return detallePedidoService.getAll();
    }

    @GetMapping("/inicio")
    public String inicioPagina(){
        return "/web/index";
    }

    String usuario = "";
    @GetMapping("/gestion_ventas_admin")
    public String listarAdmin(Model model, Principal principal, Authentication auth){
        List<DetallePedido> detallePedido = detallePedidoService.getAll();
        List<Usuario> cliente = usuarioService.listarC();
        List<Usuario> empleado = usuarioService.listarE();
        List<Pedido> pedido = pedidoService.getAll();
        List<Producto> producto = productoService.getAll();
        List<Venta> venta = ventaService.getAll();
        if (usuario.isEmpty()) {
            usuario = auth.getName();
        } else {
            if (usuario.equals(auth.getName())) {
                System.out.println("esta bien");
            } else {
                detallePedidos.removeAll(detallePedidos);
            }
        }
        System.out.println("%%%%%%%%%"+usuario);
        model.addAttribute("pedido", detallePedido);
        model.addAttribute("cliente", cliente);
        model.addAttribute("empleado", empleado);
        model.addAttribute("mostrarPedidos", pedido);
        model.addAttribute("producto", producto);
        model.addAttribute("venta", venta);
        model.addAttribute("totalsum", totalsum);
        model.addAttribute("arrays", detallePedidos);
        return "interfaz_administrador/templates/gestion_ventas";
    }

    @GetMapping("/gestion_ventas_empleado")
    public String listarEmpleado(Model model, Authentication auth){
        List<DetallePedido> detallePedido = detallePedidoService.getAll();
        List<Usuario> cliente = usuarioService.listarC();
        List<Usuario> empleado = usuarioService.listarE();
        List<Pedido> pedido = pedidoService.getAll();
        List<Producto> producto = productoService.getAll();
        if (usuario.isEmpty()) {
            usuario = auth.getName();
        } else {
            if (!usuario.equals(auth.getName())) {
                usuario = auth.getName();
                detallePedidos.removeAll(detallePedidos);
            }
        }
        model.addAttribute("pedido", detallePedido);
        model.addAttribute("cliente", cliente);
        model.addAttribute("empleado", empleado);
        model.addAttribute("mostrarPedidos", pedido);
        model.addAttribute("producto", producto);
        model.addAttribute("totalsum", totalsum);
        model.addAttribute("arrays", detallePedidos);
        return "interfaz_empleado/templates/ventas";
    }

    @GetMapping("/compras_cliente")
    public String listarComprasCliente(Model model, Usuario usuario){
        List<DetallePedido> detallePedido = detallePedidoService.getAll();
        List<Usuario> rolUsuario = usuarioService.listarUsuarios();
        List<Pedido> pedido = pedidoService.getAll();
        List<Producto> producto = productoService.getAll();
        List<Envio> envio = envioService.getAll();
        List<Venta> venta = ventaService.getAll();
        model.addAttribute("pedido", detallePedido);
        model.addAttribute("rolUsuario", rolUsuario);
        model.addAttribute("mostrarPedidos", pedido);
        model.addAttribute("producto", producto);
        model.addAttribute("envio", envio);
        model.addAttribute("venta", venta);
        return "interfaz_cliente/templates/compras";
    }

    @GetMapping("/finda/{id}")
    public Optional<DetallePedido> getDetallePedido(@PathVariable("id") long idDetallePedido){
        return detallePedidoService.getById(idDetallePedido);
    }

    @PostMapping("/guardar_nueva_venta_admin")
    public String GuardarVenta(DetallePedido detallePedido, RedirectAttributes redirectAttrs, MailRequest emailBody, Authentication auth, Model model) {
        for (int i = 0;i < detallePedidos.size();i++){
            detallePedidoService.save(detallePedidos.get(i));
            redirectAttrs
                    .addFlashAttribute("mensaje", "Se A Guardado Satisfactioriamente La Nueva Venta"  + ", Nombre Del Cliente: " + detallePedidos.get(i).getPedido().getCliente().getNombre() + ", Nombre Del Producto: " + detallePedidos.get(i).getProducto().getNombre() + ", Cantidad: " + detallePedidos.get(i).getCantidad() +  ", Estado: " + detallePedidos.get(i).getEstado() +  " ✔")
                    .addFlashAttribute("clase", "success");
            emailBody.setEmail("mrloquendojodido@gmail.com");
            emailBody.setSubject("has registrado un nuevo pedido!! #"+detallePedidos.get(i).getPedido().getIdPedido());
            emailBody.setContent(
                    "<h1>Hola Admin <strong>" + auth.getName() + "</strong>, esperamos que te encuentres bien </h1><br/>" +
                            "<h1>Cliente: <strong>" + detallePedidos.get(i).getPedido().getCliente().getNombre() + "</strong></h1><br/>" +
                            "<h1>El pedido que registraste tiene los siguientes productos: </h1><strong><h2>" + detallePedidos.get(i).getProducto().getNombre() + "</strong></h2><br/>"+
                            "<h1>El total del pedido es: </h1><strong><h2>$" + detallePedidos.get(i).getCantidad() * detallePedidos.get(i).getProducto().getPrecio() +"</strong></h2>"+
                            "<h1> Envio:</h1> <strong><h2>" + detallePedidos.get(i).getEnvio() + "</h2></strong>"
            );
            emailPort.sendEmail(emailBody);

            emailBody.setEmail("hugo.garcia29@misena.edu.co");
            emailBody.setSubject("Se a registrado un nuevo pedido!! #"+detallePedidos.get(i).getPedido().getIdPedido());
            emailBody.setContent(
                    "<h1>Hola <strong>" + detallePedidos.get(i).getPedido().getCliente().getNombre() + "</strong>, esperamos que te encuentres bien </h1><br/>" +
                            "<h1>El pedido tiene los siguientes productos: </h1><strong><h2>" + detallePedidos.get(i).getProducto().getNombre() + "</strong></h2><br/>"+
                            "<h1>El total del pedido es: </h1><strong><h2>$" + detallePedidos.get(i).getCantidad() * detallePedidos.get(i).getProducto().getPrecio() +"</strong></h2>"+
                            "<h1> Envio:</h1> <strong><h2>" + detallePedidos.get(i).getEnvio() + "</h2></strong>"
            );

            emailPort.sendEmail(emailBody);
        }
        for (int i = 0;i < detallePedidos.size();i++){
            item = 0;
            detallePedidos.removeAll(detallePedidos);
        }

        model.addAttribute("arrays", detallePedidos);

        System.out.println("pedido guardado con exito");
        return "redirect:/gestion_ventas_admin";
    }
    List <DetallePedido> detallePedidos = new ArrayList<DetallePedido>();
    int item = 0;
    int disponibilidades = 0;
    @GetMapping("/eliminar_venta_lista_admin")
    public ModelAndView getRequestAdmin(@RequestParam(name="action") String action, @RequestParam(name="id") int id, RedirectAttributes redirectAttrs, Model model){
        ModelAndView mav = new ModelAndView("redirect:/gestion_ventas_admin");
        if (action.equals("delete")) {
            detallePedidos.remove(id);
            item--;
            for ( int i = 0; i < detallePedidos.size(); i++) {
                if (detallePedidos.get(i).getIdDetallePedido() != 0) {
                    var idpe = detallePedidos.get(i).getIdDetallePedido() - 1;
                    detallePedidos.get(i).setIdDetallePedido(idpe);
                }
            }
            int sum = 0;
            for (DetallePedido dp: detallePedidos) {
                int iva = (int) (dp.getCantidad()*dp.getProducto().getPrecio() * 0.19);
                sum = (int) (sum + (dp.getCantidad()*dp.getProducto().getPrecio()) + iva);
            }
            totalsum = sum;
            model.addAttribute("totalsum", totalsum);
            estado = false;
            redirectAttrs
                    .addFlashAttribute("mensaje", "El producto se elimino de la canasta con exito")
                    .addFlashAttribute("clase", "danger")
                    .addFlashAttribute("class", "show");
        }
        return mav;
    }
    @GetMapping("/eliminar_venta_lista_empleado")
    public ModelAndView getRequestEmpleado(@RequestParam(name="action") String action, @RequestParam(name="id") int id, RedirectAttributes redirectAttrs, Model model){
        ModelAndView mav = new ModelAndView("redirect:/gestion_ventas_empleado");
        if (action.equals("delete")) {
            detallePedidos.remove(id);
            item--;
            for ( int i = 0; i < detallePedidos.size(); i++) {
                if (detallePedidos.get(i).getIdDetallePedido() != 0) {
                    var idpe = detallePedidos.get(i).getIdDetallePedido() - 1;
                    detallePedidos.get(i).setIdDetallePedido(idpe);
                }
            }
            int sum = 0;
            for (DetallePedido dp: detallePedidos) {
                int iva = (int) (dp.getCantidad()*dp.getProducto().getPrecio() * 0.19);
                sum = (int) (sum + (dp.getCantidad()*dp.getProducto().getPrecio()) + iva);
            }
            totalsum = sum;
            model.addAttribute("totalsum", totalsum);
            estado = false;
            redirectAttrs
                    .addFlashAttribute("mensaje", "El producto se elimino de la canasta con exito")
                    .addFlashAttribute("clase", "danger")
                    .addFlashAttribute("class", "show");
        }
        return mav;
    }
    @PostMapping("/guardar_nueva_venta_empleado")
    public String GuardarVentaEmpleado(Model model, DetallePedido detallePedido, RedirectAttributes redirectAttrs, MailRequest emailBody, Authentication auth) {
            for (int i = 0;i < detallePedidos.size();i++){
                detallePedidoService.save(detallePedidos.get(i));
                redirectAttrs
                        .addFlashAttribute("mensaje", "Se A Guardado Satisfactioriamente La Nueva Venta"  + ", Nombre Del Cliente: " + detallePedidos.get(i).getPedido().getCliente().getNombre() + ", Nombre Del Producto: " + detallePedidos.get(i).getProducto().getNombre() + ", Cantidad: " + detallePedidos.get(i).getCantidad() +  ", Estado: " + detallePedidos.get(i).getEstado() +  " ✔")
                        .addFlashAttribute("clase", "success");
                emailBody.setEmail("mrloquendojodido@gmail.com");
                emailBody.setSubject("has registrado un nuevo pedido!! #"+detallePedidos.get(i).getPedido().getIdPedido());
                emailBody.setContent(
                        "<h1>Hola Admin <strong>" + auth.getName() + "</strong>, esperamos que te encuentres bien </h1><br/>" +
                                "<h1>Cliente: <strong>" + detallePedidos.get(i).getPedido().getCliente().getNombre() + "</strong></h1><br/>" +
                                "<h1>El pedido que registraste tiene los siguientes productos: </h1><strong><h2>" + detallePedidos.get(i).getProducto().getNombre() + "</strong></h2><br/>"+
                                "<h1>El total del pedido es: </h1><strong><h2>$" + detallePedidos.get(i).getCantidad() * detallePedidos.get(i).getProducto().getPrecio() +"</strong></h2>"+
                                "<h1> Envio:</h1> <strong><h2>" + detallePedidos.get(i).getEnvio() + "</h2></strong>"
                );
                emailPort.sendEmail(emailBody);

                emailBody.setEmail("hugo.garcia29@misena.edu.co");
                emailBody.setSubject("Se a registrado un nuevo pedido!! #"+detallePedidos.get(i).getPedido().getIdPedido());
                emailBody.setContent(
                        "<h1>Hola <strong>" + detallePedidos.get(i).getPedido().getCliente().getNombre() + "</strong>, esperamos que te encuentres bien </h1><br/>" +
                                "<h1>El pedido tiene los siguientes productos: </h1><strong><h2>" + detallePedidos.get(i).getProducto().getNombre() + "</strong></h2><br/>"+
                                "<h1>El total del pedido es: </h1><strong><h2>$" + detallePedidos.get(i).getCantidad() * detallePedidos.get(i).getProducto().getPrecio() +"</strong></h2>"+
                                "<h1> Envio:</h1> <strong><h2>" + detallePedidos.get(i).getEnvio() + "</h2></strong>"
                );

                emailPort.sendEmail(emailBody);
            }
            for (int i = 0;i < detallePedidos.size();i++){
                item = 0;
                detallePedidos.removeAll(detallePedidos);
            }

            model.addAttribute("arrays", detallePedidos);

            System.out.println("pedido guardado con exito");


        return "redirect:/gestion_ventas_empleado";
    }
    List <Producto> prod = new ArrayList<>();
    int productoDispo1 = 0;
    boolean estado = false;
    int n = 0;
    int u = 0;
    int i = 0;
    int totalsum = 0;
    @PostMapping("/agregar_productos_empleado")
    public String agregarProductosEmpleado(DetallePedido detallePedido,Model model, RedirectAttributes redirectAttrs) {
        if (prod.isEmpty()) {
            List<Producto> pra = productoService.getAll();
            for (int i = 0; i < pra.size(); i++) {
                prod.add(pra.get(i));
            }
        }
        if (detallePedido.getProducto().getDisponibles() < detallePedido.getCantidad()) {
            redirectAttrs
                    .addFlashAttribute("mensaje", "El producto '" + detallePedido.getProducto().getNombre() + "' no esta disponible en stock, comuniquese con su administrador.")
                    .addFlashAttribute("clase", "danger");
        } else if (detallePedido.getProducto().getDisponibles() != 0){
            if (detallePedido.getProducto().getDisponibles() >= detallePedido.getCantidad()) {
                int productoDispo = productoDispo1;
                boolean total = false;
                int g = 0;
                for (DetallePedido z : detallePedidos) {
                    if (z.getProducto().getNombre().equals(detallePedido.getProducto().getNombre())) {
                        g = g + z.getCantidad();
                    }
                }
                u = g;
                for (DetallePedido pr : detallePedidos) {
                    if (!pr.getProducto().getNombre().equals(detallePedido.getProducto().getNombre())){
                        total = false;
                        estado = total;
                    } else {
                        if (detallePedido.getProducto().getDisponibles() <= u) {
                            total = true;
                            estado = total;
                        } else {
                            total = false;
                            estado = total;
                        }
                    }
                    if (detallePedido.getProducto().getDisponibles() <= u) {
                        total = true;
                        estado = total;
                    } else {
                        total = false;
                        estado = total;
                    }
                    i = u + detallePedido.getCantidad();
                }
                if (i > detallePedido.getProducto().getDisponibles()) {
                    total = true;
                    estado = total;
                } else {
                    total = false;
                    estado = total;
                }
                if (estado == false) {
                    detallePedidos.add(detallePedido);
                    detallePedido.setIdDetallePedido(item);
                    item++;
                    redirectAttrs
                            .addFlashAttribute("mensaje", "Se A Agregado Satisfactioriamente La Nueva Venta" + ", Nombre Del Cliente: " + detallePedido.getPedido().getCliente().getNombre() + ", Nombre Del Producto: " + detallePedido.getProducto().getNombre() + ", Cantidad: " + detallePedido.getCantidad() +  ", Estado: " + detallePedido.getEstado() +  " ✔")
                            .addFlashAttribute("clase", "success");
                    int a = 0;
                    for (DetallePedido z : detallePedidos) {
                        if (z.getProducto().getNombre().equals(detallePedido.getProducto().getNombre())) {
                            a = a + z.getCantidad();
                        }
                    }
                    n = a;
                    for (DetallePedido pr : detallePedidos) {
                        if (pr.getProducto().getNombre().equals(detallePedido.getProducto().getNombre())) {
                            if (productoDispo <= 0) {
                                productoDispo = detallePedido.getProducto().getDisponibles() - n;
                                total = false;
                                estado = total;
                            } else {
                                productoDispo = detallePedido.getProducto().getDisponibles() - n;
                                total = false;
                                estado = total;
                            }
                        }
                    }
                    productoDispo1 = productoDispo;
                    if (productoDispo <= 0) {
                        total = true;
                        estado = total;
                        redirectAttrs
                                .addFlashAttribute("mensaje", "**Se A Agregado Satisfactioriamente La Nueva Venta" + ", Nombre Del Cliente: " + detallePedido.getPedido().getCliente().getNombre() + ", Nombre Del Producto: " + detallePedido.getProducto().getNombre() + ", Cantidad: " + detallePedido.getCantidad() +  ", Estado: " + detallePedido.getEstado() +  " ✔")
                                .addFlashAttribute("clase", "success");
                    }
                } else{
                    redirectAttrs
                            .addFlashAttribute("mensaje", "****El producto '" + detallePedido.getProducto().getNombre() + "' no esta disponible en la cantidad exigida en stock, comuniquese con su administrador.")
                            .addFlashAttribute("clase", "danger");
                }
                int sum = 0;
                for (DetallePedido dp: detallePedidos) {
                    int iva = (int) (dp.getCantidad()*dp.getProducto().getPrecio() * 0.19);
                    sum = (int) (sum + (dp.getCantidad()*dp.getProducto().getPrecio()) + iva);
                }
                totalsum = sum;
                model.addAttribute("totalsum", totalsum);
            }
        }
        redirectAttrs
                .addFlashAttribute("class", "show");
        return "redirect:/gestion_ventas_empleado";
    }
    @PostMapping("/agregar_productos_admin")
    public String agregarProductosAdmin(DetallePedido detallePedido,Model model, RedirectAttributes redirectAttrs) {
        if (prod.isEmpty()) {
            List<Producto> pra = productoService.getAll();
            for (int i = 0; i < pra.size(); i++) {
                prod.add(pra.get(i));
            }
        }
        if (detallePedido.getProducto().getDisponibles() < detallePedido.getCantidad()) {
            redirectAttrs
                    .addFlashAttribute("mensaje", "El producto '" + detallePedido.getProducto().getNombre() + "' no esta disponible en stock, comuniquese con su administrador.")
                    .addFlashAttribute("clase", "danger");
        } else if (detallePedido.getProducto().getDisponibles() != 0){
            if (detallePedido.getProducto().getDisponibles() >= detallePedido.getCantidad()) {
                int productoDispo = productoDispo1;
                boolean total = false;
                int g = 0;
                for (DetallePedido z : detallePedidos) {
                    if (z.getProducto().getNombre().equals(detallePedido.getProducto().getNombre())) {
                        g = g + z.getCantidad();
                    }
                }
                u = g;
                for (DetallePedido pr : detallePedidos) {
                    if (!pr.getProducto().getNombre().equals(detallePedido.getProducto().getNombre())){
                        total = false;
                        estado = total;
                    } else {
                        if (detallePedido.getProducto().getDisponibles() <= u) {
                            total = true;
                            estado = total;
                        } else {
                            total = false;
                            estado = total;
                        }
                    }
                    if (detallePedido.getProducto().getDisponibles() <= u) {
                        total = true;
                        estado = total;
                    } else {
                        total = false;
                        estado = total;
                    }
                    i = u + detallePedido.getCantidad();
                }
                if (i > detallePedido.getProducto().getDisponibles()) {
                    total = true;
                    estado = total;
                } else {
                    total = false;
                    estado = total;
                }
                if (estado == false) {
                    detallePedidos.add(detallePedido);
                    detallePedido.setIdDetallePedido(item);
                    item++;
                    redirectAttrs
                            .addFlashAttribute("mensaje", "Se A Agregado Satisfactioriamente La Nueva Venta" + ", Nombre Del Cliente: " + detallePedido.getPedido().getCliente().getNombre() + ", Nombre Del Producto: " + detallePedido.getProducto().getNombre() + ", Cantidad: " + detallePedido.getCantidad() +  ", Estado: " + detallePedido.getEstado() +  " ✔")
                            .addFlashAttribute("clase", "success");
                    int a = 0;
                    for (DetallePedido z : detallePedidos) {
                        if (z.getProducto().getNombre().equals(detallePedido.getProducto().getNombre())) {
                            a = a + z.getCantidad();
                        }
                    }
                    n = a;
                    for (DetallePedido pr : detallePedidos) {
                        if (pr.getProducto().getNombre().equals(detallePedido.getProducto().getNombre())) {
                            if (productoDispo <= 0) {
                                productoDispo = detallePedido.getProducto().getDisponibles() - n;
                                total = false;
                                estado = total;
                            } else {
                                productoDispo = detallePedido.getProducto().getDisponibles() - n;
                                total = false;
                                estado = total;
                            }
                        }
                    }
                    productoDispo1 = productoDispo;
                    if (productoDispo <= 0) {
                        total = true;
                        estado = total;
                        redirectAttrs
                                .addFlashAttribute("mensaje", "**Se A Agregado Satisfactioriamente La Nueva Venta" + ", Nombre Del Cliente: " + detallePedido.getPedido().getCliente().getNombre() + ", Nombre Del Producto: " + detallePedido.getProducto().getNombre() + ", Cantidad: " + detallePedido.getCantidad() +  ", Estado: " + detallePedido.getEstado() +  " ✔")
                                .addFlashAttribute("clase", "success");
                    }
                } else{
                    redirectAttrs
                            .addFlashAttribute("mensaje", "****El producto '" + detallePedido.getProducto().getNombre() + "' no esta disponible en la cantidad exigida en stock, comuniquese con su administrador.")
                            .addFlashAttribute("clase", "danger");
                }
                int sum = 0;
                for (DetallePedido dp: detallePedidos) {
                    int iva = (int) (dp.getCantidad()*dp.getProducto().getPrecio() * 0.19);
                    sum = (int) (sum + (dp.getCantidad()*dp.getProducto().getPrecio()) + iva);
                }
                totalsum = sum;
                model.addAttribute("totalsum", totalsum);
            }
        }
        redirectAttrs
                .addFlashAttribute("class", "show");
        return "redirect:/gestion_ventas_admin";
    }
    // Espedifica el nombre de una vista específica que se usará para mostrar el error
    @ExceptionHandler({SQLException.class, DataAccessException.class})
    public String databaseError(Authentication auth,RedirectAttributes redirectAttrs, SQLException sqlException) {
        // Nada que hacer.
        // Devuelve el nombre lógico de la vista de la página de error,
        // el cual se pasa el view-resolver del modo habitual.
        // La excepción NO está disponible en esta vista
        // (no se añade al modelo) pero puedes revisar
        // "Extendiendo el ExceptionHandlerExceptionResolver"
        // más abajo.
        redirectAttrs
                .addFlashAttribute("mensaje", sqlException.getMessage())
                .addFlashAttribute("clase", "danger");

        if (auth.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))){
            return "redirect:/gestion_ventas_admin";
        }
        if (auth.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_EMPLEADO"))){
            return "redirect:/gestion_ventas_empleado";
        }
        if (auth.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_CLIENTE"))){
            return "redirect:/compras_cliente";
        }
        return "redirect:/gestion_ventas_empleado";
    }

    @PostMapping("/cambiar_estado_venta_admin")
    public String CambiarEstadoAdmin(DetallePedido detallePedido, RedirectAttributes redirectAttrs){
        detallePedidoService.save(detallePedido);
        redirectAttrs
                .addFlashAttribute("mensaje", "El Estado De La Venta #" + detallePedido.getIdDetallePedido() +" A Sido Editada Satisfactoriamente Por: " + detallePedido.getEstado() + " ✔")
                .addFlashAttribute("clase", "success");
        System.out.println("estado actualizado con exito");
        return "redirect:/gestion_ventas_admin";
    }
    @PostMapping("/cambiar_estado_venta_empleado")
    public String CambiarEstadoEmpleado(DetallePedido detallePedido, RedirectAttributes redirectAttrs){
        detallePedidoService.save(detallePedido);
        redirectAttrs
                .addFlashAttribute("mensaje", "El Estado De La Venta #" + detallePedido.getIdDetallePedido() +" A Sido Editada Satisfactoriamente Por: " + detallePedido.getEstado() + " ✔")
                .addFlashAttribute("clase", "success");
        System.out.println("estado actualizado con exito");
        return "redirect:/gestion_ventas_empleado";
    }

    @PostMapping("/savea")
    public DetallePedido saveDetallePedido(@RequestBody DetallePedido detallePedido){
        return detallePedidoService.save(detallePedido);
    }

    @DeleteMapping("/deletea/{id}")
    public String deleteDetallePedidoById(@PathVariable("id") long idDetallePedido){
        if (detallePedidoService.deleteById(idDetallePedido))
            return "se ha eliminado";
        else
            return "no se elimino";
    }


}
