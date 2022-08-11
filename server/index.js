//import package
const express = require('express');
const mongoose = require('mongoose');

//import other file
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');

//init
const app = express();
const PORT = 3000;
const DB = "mongodb+srv://awais:awais@cluster0.orznk0u.mongodb.net/?retryWrites=true&w=majority";


//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);


//connection
mongoose.connect(DB).then(() => { console.log('connection success'); }).catch((e) => { console.log(e); });


app.listen(PORT, '0.0.0.0', () => {
    console.log(`at ${PORT}`);
});