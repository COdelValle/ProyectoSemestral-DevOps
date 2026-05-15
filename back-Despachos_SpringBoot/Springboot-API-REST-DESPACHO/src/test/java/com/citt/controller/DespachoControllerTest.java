package com.citt.controller;

import com.citt.persistence.entity.Despacho;
import com.citt.persistence.services.DespachoService;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Collections;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

@WebMvcTest(DespachoController.class)
public class DespachoControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private DespachoService despachoService;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    public void testGetAllDespachos() throws Exception {
        // Configuración del escenario (Given)
        Despacho despacho = new Despacho();
        despacho.setIdDespacho(1L);
        
        when(despachoService.findAllDespachos()).thenReturn(Collections.singletonList(despacho));

        // Ejecución y Verificación (When & Then)
        mockMvc.perform(get("/api/v1/despachos")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].idDespacho").value(1L));
    }
}