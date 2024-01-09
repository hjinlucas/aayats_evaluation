const Beat = require('../models/Beats');

// Get all beats
exports.getAllBeats = async (req, res) => {
  try {
    const beats = await Beat.find();
    res.json(beats);
  } catch (err) {
    res.status(500).send(err);
  }
};

// New createBeat function
exports.createBeat = async (req, res) => {
    const newBeat = new Beat(req.body);

    try {
        const savedBeat = await newBeat.save();
        res.status(201).json(savedBeat);
    } catch (err) {
        res.status(500).json(err);
    }
};