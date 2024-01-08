const router = require("express").Router();
const beatsController = require("../controllers/beatsController");

// GET ALL

router.get("/findAll", beatsController.findAll);



module.exports = router