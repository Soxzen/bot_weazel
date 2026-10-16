# node:22-slim (Debian) et pas Alpine : les modules natifs courants
# (better-sqlite3, sharp...) ont des binaires precompiles pour la glibc,
# donc aucune chaine de compilation a installer.
FROM node:22-slim

WORKDIR /app
ENV NODE_ENV=production

# On copie d'abord les manifestes : tant qu'ils ne changent pas,
# Docker reutilise le cache et le deploiement est bien plus rapide.
COPY package*.json ./
# npm ci exige un package-lock.json ; sinon on retombe sur npm install.
RUN npm ci --omit=dev || npm install --omit=dev

COPY . .

CMD ["node", "index.js"]
