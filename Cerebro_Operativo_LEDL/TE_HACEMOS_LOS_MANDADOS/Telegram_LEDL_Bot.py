from telegram import Update
from telegram.ext import ApplicationBuilder, ContextTypes, CommandHandler

# Configuración
ADMIN_ID = 8486738889 # Tu ID personal

async def master_cmd(update: Update, context: ContextTypes.DEFAULT_TYPE):
    user_id = update.effective_user.id
    if user_id != ADMIN_ID:
        await update.message.reply_text("[!] Acceso denegado: Área privada.")
        return
    
    # Aquí irían tus funciones de Token, Pedidos, Logs, y Auditoría
    await update.message.reply_text("Panel Maestro LEDL: Tokens, Pedidos en curso y Logs activos.")

async def user_cmd(update: Update, context: ContextTypes.DEFAULT_TYPE):
    # Funciones para el cliente
    await update.message.reply_text("Bienvenido a TE HACEMOS LOS MANDADOS. ¿Cómo puedo ayudarte hoy? (Ventas, Soporte, Guía)")

# Registro de comandos en el ApplicationBuilder
application.add_handler(CommandHandler('master', master_cmd))
application.add_handler(CommandHandler('start', user_cmd))
