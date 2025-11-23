FROM node:24 AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .

RUN export $(grep -v '^#' .env | xargs) && npx prisma generate

RUN npm run build

RUN ls -R /app/dist


FROM node:24-slim AS run

WORKDIR /app

COPY --from=build /app/dist ./dist

COPY package.json package-lock.json ./

RUN npm install --only=production

COPY --from=build /app/.env ./

COPY --from=build /app/node_modules/.prisma ./node_modules/.prisma

COPY --from=build /app/node_modules/@prisma/client/runtime ./node_modules/@prisma/client/runtime

EXPOSE 3000

CMD [ "node", "dist/index.js" ]