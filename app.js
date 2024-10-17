const {Pool}  = require('pg');
const express = require('express');
const app = express();
const port = 3000;
const pgPool = new Pool({
  connectionString: process.env.STP_MY_DATABASE_CONNECTION_STRING // env variable was automatically injected by Stacktape
});

app.get('/time', async (req, res) => {
  const result = await pgPool.query('SELECT NOW()');
  const time = result.rows[0];

  res.send(time);
});

app.get('/', (req, res) => {
  res.send('<h1>Auto Scaling Demo App</h1> <h4>Message: Success</h4> <p>Version: 1.0.0</p>');
})

app.listen(port, () => {
  console.log(`Demo app is up and listening to port ${port}`);
})
