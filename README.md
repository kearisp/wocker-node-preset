# Node preset for Wocker

[![Version](https://img.shields.io/badge/version-1.0.4-blue.svg)](https://github.com/kearisp/wocker-node-preset)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](./LICENSE)

A lightweight and efficient preset for developing node.js applications with the Wocker workspace.


## Installation

You can add this preset to an existing Wocker project:

```shell
ws preset:install node
```

## Features

- 🚀 Ready-to-use node.js environment with Alpine Linux base
- 🔄 Automatic dependencies installation with npm/yarn support
- 📁 Support for initialization scripts and custom startup hooks
- 🔒 Non-root user execution for better security
- ⚡ Optimized for development and production use
- 🌐 Built-in timezone configuration (default: Europe/Kyiv)

## Usage

### Initialization Scripts

You can mount a directory with custom initialization scripts that will run on container startup:

```shell
ws volume:mount ./my-scripts:/etc/wocker-init.d
```

Scripts are executed in alphabetical order. Consider using numeric prefixes (e.g., `10-setup.sh`, `20-migrate.sh`) to control execution order.

### Environment Variables

The preset supports common Wocker environment variables, plus:

- `VIRTUAL_PORT`: Default port your node.js application should listen on (provided by nginx-proxy)
- `NPM_RUN`: Command to start your application (default: "npm start")
- `PACKAGE_MANAGER`: Choose between npm or yarn (default: "npm")
- `TZ`: Timezone configuration (default: Europe/Kyiv)

Example of using the environment port in your app:

```javascript
const express = require("express");

const app = express();

app.get("/",(req, res)=>{
    res.send("<h1>Express - Fast, unopinionated, minimalist web framework for Node.js</h1>");
});

app.listen(process.env.VIRTUAL_PORT || 3000, ()=>{
    console.log("server is up");
});
```


### Docker Image

This preset uses the official node Docker image ([`node`](https://hub.docker.com/_/node)) with Alpine Linux by default. You can change the version: `node`


```shell
ws build-args:set IMAGE_VERSION=latest
```


Available options: `lts-alpine`, `latest`, or a specific version like `24-alpine`.

For a complete list of available node versions, see: [https://hub.docker.com/_/node/tags](https://hub.docker.com/_/node/tags)


## Prerequisites

- Docker installed and running
- Wocker CLI installed
- Basic understanding of node.js

## Security Considerations

This preset implements several security best practices:

- Runs as non-root user (UID 1000)
- Uses Alpine Linux base for minimal attack surface
- Supports custom initialization scripts with proper permissions
- Dependencies are installed only when package.json changes

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

_This preset is part of the [Wocker](https://kearisp.github.io/wocker) ecosystem._
