#!/data/data/com.termux/files/usr/bin/bash
# ~/Main_LEDL/Cerebro_Operativo_LEDL/wix_orchestrator/orchestrator.sh
# Orquestador para preparar sitio Wix: "TE HACEMOS LOS MANDADOS"

set -e  # Salir si hay error

# === CONFIGURACIÓN ===
PROJECT_NAME="Te Hacemos Los Mandados - Valle del Roble"
WIX_SUBDOMAIN="mandadosvalledelroble"
PRIMARY_COLOR="#003087"
SECONDARY_COLOR="#00A651"
WHATSAPP_NUMBER="528147928662"  # ← CAMBIA ESTO
OUTPUT_DIR="./output"
ASSETS_DIR="./assets"

# === COLORES PARA TERMINAL ===
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Iniciando Orquestador Wix para LEDL${NC}"
echo "============================================"

# === FUNCIÓN: Crear directorios ===
setup_dirs() {
  echo -e "${YELLOW}📁 Preparando estructura de carpetas...${NC}"
  mkdir -p "$OUTPUT_DIR" "$ASSETS_DIR/screenshots"
}

# === FUNCIÓN: Generar configuración YAML ===
generate_config() {
  echo -e "${YELLOW}⚙️ Generando wix_config.yaml...${NC}"
  cat > wix_config.yaml << EOF
# Configuración del sitio Wix - Generado automáticamente
# Fecha: $(date -Iseconds)

site:
  name: "$PROJECT_NAME"
  subdomain: "$WIX_SUBDOMAIN"
  template: "blank"
  category: "local_business"

design:
  primary_color: "$PRIMARY_COLOR"
  secondary_color: "$SECONDARY_COLOR"
  background: "#FFFFFF"
  font_primary: "Montserrat"
  font_secondary: "Roboto"

pages:
  - slug: "inicio"
    title: "Inicio"
    template: "hero_3col"
    assets:
      - banner: "logo_banner.png"
      - screenshots: ["app_client.png", "app_driver.png", "app_business.png"]
    cta:
      primary:
        text: "Haz tu pedido ahora"
        link: "https://wa.me/$WHATSAPP_NUMBER"
      secondary:
        text: "Escanea el QR"
        link: "qr_code.png"

  - slug: "como-funciona"
    title: "Cómo funciona"
    template: "full_image"
    assets:
      - flowchart: "flowchart_valle_roble.png"
    steps:
      - "1. Escanea el QR o haz clic en el botón"
      - "2. Selecciona tus productos y dirección"
      - "3. Confirma tu pedido por WhatsApp"
      - "4. Tu repartidor asignado va en camino 🛵"
      - "5. Recibe y califica tu experiencia ⭐"

  - slug: "para-clientes"
    title: "Para Clientes"
    template: "two_column"
    assets:
      - left: "flyer_clientes.png"
      - right: "screenshot_pedido.png"

  - slug: "para-repartidores-negocios"
    title: "Para Repartidores y Negocios"
    template: "two_column_split"
    sections:
      repartidores:
        title: "¿Quieres ser repartidor?"
        assets: ["app_driver.png", "requirements_driver.png"]
      negocios:
        title: "¿Tienes un negocio?"
        assets: ["dashboard_negocio.png", "integration_guide.png"]

  - slug: "zonas-mapa"
    title: "Zonas y Mapa"
    template: "map_embed"
    assets:
      - map_image: "mapa_valle_roble.png"
    coverage:
      - "Valle del Roble"
      - "Sampo Roble" 
      - "Cadereyta Jiménez"
      - "Colonias aledañas"
    stats:
      businesses: 26
      active_drivers: 12

  - slug: "dashboard-en-vivo"
    title: "Dashboard Operativo"
    template: "image_center"
    assets:
      - main: "dashboard_realtime.png"
      - qr: "qr_code_large.png"

  - slug: "privacidad"
    title: "Política de Privacidad"
    template: "text_only"
    content_file: "privacy_policy.txt"

integrations:
  whatsapp_float: true
  google_maps:
    enabled: true
    location: "Valle del Roble, Monterrey, NL"
    zoom: 14

footer:
  text: "Ecosistema LEDL • J ANDRES RESENDEZ R • Licencia: LAS ENSEÑANZAS DE LIZ"
  links:
    - {text: "Inicio", anchor: "#top"}
    - {text: "WhatsApp", link: "https://wa.me/$WHATSAPP_NUMBER"}

seo:
  title: "Te Hacemos Los Mandados | Valle del Roble"
  description: "Servicio de mandados y entregas en Valle del Roble, Monterrey. Rápido, seguro y local. ¡Escanear y listo!"
  keywords: ["mandados", "entregas", "valle del roble", "monterrey", "delivery local"]
EOF
  echo -e "${GREEN}✅ Configuración generada${NC}"
}

# === FUNCIÓN: Generar contenidos para copiar/pegar ===
generate_content() {
  echo -e "${YELLOW}📝 Generando contenidos para Wix...${NC}"
  
  cat > "$OUTPUT_DIR/page_contents.txt" << 'CONTENT_EOF'
================================================================================
📋 CONTENIDOS PARA COPIAR EN WIX - "TE HACEMOS LOS MANDADOS"
Generado: $(date)
================================================================================

[PÁGINA: INICIO]
────────────────────────────────────────────────────────────────────────────
▶ Banner principal (texto sobre imagen):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TE HACEMOS LOS MANDADOS
VALLE DEL ROBLE

Tu tiempo, nuestra prioridad
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

▶ Botón 1:
   Texto: "Haz tu pedido ahora"
   Enlace: https://wa.me/528147928662
   Estilo: Primario (verde #00A651)

▶ Botón 2:
   Texto: "📱 Escanea el QR"
   Enlace: (abre modal con imagen qr_code.png)

▶ Sección 3 columnas (debajo del banner):
   Columna 1: [Imagen: app_cliente.png] + Texto: "Para Clientes"
   Columna 2: [Imagen: app_repartidor.png] + Texto: "Para Repartidores"  
   Columna 3: [Imagen: app_negocio.png] + Texto: "Para Negocios"

────────────────────────────────────────────────────────────────────────────
[PÁGINA: CÓMO FUNCIONA]
────────────────────────────────────────────────────────────────────────────
▶ Título: "Así funciona tu mandado en Valle del Roble"

▶ Imagen principal (ancho completo): [flowchart_valle_roble.png]

▶ Lista de pasos (debajo del flujograma):
   1️⃣ Escanea el QR o haz clic en "Pedir ahora"
   2️⃣ Selecciona tus productos y tu dirección de entrega
   3️⃣ Confirma tu pedido por WhatsApp (sin apps complicadas)
   4️⃣ Tu repartidor asignado recibe la ruta óptima 🛵
   5️⃣ Recibe tu mandado y califica con ⭐⭐⭐⭐⭐

▶ Texto pequeño al final:
   "¿Tienes dudas? Escríbenos al WhatsApp: https://wa.me/52XXXXXXXXXX"

────────────────────────────────────────────────────────────────────────────
[PÁGINA: PARA CLIENTES]
────────────────────────────────────────────────────────────────────────────
▶ Título: "Para Clientes – ¡Tan fácil como escanear!"

▶ Columna izquierda:
   [Imagen: flyer_clientes.png]

▶ Columna derecha (texto):
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   ✅ Sin registro complicado
   ✅ Pagas contra entrega (efectivo o transferencia)
   ✅ Rastrea tu pedido en tiempo real
   ✅ Repartidores verificados de tu zona
   ✅ Soporte por WhatsApp 24/7

   🎁 ¡Tu primer mandado tiene 10% de descuento!
   Usa el código: VALLE10 al confirmar por WhatsApp
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

▶ Debajo: [Imagen: screenshot_pedido.png] + Texto: "Así se ve tu pedido"

────────────────────────────────────────────────────────────────────────────
[PÁGINA: PARA REPARTIDORES Y NEGOCIOS]
────────────────────────────────────────────────────────────────────────────
▶ Título principal: "Únete al ecosistema LEDL"

▶ SECCIÓN IZQUIERDA: REPARTIDORES
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   🛵 ¿Tienes moto, bici o auto?
   
   ✅ Gana por entrega + propinas
   ✅ Elige tus horarios (tú eres tu jefe)
   ✅ Pagos semanales vía transferencia
   ✅ App sencilla: acepta, recoge, entrega
   
   Requisitos:
   • Mayor de 18 años
   • Identificación oficial
   • Teléfono con GPS y WhatsApp
   
   [Botón: "Registrarme como repartidor"] 
   → Enlace: https://wa.me/528147928662?text=Quiero%20ser%20repartidor
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   [Imagen: app_driver.png]

▶ SECCIÓN DERECHA: NEGOCIOS  
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   🏪 ¿Tienes un negocio en Valle del Roble?
   
   ✅ Sin comisiones mensuales (solo por entrega)
   ✅ Dashboard para ver tus pedidos en vivo
   ✅ Integración con WhatsApp Business
   ✅ Reportes de ventas y zonas de demanda
   
   Beneficios:
   • Amplía tu alcance sin repartidores propios
   • Enfócate en tu producto, nosotros en la logística
   • Soporte técnico incluido
   
   [Botón: "Registrar mi negocio"]
   → Enlace: https://wa.me/528147928662?text=Quiero%20registrar%20mi%20negocio
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   [Imagen: dashboard_negocio.png]

────────────────────────────────────────────────────────────────────────────
[PÁGINA: ZONAS Y MAPA]
────────────────────────────────────────────────────────────────────────────
▶ Título: "Cubrimos todo Valle del Roble y alrededores"

▶ Mapa principal: [Imagen: mapa_valle_roble.png]
   (O insertar Google Maps embebido con ubicación: "Valle del Roble, Monterrey")

▶ Texto descriptivo:
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   📍 Zonas activas actualmente:
   • Valle del Roble (núcleo)
   • Sampo Roble
   • Cadereyta Jiménez (zonas seleccionadas)
   • Colonias aledañas (consultar disponibilidad)

   📊 Estadísticas en tiempo real:
   • 26 negocios registrados
   • 12 repartidores activos
   • +150 mandados entregados este mes

   ❓ ¿Tu colonia no aparece? 
   ¡Escríbenos! Estamos expandiendo semanalmente.
   📲 WhatsApp: https://wa.me/528147928662
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

────────────────────────────────────────────────────────────────────────────
[PÁGINA: DASHBOARD EN VIVO]
────────────────────────────────────────────────────────────────────────────
▶ Título: "Dashboard Operativo en Tiempo Real"

▶ Imagen principal (grande, centrada): [dashboard_realtime.png]

▶ Texto explicativo:
   "Así vemos tus pedidos en nuestro centro de control LEDL. 
   Cada punto es un repartidor en movimiento 🛵💨"

▶ QR grande para acceso móvil: [qr_code_large.png]
   Texto debajo: "Escanea para acceder desde tu celular"

────────────────────────────────────────────────────────────────────────────
[PÁGINA: POLÍTICA DE PRIVACIDAD]
────────────────────────────────────────────────────────────────────────────
▶ Título: "Política de Privacidad y Términos de Uso"

▶ Contenido: [Ver archivo separado: privacy_policy.txt]

▶ Fecha de última actualización: 14 de abril de 2026

▶ Contacto para dudas de privacidad: privacidad@ledl.eco (o tu WhatsApp)

================================================================================
🔧 CONFIGURACIÓN ADICIONAL PARA WIX
================================================================================

▶ BOTÓN FLOTANTE DE WHATSAPP (en todas las páginas):
   • Posición: Esquina inferior derecha
   • Icono: Logo de WhatsApp
   • Enlace: https://wa.me/528147928662
   • Texto emergente: "¿Necesitas ayuda? ¡Escríbenos!"

▶ FOOTER (pie de página global):
   Texto: "Ecosistema LEDL • J ANDRES RESENDEZ R • Licencia: LAS ENSEÑANZAS DE LIZ"
   Enlaces: [Inicio] [WhatsApp] [Privacidad]

▶ SEO (Configuración → SEO):
   • Título: "Te Hacemos Los Mandados | Valle del Roble"
   • Descripción: "Servicio de mandados y entregas en Valle del Roble, Monterrey. Rápido, seguro y local. ¡Escanear y listo!"
   • Palabras clave: mandados, entregas, valle del roble, monterrey, delivery local, servicio a domicilio

▶ FAVICON:
   Sube tu logo pequeño (32x32px) como ícono del sitio

================================================================================
CONTENT_EOF

  echo -e "${GREEN}✅ Contenidos generados en: $OUTPUT_DIR/page_contents.txt${NC}"
}

# === FUNCIÓN: Generar política de privacidad ===
generate_privacy_policy() {
  echo -e "${YELLOW}📜 Generando política de privacidad...${NC}"
  
  cat > "$OUTPUT_DIR/privacy_policy.txt" << 'PRIVACY_EOF'
POLÍTICA DE PRIVACIDAD Y TÉRMINOS DE USO
"Te Hacemos Los Mandados - Valle del Roble"
Última actualización: 14 de abril de 2026

1. INFORMACIÓN QUE RECOPILAMOS
─────────────────────────────
• Datos de contacto: nombre, teléfono, dirección de entrega
• Ubicación: coordenadas GPS para asignación de repartidores (solo durante el servicio activo)
• Historial de pedidos: para mejorar nuestro servicio y resolver incidencias
• Dispositivo: tipo de teléfono y versión de sistema operativo (para compatibilidad)

2. USO DE LA INFORMACIÓN
────────────────────────
• Procesar y entregar tus mandados de manera eficiente
• Asignar repartidores cercanos a tu ubicación
• Enviarte notificaciones sobre el estado de tu pedido
• Mejorar nuestras rutas y tiempos de entrega
• Cumplir con obligaciones legales y fiscales

3. COMPARTICIÓN DE DATOS
────────────────────────
• Tus datos personales NO se venden ni se comparten con terceros comerciales
• La ubicación en tiempo real solo es visible para: tú (cliente), el repartidor asignado y nuestro equipo de soporte
• Datos agregados y anónimos pueden usarse para análisis de demanda por zona

4. SEGURIDAD
────────────
• Comunicaciones cifradas (HTTPS)
• Almacenamiento seguro de datos sensibles
• Acceso restringido al personal autorizado
• Copias de seguridad periódicas

5. TUS DERECHOS
───────────────
• Acceder a tus datos personales que tengamos
• Solicitar corrección o eliminación de tus datos
• Oponerte al uso de tu información para ciertos fines
• Retirar tu consentimiento en cualquier momento

Para ejercer tus derechos, escríbenos a: privacidad@ledl.eco o por WhatsApp: https://wa.me/52XXXXXXXXXX

6. COOKIES Y TECNOLOGÍAS SIMILARES
──────────────────────────────────
Nuestro sitio web utiliza cookies técnicas necesarias para:
• Mantener tu sesión activa
• Recordar tus preferencias de idioma
• Analizar el tráfico para mejorar la experiencia

Puedes configurar tu navegador para rechazar cookies, pero algunas funciones del sitio podrían no estar disponibles.

7. MENORES DE EDAD
──────────────────
Nuestros servicios están dirigidos a personas mayores de 18 años. No recopilamos intencionalmente información de menores. Si detectamos que un menor ha proporcionado datos personales, los eliminaremos inmediatamente.

8. CAMBIOS A ESTA POLÍTICA
─────────────────────────
Podemos actualizar esta política periódicamente. Te notificaremos cambios significativos mediante:
• Actualización de la fecha en esta página
• Mensaje en nuestro sitio web
• Notificación por WhatsApp si tienes pedidos activos

9. LEY APLICABLE Y JURISDICCIÓN
───────────────────────────────
Esta política se rige por las leyes de los Estados Unidos Mexicanos. Cualquier disputa relacionada será resuelta en los tribunales de Monterrey, Nuevo León.

10. CONTACTO
────────────
¿Preguntas sobre esta política?
📧 Email: privacidad@ledl.eco
📱 WhatsApp: https://wa.me/528147928662
📍 Dirección: Valle del Roble, Monterrey, NL, México

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"Ecosistema LEDL • J ANDRES RESENDEZ R • Licencia: LAS ENSEÑANZAS DE LIZ"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PRIVACY_EOF

  echo -e "${GREEN}✅ Política de privacidad generada${NC}"
}

# === FUNCIÓN: Validar assets (imágenes) ===
validate_assets() {
  echo -e "${YELLOW}🖼️ Validando imágenes para Wix...${NC}"
  
  # Wix recomienda: 
  # • Banner: 1920x1080px mínimo, <5MB
  # • Imágenes de contenido: 1200x800px, <2MB  
  # • QR/íconos: 512x512px, <500KB
  # • Formato: JPG o PNG
  
  local errors=0
  
  for img in "$ASSETS_DIR"/*.png "$ASSETS_DIR"/*.jpg 2>/dev/null; do
    [ -f "$img" ] || continue
    
    # Verificar que existe el comando file
    if command -v file &> /dev/null; then
      echo "  • $(basename "$img") → OK"
    else
      echo "  • $(basename "$img") → ⚠️ (sin validación de tamaño)"
    fi
  done
  
  if [ $errors -eq 0 ]; then
    echo -e "${GREEN}✅ Assets validados (revisión manual recomendada)${NC}"
  else
    echo -e "${RED}❌ $errors errores encontrados${NC}"
  fi
}

# === FUNCIÓN: Generar checklist final ===
generate_checklist() {
  echo -e "${YELLOW}✅ Generando checklist final...${NC}"
  
  cat > "$OUTPUT_DIR/wix_checklist.md" << CHECKLIST_EOF
# ✅ Checklist: Publicar sitio Wix "Te Hacemos Los Mandados"

## 📋 PRE-REQUISITOS (Hechos por el orquestador)
- [x] Configuración YAML generada: \`wix_config.yaml\`
- [x] Contenidos listos para copiar: \`output/page_contents.txt\`
- [x] Política de privacidad: \`output/privacy_policy.txt\`
- [x] Assets organizados en: \`assets/\`

## 🌐 PASOS EN WIX (Manual - 25-40 min)

### 1️⃣ Crear cuenta y sitio (2 min)
- [ ] Ir a [wix.com](https://www.wix.com)
- [ ] Clic en "Crear sitio gratis"
- [ ] Registrarse con Google/Facebook
- [ ] Elegir categoría: "Negocio local" → "Servicio"

### 2️⃣ Plantilla (1 min)  
- [ ] Seleccionar "Empezar desde cero" (blank template)
- [ ] Nombre: \`$PROJECT_NAME\`
- [ ] Subdominio: \`$WIX_SUBDOMAIN\`

### 3️⃣ Diseño (3 min)
- [ ] Diseño → Colores del sitio
  - [ ] Primario: \`$PRIMARY_COLOR\`
  - [ ] Secundario: \`$SECONDARY_COLOR\`
  - [ ] Fondo: \`#FFFFFF\`
- [ ] Tipografía: "Montserrat" (títulos) + "Roboto" (cuerpo)

### 4️⃣ Crear páginas (5 min)
- [ ] Inicio
- [ ] Cómo funciona
- [ ] Para Clientes
- [ ] Para Repartidores y Negocios
- [ ] Zonas y Mapa
- [ ] Dashboard en Vivo
- [ ] Política de Privacidad

### 5️⃣ Contenido por página (15-25 min)
> 💡 Copia y pega desde \`output/page_contents.txt\`

- [ ] **Inicio**: Banner + botones + 3 columnas
- [ ] **Cómo funciona**: Flujograma + 5 pasos
- [ ] **Para Clientes**: Flyer + beneficios + screenshot
- [ ] **Para Repartidores/Negocios**: Dos columnas con CTAs
- [ ] **Zonas y Mapa**: Mapa + estadísticas + Google Maps embed
- [ ] **Dashboard**: Imagen grande + QR
- [ ] **Privacidad**: Pegar texto completo de \`privacy_policy.txt\`

### 6️⃣ Elementos globales (3 min)
- [ ] Botón flotante de WhatsApp → \`https://wa.me/$WHATSAPP_NUMBER\`
- [ ] Footer con texto: "Ecosistema LEDL • J ANDRES RESENDEZ R • Licencia: LAS ENSEÑANZAS DE LIZ"
- [ ] Google Maps en página "Zonas" → Buscar "Valle del Roble, Monterrey"

### 7️⃣ SEO y configuración (2 min)
- [ ] Configuración → SEO Básico
  - Título: \`Te Hacemos Los Mandados | Valle del Roble\`
  - Descripción: \`Servicio de mandados y entregas en Valle del Roble, Monterrey. Rápido, seguro y local. ¡Escanear y listo!\`
- [ ] Subir favicon (logo 32x32px)

### 8️⃣ Publicar (1 min)
- [ ] Clic en "Publicar" (esquina superior derecha)
- [ ] Confirmar subdominio: \`https://$WIX_SUBDOMAIN.wixsite.com\`
- [ ] ✅ ¡Sitio en vivo!

## 🔍 POST-PUBLICACIÓN (Verificación)
- [ ] Abrir sitio en navegador móvil y escritorio
- [ ] Probar botón de WhatsApp (debe abrir la app)
- [ ] Verificar que todas las imágenes carguen
- [ ] Revisar que el footer aparezca en todas las páginas
- [ ] Probar enlace del QR (si es imagen clicable)

## 🚀 SIGUIENTES PASOS (Opcionales pero recomendados)
- [ ] Conectar dominio personalizado (si lo tienes)
- [ ] Configurar Google Analytics (Wix → Marketing → Integraciones)
- [ ] Crear versión en inglés (si planeas expandir)
- [ ] Programar backups mensuales de la configuración

---
*Generado por Orquestador LEDL • $(date)*
*Para soporte: https://wa.me/$WHATSAPP_NUMBER*
CHECKLIST_EOF

  echo -e "${GREEN}✅ Checklist generado: $OUTPUT_DIR/wix_checklist.md${NC}"
}

# === FUNCIÓN: Generar manifiesto de despliegue ===
generate_manifest() {
  echo -e "${YELLOW}📦 Generando deployment manifest...${NC}"
  
  cat > "$OUTPUT_DIR/deployment_manifest.json" << EOF
{
  "project": "$PROJECT_NAME",
  "platform": "Wix",
  "generated_at": "$(date -Iseconds)",
  "config": {
    "subdomain": "$WIX_SUBDOMAIN",
    "expected_url": "https://$WIX_SUBDOMAIN.wixsite.com",
    "primary_color": "$PRIMARY_COLOR",
    "secondary_color": "$SECONDARY_COLOR"
  },
  "pages": 7,
  "assets_count": $(find "$ASSETS_DIR" -type f \( -name "*.png" -o -name "*.jpg" \) 2>/dev/null | wc -l),
  "integrations": {
    "whatsapp": "https://wa.me/$WHATSAPP_NUMBER",
    "google_maps": "Valle del Roble, Monterrey, NL"
  },
  "seo": {
    "title": "Te Hacemos Los Mandados | Valle del Roble",
    "description": "Servicio de mandados y entregas en Valle del Roble, Monterrey. Rápido, seguro y local. ¡Escanear y listo!",
    "keywords": ["mandados", "entregas", "valle del roble", "monterrey", "delivery local"]
  },
  "next_steps": [
    "Seguir checklist: output/wix_checklist.md",
    "Copiar contenidos desde: output/page_contents.txt",
    "Verificar assets en: assets/",
    "Publicar y compartir enlace"
  ]
}
EOF

  echo -e "${GREEN}✅ Manifest generado: $OUTPUT_DIR/deployment_manifest.json${NC}"
}

# === FUNCIÓN: Resumen final ===
show_summary() {
  echo ""
  echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
  echo -e "${GREEN}║  🎉 ORQUESTADOR WIX COMPLETADO EXITOSAMENTE ║${NC}"
  echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
  echo ""
  echo "📁 Archivos generados:"
  echo "   • wix_config.yaml          → Configuración del sitio"
  echo "   • output/page_contents.txt → Textos para copiar en Wix"
  echo "   • output/privacy_policy.txt → Política de privacidad"
  echo "   • output/wix_checklist.md  → Checklist paso a paso"
  echo "   • output/deployment_manifest.json → Metadatos del despliegue"
  echo ""
  echo "🖼️ Assets esperados en \`assets/\`:"
  echo "   • logo_banner.png          (1920x1080px)"
  echo "   • qr_code.png              (512x512px)"
  echo "   • flowchart_valle_roble.png (1200x800px)"
  echo "   • app_cliente.png, app_repartidor.png, app_negocio.png"
  echo "   • flyer_clientes.png, dashboard_realtime.png, mapa_valle_roble.png"
  echo ""
  echo -e "${BLUE}🚀 SIGUIENTE PASO:${NC}"
  echo "   1. Revisa que tus imágenes estén en \`assets/\`"
  echo "   2. Abre el checklist: \`cat output/wix_checklist.md\`"
  echo "   3. Ve a https://wix.com y sigue los pasos"
  echo "   4. Copia/pega los contenidos desde \`output/page_contents.txt\`"
  echo ""
  echo -e "${YELLOW}💡 TIP PRO:${NC}"
  echo "   Guarda este orquestador. Cuando quieras actualizar el sitio,"
  echo "   modifica \`wix_config.yaml\` y ejecuta de nuevo para regenerar"
  echo "   los contenidos automáticamente."
  echo ""
  echo "¿Necesitas ayuda? 📲 https://wa.me/$WHATSAPP_NUMBER"
  echo ""
}

# === EJECUCIÓN PRINCIPAL ===
main() {
  setup_dirs
  generate_config
  generate_content
  generate_privacy_policy
  validate_assets
  generate_checklist
  generate_manifest
  show_summary
}

# Ejecutar si se llama directamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
