package com.Arris.controllers;


import com.Arris.models.Producto;
import com.Arris.service.ProductoService;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Optional;

@Controller
public class ProductoController {

    @Autowired
    ProductoService productoService;

    @GetMapping("/allq")
    public ArrayList<Producto> getAllProductos(){
        return productoService.getAll();
    }

    @GetMapping("/findq/{id}")
    public Optional<Producto> getProductoById(@PathVariable("id") long idProducto){
        return productoService.getById(idProducto);
    }

    @PostMapping("/saveq")
    public Producto saveProducto(@RequestBody Producto p){
        return productoService.save(p);
    }

    @PostMapping("/insertar_nuevo_producto_admin")
    public String insertarProducto(Producto producto, RedirectAttributes redirectAttrs, @RequestParam("file") MultipartFile imagen) {

        if (!imagen.isEmpty()) {

            String bucketName = "arrisinvation"; // Reemplaza esto con el nombre de tu bucket
            String objectName = "img/recursos/" + imagen.getOriginalFilename(); // Ruta dentro del bucket donde se guardará la imagen

            try {
                System.out.println("entra al try");
                byte[] bytesImg = imagen.getBytes();

                // Configuración del cliente de S3
                BasicAWSCredentials awsCreds = new BasicAWSCredentials("AKIA32F6UYABIAAPQ4OV", "d1EGobNyD8KmVwSbo+tk5JT2pbrSupkkQ+NXKyEW"); // Reemplaza esto con tus credenciales de AWS
                AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
                        .withRegion("us-east-2") // Reemplaza esto con la región de tu bucket
                        .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
                        .build();
                System.out.println("pasa las credenciales");

                // Carga de la imagen en el bucket de S3
                ByteArrayInputStream inputStream = new ByteArrayInputStream(bytesImg);
                ObjectMetadata metadata = new ObjectMetadata();
                metadata.setContentLength(bytesImg.length);
                s3Client.putObject(bucketName, objectName, inputStream, metadata);
                System.out.println("Cargasads la imagen en el bucket de S3");

                producto.setImagen(imagen.getOriginalFilename()); // Guarda la ruta de la imagen en el objeto producto

            } catch (IOException e) {
                e.printStackTrace();
            }

        }

        productoService.save(producto);
        redirectAttrs
                .addFlashAttribute("mensaje", "Se A Guardado Satisfactioriamente El Nuevo Producto, Numero De Producto#: " + producto.getIdProducto() + ", Categoria: " + producto.getCategoria() + ", Precio: $" + producto.getPrecio()  +  " ✔")
                .addFlashAttribute("clase", "success");
        return "redirect:/administrador_compras_admin";
    }
    @PostMapping("/cambiar_estado_producto")
    public String cambiarEstadoProducto(Producto producto, RedirectAttributes redirectAttrs){
        productoService.save(producto);
        redirectAttrs
                .addFlashAttribute("mensaje", "Se A Guardado Satisfactioriamente El Nuevo Estado Del Producto, Numero De Producto#: " + producto.getIdProducto() + ", Estado Nuevo: " + producto.getEstado() +  " ✔")
                .addFlashAttribute("clase", "success");
        return "redirect:/administrador_compras_admin";
    }

    @DeleteMapping("/deleteq/{id}")
    public String deleteProductoById(@PathVariable("id") long idProducto){
        if (productoService.deleteById(idProducto))
            return "se ha eliminado";
        else
            return "no se elimino";
    }

}
