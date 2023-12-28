const router = require("express").Router();
const {
  verifiedAndAuthorized,
  verifiedToken,
} = require("../middleware/verifyToken");

const beatsController = require("../controllers/beatsController");

// GET ALL BEATS
router.get("/", beatsController.getBeats);

// ADD SINGLE BEATS
router.post("/add", beatsController.createBeats);

// DELETE BEATS
router.delete("/:id", verifiedAndAuthorized, beatsController.deleteBeats);

// UPDATE BEATS
router.put("/:id", verifiedAndAuthorized, beatsController.updateBeats);

module.exports = router;
