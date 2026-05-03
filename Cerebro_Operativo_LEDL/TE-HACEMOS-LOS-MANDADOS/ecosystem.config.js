module.exports = {
  apps: [
    {
      name: "uber-engine-level2",
      script: "server.js",
      env: {
        NODE_ENV: "production",
        PORT: 3000
      }
    }
  ]
};
