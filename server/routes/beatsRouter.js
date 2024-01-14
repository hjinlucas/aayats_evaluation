// beatsRouter.js
const express = require('express');
const router = express.Router();
const beatsController = require("../controllers/beatsController");

// Route to get all beats
router.get('/', beatsController.getAllBeats);

// New POST route
router.post('/', beatsController.createBeat);

module.exports = router;
