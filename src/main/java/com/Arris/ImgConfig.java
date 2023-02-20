package com.Arris;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class ImgConfig implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        WebMvcConfigurer.super.addResourceHandlers(registry);

        //registry.addResourceHandler("/recursos/**").addResourceLocations("file:/home/devh/Documentos/recursos/");
        registry.addResourceHandler("/recursos/**").addResourceLocations("file:/C:/Producto/recursos/");
    }
}
