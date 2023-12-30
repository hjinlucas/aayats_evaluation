const Beats = require("../models/Beats");
require("dotenv").config();

module.exports = {
  getBeats: async (req, res) => {
    try {
      const allBeats = await Beats.find();
      res.status(200).json(allBeats);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  createBeats: async (req, res) => {
    const {
      title,
      likes,
      artists,
      key,
      bpm,
      price,
      priceRaw,
      imageUrl,
      producerId,
    } = req.body;
    const newBeats = new Beats({
      title,
      likes,
      artists,
      key,
      bpm,
      price,
      priceRaw,
      imageUrl,
      producerId,
    });

    try {
      const savedBeats = await newBeats.save();
      res.status(200).json(savedBeats);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  updateBeats: async (req, res) => {
    try {
      const updatedBeats = await Beats.findByIdAndUpdate(
        req.params.id,
        { $set: req.body },
        { new: true }
      );

      // Ensure the updatedUser is not null
      if (!updatedBeats) {
        return res.status(404).json({ message: "Beats not found." });
      }

      res.status(200).json(updatedBeats);
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  },

  deleteBeats: async (req, res) => {
    try {
      await Beats.findByIdAndDelete(req.params.id);
      res.status(200).json("Beats Has Been Successfully Deleted");
    } catch (error) {
      res.status(500).json(error);
    }
  },
};
