const router = require("express").Router();
const beatController = require("../controllers/beatController");

// GET BEATS 
router.get("/", beatController.getAllBeats);

// ADD BEATS
router.post("/", beatController.addBeat);

module.exports = router