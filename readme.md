# Teste para o backend

## Introdução ao Teste

Este teste tem como objetivo avaliar suas habilidades em criar uma API para scraping de dados do SimilarWeb e armazená-los em um banco de dados MongoDB. Você pode optar por utilizar Python ou Ruby para desenvolver a solução.

O similarweb contém diversas informações sobre acessos de website, principais países, visitas por páginas e muito mais. Você terá que capturar todas essas informações 🙂.

## Objetivos Específicos:

1. **Desenvolvimento de API:**
 - [x] Implementar uma API que realize scraping de dados de websites listados e armazene as informações no MongoDB.

2. **Endpoints da API:**
 - [x] **POST /salve_info:** Este endpoint deve receber uma URL de um site, realizar o scraping dos dados no SimilarWeb e salvar as informações no MongoDB.
 - [x] **POST /get_info:** Este endpoint deve receber uma URL, buscar as informações do site no banco de dados e retorná-las. Se as informações ainda não estiverem disponíveis, deve retornar um código de erro.

3. **Requisitos Técnicos:**
 - [x] As informações a serem salvas incluem: Classificação, Site, Categoria, Mudança de Ranking, Duração Média da Visita, Páginas por Visita, Taxa de Rejeição, Principais Países, Distribuição por Gênero, Distribuição por Idade, entre outros dados disponíveis.
 - [Ponto Extra] A API deve ser assíncrona, retornando um código 201 com um ID para verificação posterior do status da operação.
 - [x] [Ponto Extra] Não utilizar Selenium, Playwright, Cypress ou qualquer outro automatizador de navegador para o scraping.

4. **Critérios de Avaliação:**
 - [x] **Funcionalidade (1.0 ponto):** Capacidade de salvar informações conforme especificado.
 - [x] **Eficiência (1.0 ponto):** Implementação de uma API assíncrona com retorno de status adequado.
 - [x] **Qualidade do Código (2.0 pontos):** O código deve ser escrito em Ruby, priorizando clareza e manutenibilidade.
 - [x] **Conformidade com Requisitos (2.0 pontos):** Adesão aos requisitos técnicos, incluindo a proibição do uso de automatizadores de navegador.