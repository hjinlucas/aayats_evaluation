const express = require('express');
const app = express();
const cors = require('cors');
const dotenv = require('dotenv');
const mongoose = require('mongoose');
const authRoute = require("./routes/auth");
const userRoute = require("./routes/user");
const beatRouter = require("./routes/beat");

dotenv.config();

// Check if the environment variable is being read correctly
// console.log("Port from .env:", process.env.PORT);

mongoose.connect(process.env.MONGO_URL).then(()=>console.log('db connected')).catch((err)=>{console.log(err)});

app.use(cors());
app.use(express.json());
app.use("/api", authRoute);
app.use("/api/users", userRoute);
app.use("/api/beats", beatRouter);

const port = process.env.PORT || 5002;
app.listen(port, () => console.log(`Aayats listening on port ${port}!`));
