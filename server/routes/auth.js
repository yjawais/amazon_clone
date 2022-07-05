const express = require("express");
const User = require("../models/user");
const bcryptjs= require('bcryptjs');
const authRouter = express.Router();

//signup route
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { name, email, password } = req.body; //get data from client
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ msg: "User already exists." });
    }

    const hashedPassword=await bcryptjs.hash(password,8);
    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    res.json(user);
    //post to database
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
