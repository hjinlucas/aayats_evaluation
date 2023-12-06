const mongoose = require('mongoose');

const MixingSchema = new mongoose.Schema({
  name: { type: String, required: true },
  certification: { type: Boolean, default: false },
  specialty: { type: String, required: true },
  startingPrice: { type: Number, required: true },
  imageUrl: { type: String, required: true }, // URL to the image of the producer or service
  rating: { type: Number, required: true },
  numberOfReviews: { type: Number, required: true },
  producerId:{ 
    type:mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
},  {timestamps: true});

module.exports = mongoose.model('Mixing', MixingSchema);
