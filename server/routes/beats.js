const router = require("express").Router();
const beatsController = require("../controllers/beatsController");
const { verifiedAndAuthorized, verifiedToken } = require("../middleware/verifyToken");

// Get all beats 
router.get("", beatsController.getBeats);

// Create new beats 
router.post("/create", verifiedAndAuthorized, beatsController.createBeats);

// Update beats
router.put("/:id", verifiedAndAuthorized, beatsController.updateBeats);

// Delete beats
router.delete("/:id", verifiedAndAuthorized, beatsController.deleteBeats);

module.exports = router