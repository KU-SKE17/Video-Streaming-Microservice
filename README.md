# Video Streaming Microservice

This project is a tutorial to build microservices based on the [textbook](https://www.manning.com/books/bootstrapping-microservices-with-docker-kubernetes-and-terraform?a_aid=datawranglingwithjavascript&a_bid=f8e47dba) --Bootstrapping Microservices with Docker, Kubernetes and Terraform.

## About the Application

- name: `FlixTube`
- have a browser-based front end
- contain services for:
  - video streaming
  - storage and upload
  - a gateway for the customer-facing front end

## Tools

- `Node.js`: To build the microservices
- `Docker`: To package and deploy the services
- `Docker` Compose: To test the microservices application on the development workstation
- `Kubernetes`: To host the application in the cloud
- `Terraform`: To build the cloud infrastructure, the Kubernetes cluster, and deploy the application

## Architecture

![architecture](images/architecture.png)

## Development (step-by-step hand-on)

Source codes: [bootstrapping-microservices/repos](https://github.com/orgs/bootstrapping-microservices/repositories)

### Chapter 2 Creating your first microservice

Building an HTTP server for video streaming

1. Create a Node.js project for our microservice.
2. Install Express and create a simple HTTP server.
3. Add an HTTP GET route /video that retrieves the streaming video.

Setup project

```bash
mkdir video-streaming
cd video-streaming

npm init -y
npm install --save express
npm install
```

Create router --[index.js](video-streaming/index.js)

```js
const express = require("express");

const app = express();
const port = 3000;

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.listen(port, () => {
  console.log(
    `First example app listening on port ${port}, point your browser at http://localhost:3000`
  );
});
```

> **Running**: to test/run the server, in video-streaming terminal run `node index.js` and go to http://localhost:3000

Update HTTP endpoint, In [index.js](video-streaming/index.js)

```js
// add
const fs = require("fs");

// update
app.get("/video", (req, res) => {
  const path = "../videos/SampleVideo_1280x720_1mb.mp4";
  fs.stat(path, (err, stats) => {
    if (err) {
      console.error("An error occurred ");
      res.sendStatus(500);
      return;
    }

    res.writeHead(200, {
      "Content-Length": stats.size,
      "Content-Type": "video/mp4",
    });
    fs.createReadStream(path).pipe(res);
  });
});
```

> **Running**: go to http://localhost:3000/video

Config environment

- setup env variable, in terminal

  ```bash
  export <key>=<value>
  ```

- in [index.js](video-streaming/index.js) using `process.env.<key>`

Setup production

- in terminal

  ```bash
  npm install --only=production
  ```

- in [package.json](video-streaming/package.json)

  ```json
  "scripts": {
      "test": "echo \"Error: no test specified\" && exit 1",
      // add
      "start": "node index.js"
  },
  ```

> **Running**: from now, using `npm start` convention

Create live reload pipeline

```bash
npm install --save-dev nodemon
```

> **Running**: to use nodemon, using `npx nodemon index.js`

> or add "start:dev": "nodemon index.js" in [package.json](video-streaming/package.json) scripts (just like above) to use `npm run start:dev` convention instead

Summary of Running Command

```bash
# install dependencies
npm install
# install as simulated production
npm install --only=production

# run
npm start
# run with live reload
npm run start:dev
```
