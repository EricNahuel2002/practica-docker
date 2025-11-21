# ==========================================================
# ETAPA ÚNICA: BUILD Y RUN (con depuración de Prisma)
# Esta imagen es grande pero garantiza que todo lo necesario esté presente.
# ==========================================================
FROM node:24 

# 1. DIRECTORIO DE TRABAJO
WORKDIR /app

# 2. COPIAR E INSTALAR DEPENDENCIAS
# Copiamos package.json para instalar TODAS las dependencias (incluyendo dev y Prisma CLI)
COPY package.json package-lock.json ./
RUN npm install

# 3. COPIAR CÓDIGO FUENTE
# Copia todo el resto del proyecto (src/, tsconfig.json, .env, prisma/, etc.).
COPY . .

# --- Pasos CRÍTICOS ---

# 4. GENERAR CLIENTE PRISMA
# CRÍTICO: Carga la DATABASE_URL del .env al entorno de la shell para que Prisma pueda generar su cliente.
# Si este paso falla, tu app fallará con un "module not found" al intentar importar el cliente de Prisma.
RUN export $(grep -v '^#' .env | xargs) && npx prisma generate

# 5. COMPILAR EL CÓDIGO (Genera /dist)
# Ejecuta tsc para transformar src/ en dist/.
RUN npm run build

# 6. DEPURACIÓN: Verifica que el archivo index.js se haya creado
# Esto nos confirma que 'npm run build' funcionó. Si esta línea falla, la compilación falló.
RUN ls -l dist

# -----------------------

# 7. DOCUMENTAR PUERTO
EXPOSE 3000

# 8. COMANDO DE INICIO
# Ejecuta el script 'start' de tu package.json: node dist/index.js
CMD [ "npm", "run", "start" ]