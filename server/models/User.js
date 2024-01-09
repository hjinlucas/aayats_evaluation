const mongoose = require("mongoose");

const UserSchema = new mongoose.Schema(
    {
        username:{type: String, required: true, unique: true},
        email:{type: String, requirde: true, unique: true},
        password:{type: String, required: true},
        location:{type: String, required: false},
        isCertified:{type: Boolean, default: false},//Certified user can have certification label
        isAgent:{type: Boolean, default: false},//Agent user can upload their studios for rent
        profile:{type: String, required: false},
    },  {timestamps: true}
)

//findByIdAndUpdate

module.exports = mongoose.model("User", UserSchema)