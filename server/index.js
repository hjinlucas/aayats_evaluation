const express = require('express');
const app = express();
const dotenv = require('dotenv');
const mongoose = require('mongoose');
const authRoute = require("./routes/auth");
const userRoute = require("./routes/user");
const beatRoute = require("./routes/beat");

//Schema for user information in DB
const UserModel = require("./models/User")
const cors = require("cors");


dotenv.config();

// Check if the environment variable is being read correctly
// console.log("Port from .env:", process.env.PORT);

mongoose.connect(process.env.MONGO_URL).then(()=>console.log('db connected')).catch((err)=>{console.log(err)});
app.use(cors({
    origin: '*',
    allowedHeaders: 'X-Requested-With, Content-Type, auth-token',
}));
app.use(express.json());
app.use("/api", authRoute);
app.use("/api/users", userRoute);
app.use("/api/beats", beatRoute);

app.get('/', (req, res) => {
    res.send("Hello World!")
})

const port = process.env.PORT || 5002;
app.listen(port, () => console.log(`Aayats listening on port ${port}!\n Server Listening on http://localhost:${port}/`));
