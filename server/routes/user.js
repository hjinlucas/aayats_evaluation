const userController = require("../controllers/userController");
const { verifiedAndAuthorized, verifiedToken } = require("../middleware/verifyToken");

const router = require("express").Router();


// UPDATE USER

router.put("/:id", verifiedAndAuthorized, userController.updateUser);


// DELETE USER

router.delete("/:id", verifiedAndAuthorized, userController.deleteUser);


module.exports = router