const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");

//signup route
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body; //get data from client
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ msg: "User already exists." });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);
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

//signin route
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body; //get data from client
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({ msg: "User does not exists!" });
    }
    const isMatch = await bcryptjs.compare(password, user.password);

    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect Password!" });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");

    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
