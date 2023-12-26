FROM node:18-slim AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build


# production stage
FROM node:18-slim

RUN apt-get update && apt-get install -y ffmpeg

WORKDIR /app

COPY package*.json docOrdIntro.mkv ./

RUN npm install --only=production       

COPY --from=build /app/dist ./dist 

EXPOSE 3001

CMD [ "npm", "run", "serve" ]