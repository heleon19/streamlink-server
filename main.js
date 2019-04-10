const express = require("express");
const app = express();
const util = require("util");
const exec = util.promisify(require("child_process").exec);

app.get("/:args", async (req, res) => {
  const args = Buffer.from(req.params.args || "", "base64").toString("ascii");
  console.log(args);
  try {
    res.send((await exec("streamlink --stream-url " + args)).stdout);
  } catch (err) {
    console.error(err);
    res.status(500).send(err);
  }
});

app.listen(8080, () => {
  console.log("streamlink-server app listening on port 8080!");
});
