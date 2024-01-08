const Beats = require("../models/Beats");

const beatsController = {
  // Get all beats
  getBeats: async (req, res) => {
    try {
      const beats = await Beats.find();
      res.status(200).json(beats);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Create new beats
  createBeats: async (req, res) => {
    const { title, likes, artists, key, bpm, price, imageUrl } = req.body;
    const producerId = "659a19f63ef66fc1c2676f70";

    try {
      const newBeat = await Beats.create({
        title,
        likes,
        artists,
        key,
        bpm,
        price,
        imageUrl,
        producerId,
      });

      res.status(201).json(newBeat);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Update beats
  updateBeats: async (req, res) => {
    const { id } = req.params;
    const { title, likes, artists, key, bpm, price, imageUrl } = req.body;
   
    try {
      // Check if the beat with the given id exists
      const existingBeat = await Beats.findById(id);
      if (!existingBeat) {
        return res.status(404).json({ error: 'Beat not found' });
      }
  
      // Update only non-null fields
      existingBeat.title = title || existingBeat.title;
      existingBeat.likes = likes || existingBeat.likes;
      existingBeat.artists = artists || existingBeat.artists;
      existingBeat.key = key || existingBeat.key;
      existingBeat.bpm = bpm || existingBeat.bpm;
      existingBeat.price = price || existingBeat.price;
      existingBeat.imageUrl = imageUrl || existingBeat.imageUrl;
  
      // Save the updated beat
      const updatedBeat = await existingBeat.save();
  
      res.json(updatedBeat);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Delete beats
  deleteBeats: async (req, res) => {
    const { id } = req.params;
  
    try {
      // Check if the beat with the given id exists
      const existingBeat = await Beats.findById(id);
      if (!existingBeat) {
        return res.status(404).json({ error: 'Beat not found' });
      }
  
      // Delete the beat
      await Beats.findByIdAndDelete(id);
  
      res.status(204).json(); // Use status code 204 for a successful deletion
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },  
};

module.exports = beatsController;
