#!/data/data/com.termux/files/usr/bin/python3
# ~/Main_LEDL/Cerebro_Operativo_LEDL/wix_orchestrator/content_generator.py
# Generador avanzado de contenidos para Wix

import yaml
import json
from datetime import datetime
from pathlib import Path

def load_config(config_path="wix_config.yaml"):
    """Cargar configuración YAML"""
    with open(config_path, 'r', encoding='utf-8') as f:
        return yaml.safe_load(f)

def generate_page_content(page_config, whatsapp_number):
    """Generar contenido formateado para una página específica"""
    content = []
    
    content.append(f"\n[PÁGINA: {page_config['title'].upper()}]")
    content.append("─" * 76)
    
    if page_config.get('template') == 'hero_3col':
        content.append("▶ Banner principal (texto sobre imagen):")
        content.append("━" * 76)
        content.append("TE HACEMOS LOS MANDADOS\nVALLE DEL ROBLE\n\nTu tiempo, nuestra prioridad")
        content.append("━" * 76 + "\n")
        
        if 'cta' in page_config:
            cta = page_config['cta']
            content.append(f"▶ Botón 1:\n   Texto: \"{cta['primary']['text']}\"\n   Enlace: {cta['primary']['link'].replace('XXXXXXXXXX', whatsapp_number)}")
            content.append(f"▶ Botón 2:\n   Texto: \"{cta['secondary']['text']}\"\n   Enlace: (abre modal con imagen qr_code.png)\n")
    
    # Agregar más templates según necesites...
    
    return "\n".join(content)

def main():
    config = load_config()
    whatsapp = config.get('integrations', {}).get('whatsapp_number', '52XXXXXXXXXX')
    
    output = Path("output")
    output.mkdir(exist_ok=True)
    
    # Generar contenido por página
    with open(output / "page_contents_advanced.txt", 'w', encoding='utf-8') as f:
        f.write(f"📋 CONTENIDOS AVANZADOS - {config['site']['name']}\n")
        f.write(f"Generado: {datetime.now().isoformat()}\n")
        f.write("=" * 76 + "\n")
        
        for page in config.get('pages', []):
            content = generate_page_content(page, whatsapp)
            f.write(content)
    
    # Generar JSON para posible integración futura
    with open(output / "wix_content_structured.json", 'w', encoding='utf-8') as f:
        json.dump({
            "metadata": {
                "generated_at": datetime.now().isoformat(),
                "platform": "Wix",
                "project": config['site']['name']
            },
            "pages": {p['slug']: {
                "title": p['title'],
                "template": p['template'],
                "assets": p.get('assets', []),
                "seo": {
                    "title": f"{p['title']} | {config['site']['name']}",
                    "description": config.get('seo', {}).get('description', '')
                }
            } for p in config.get('pages', [])},
            "global": {
                "whatsapp": f"https://wa.me/{whatsapp}",
                "footer": config.get('footer', {}),
                "design": config.get('design', {})
            }
        }, f, indent=2, ensure_ascii=False)
    
    print(f"✅ Contenidos avanzados generados en {output}/")

if __name__ == "__main__":
    main()
