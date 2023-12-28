const User = require("../models/User");
const CryptoJS = require("crypto-js");
require("dotenv").config();
const jwt = require("jsonwebtoken");

module.exports = {
  createUser: async (req, res) => {
    const newUser = new User({
      username: req.body.username,
      email: req.body.email,
      // Encrypt password
      password: CryptoJS.AES.encrypt(
        req.body.password,
        process.env.SECRET
      ).toString(),
    });

    try {
      const savedUser = await newUser.save();
      res.status(200).json(savedUser);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  loginUser: async (req, res) => {
    try {
      console.log(req.body.email); // Log the email being queried
      const user = await User.findOne({ email: req.body.email });
      if (!user) {
        return res.status(401).json("Wrong login info.");
      }

      // Decrypt the stored password
      const decryptedData = CryptoJS.AES.decrypt(
        user.password,
        process.env.SECRET
      );
      const decryptedPassword = decryptedData.toString(CryptoJS.enc.Utf8);

      // Check if the decrypted password matches the provided password
      if (decryptedPassword !== req.body.password) {
        return res.status(401).json("Wrong password.");
      }

      // Create a JWT token after successful login
      const accessToken = jwt.sign(
        { id: user._id },
        process.env.JWT_SEC,
        { expiresIn: "3d" } // Set the token to expire in 3 days
      );

      // Here we can choose what user details to send back in the response.
      const { password, ...others } = user._doc;

      // Send back the token and user data
      res.status(200).json({ ...others, accessToken });
    } catch (error) {
      res.status(500).json(error.message);
    }
  },
};
