package com.example;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.hamcrest.Matchers.hasItems;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Checks the behaviour of the generated stub as described in the README.
 */
@SpringBootTest
@AutoConfigureMockMvc
class ApiStubTests {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void rootRedirectsToSwaggerUi() throws Exception {
        mockMvc.perform(get("/"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("swagger-ui.html"));
    }

    @Test
    void swaggerUiIsAvailable() throws Exception {
        mockMvc.perform(get("/swagger-ui.html"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/swagger-ui/index.html"));
        mockMvc.perform(get("/swagger-ui/index.html"))
                .andExpect(status().isOk());
    }

    @Test
    void openApiDocumentContainsAllPaths() throws Exception {
        mockMvc.perform(get("/v3/api-docs"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.paths.length()").value(13))
                .andExpect(jsonPath("$.paths.keys()", hasItems("/api/v3/pet", "/api/v3/store/order", "/api/v3/user")));
    }

    @Test
    void stubReturnsExampleWithStatusNotImplemented() throws Exception {
        mockMvc.perform(get("/api/v3/pet/1").accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isNotImplemented())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.name").value("doggie"))
                .andExpect(jsonPath("$.photoUrls[1]").value("http://example.com/photo2.png"));
    }

    @Test
    void invalidPetIsRejected() throws Exception {
        // name and photoUrls are required in the OAS3 document.
        mockMvc.perform(post("/api/v3/pet")
                        .contentType(MediaType.APPLICATION_JSON)
                        .accept(MediaType.APPLICATION_JSON)
                        .content("{\"id\": 1}"))
                .andExpect(status().isBadRequest());
    }

    @Test
    void endpointsAreServedUnderBasePath() throws Exception {
        mockMvc.perform(get("/api/v3/store/inventory").accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isNotImplemented());
        mockMvc.perform(get("/store/inventory").accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isNotFound());
    }
}
