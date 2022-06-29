//import package
const express = require('express');
const mongoose = require('mongoose');

//import other file
const authRouter = require('./routes/auth');

//init
const app = express();
const PORT = 3000;
const DB = "mongodb+srv://awais:Awais@8900@cluster0.j1f0rjd.mongodb.net/?retryWrites=true&w=majority";
//middleware
app.use(authRouter);

//connection
mongoose.connect(DB).then(() => { console.log('connection success'); }).catch((e) => { console.log(e); });


app.listen(PORT, '0.0.0.0', () => {
    console.log(`at ${PORT}`);
});