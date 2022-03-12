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

Setup

```bash
$ mkdir video-streaming
$ cd video-streaming

# setup node project
$ npm init -y
$ npm install --save express
$ npm install
```

Create [index.js](video-streaming/index.js)

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

> **Testing**: Run server, in video-streaming terminal run `node index.js`
