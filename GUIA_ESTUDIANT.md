# 📚 Guia de l'Estudiant: Aplicacions Web Dinàmiques amb AJAX i jQuery

Aquest projecte evoluciona el model MVC tradicional cap a una arquitectura més moderna i fluida, eliminant les recàrregues completes de pàgina mitjançant crides asíncrones al servidor (AJAX).

## 🚀 1. De MVC Tradicional a Aplicació d'una Sola Pàgina (SPA)

En el laboratori anterior, cada interacció de l'usuari (clicar un enllaç, enviar un formulari) provocava que el navegador demanés una pàgina HTML completa al servidor. Això interromp l'experiència de l'usuari i és poc eficient.

En aquest Lab 3, utilitzem un enfocament tipus **SPA (Single Page Application)**:
*   **`index.html`**: És l'única pàgina que el navegador carrega realment. Actua com a esquelet o "frame" principal.
*   **Contenidors Dinàmics**: Dins d'aquest esquelet tenim divisions (`<div id="navigation">`, `<div id="content">`) que s'omplen i es buiden dinàmicament.
*   **MVC Inalterat**: És molt important entendre que, encara que la interfície sigui dinàmica, **el servidor segueix el patró MVC al 100%**. Cada crida AJAX és una petició que gestiona un Controlador, que parla amb un Model a través de la seva classe de Servei i retorna una Vista.

> **Important**: Les vistes que retorna el servidor ja no són pàgines completes (amb `<html>`, `<head>`, etc.), sinó **fragments d'HTML** dissenyats per ser inserits dins d'un `<div>`.

## ⚡ 2. El Cor de l'Aplicació: AJAX amb jQuery

Per gestionar les crides asíncrones, fem servir la llibreria **jQuery**, que simplifica enormement la sintaxi de Javascript per interactuar amb el servidor.

### 📥 L'avantatge del mètode `.load()`
Al carregar la pàgina (`App.init`), inicialitzem l'esquelet:
```javascript
$('#navigation').load("Menu"); // Carrega el fragment del menú
$('#content').load("Content");   // Carrega el fragment del contingut inicial
```
El mètode `.load()` de jQuery és especialment potent per dues raons:
1.  **Inserció Automàtica**: Fa la petició GET i injecta el resultat directament al DOM.
2.  **Execució de Scripts**: A diferència de mètodes natius com `innerHTML`, **`.load()` detecta i executa automàticament qualsevol etiqueta `<script>`** que vingui dins del fragment HTML. Això permet que cada fragment carregat pugui tenir la seva pròpia lògica Javascript sense haver de carregar-la tota l'inici.

### 🔗 Captura d'Events de Navegació
Per evitar que els enllaços recarreguin la pàgina sencera, "segrestem" el clic i el convertim en una crida AJAX:
```javascript
$(document).on("click", ".menu", function (event) {
    event.preventDefault(); // Atura la navegació real
    $('#content').load($(this).attr('href'), function () {
        $('#navigation').load("Menu"); // Recarrega el menú per actualitzar l'estat (ex: Login/Logout)
    });
});
```

## 🧩 3. Arquitectura del Servidor: MVC + Repository/Service

L'estructura interna del Java es manté robusta i organitzada:

*   **Controladors (Servlets)**: Reben la petició AJAX, gestionen els paràmetres i decideixen quin fragment HTML (la vista) retornar.
*   **Model (Repository/Service)**: 
    *   **Servei (`UserService`)**: Conté la lògica de negoci i les **validacions manuals**. Aquí és on comprovem si els camps són buits, si les contrasenyes segueixen el patró correcte o si l'usuari ja existeix.
    *   **Repositori (`UserRepository`)**: S'encarrega exclusivament de la persistència en la base de dades SQL.
*   **Vistes (JSP/HTML)**: En lloc de generar documents complets, generen només el codi HTML necessari per al fragment (ex: el formulari, el missatge de benvinguda).

## 🔐 4. Validació en Dos Passos

Mantenim la seguretat de l'aplicació validant en ambdós costats:

1.  **Al Client (JS)**: `LoginValidation.js` i `RegisterValidation.js` utilitzen la **Constraint Validation API** per donar feedback instantani a l'usuari (marges vermells/verds) abans d'enviar les dades.
2.  **Al Servidor (Java)**: Dins de la capa de **Servei**, realitzem una validació manual camp per camp. Si trobem errors, retornem el fragment del formulari amb la llista d'errors perquè l'usuari els pugui corregir.

---

## 🎯 Objectiu del Lab 3: Implementació de Casos d'Ús

L'objectiu final d'aquest laboratori és traslladar el disseny realitzat al **Seminari 2** (Diagrama de Casos d'Ús) a una aplicació web dinàmica funcional.

Heu de modificar la plantilla per reflectir tots els casos d'ús identificats per als diferents rols:
*   **Usuari Anònim**: (ex: Login, Registre).
*   **Usuari Registrat**: (ex: Perfil personal, Timeline, Seguir/Deixar de seguir usuaris, Publicar missatges).
*   **Administrador**: (ex: Gestió d'usuaris).

### 📝 Tasques a realitzar:
1.  **Adaptació de Menús**: El menú dinàmic ha de mostrar opcions diferents segons el rol de l'usuari que hagi iniciat sessió.
2.  **Vistes "Fantasma" (Mockups)**: No cal implementar tota la lògica interna de cada cas d'ús encara. L'objectiu és que, en clicar una opció del menú, es carregui un fragment HTML que serveixi de **placeholder** (ex: un títol i una descripció de què es podrà fer en aquella secció).
3.  **Navegació AJAX**: Tota la interacció entre aquestes seccions s'ha de fer sense recarregar la pàgina sencera, mantenint l'experiència d'aplicació fluid.

> [!IMPORTANT]
> Si voleu provar una alternativa moderna al mètode `$.ajax` de jQuery, reviseu el fitxer `index_fetch.html` on s'utilitza la API nativa de Javascript **Fetch**. Veureu que, a diferència de `.load()`, amb Fetch cal programar manualment l'execució dels scripts injectats (funció `App.executeScripts`).
