const express = require('express');


const authRouter = express.Router();

authRouter.post('/api/signin', (req, res) => {
     const {name,email,password}=req.body;//get data from client
     
     //post to database
    });

module.exports = authRouter;