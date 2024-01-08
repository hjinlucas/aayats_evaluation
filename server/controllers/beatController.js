const Beats = require("../models/Beats");

module.exports = {
    getAllBeats: async (req, res) => {
        try {
            const beats = await Beats.find();
            res.status(201).json(beats);
        } catch (error) {
            res.status(501).json({error: "Error fetching beats", details: error.message});
        }
    },
    addBeat: async (req, res) => {
        const beat = new Beats(req.body);

        // check for valid beat before adding to db
        const invalidBeatError = beat.validateSync();
        if (invalidBeatError) {
            return res.status(401).json({error: "Invalid Beat", details: invalidBeatError.message});
        }

        try {
            const savedBeat = await beat.save();
            res.status(201).json(savedBeat);
        } catch (error) {
            res.status(500).json({error: "Failed to Add Beats", details: error.message});
        }
    },
};