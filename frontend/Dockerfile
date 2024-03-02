FROM node:21-slim

WORKDIR /frontend

COPY . /frontend/

RUN npm install .

ENV PORT=3001

CMD npm run start
