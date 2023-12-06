const mongoose = require('mongoose');

const StudioSchema = new mongoose.Schema({
  name: { type: String, required: true },
  distance: { type: Number, required: true }, // The distance is in miles
  session: {
    hours: { type: Number, required: true },
    booth: { type: String, required: true },
    hourlyRate: { type: Number, required: true } // This is the rate per hour
  },
  totalBeforeTaxes: { type: Number, required: true },
  imageUrl: { type: String, required: true }, // URL to the image of the studio
  available: { type: Boolean, default: true },
  rating: { type: Number, required: true },
  numberOfReviews: { type: Number, required: true },
  agentId:{ 
    type:mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },

},  {timestamps: true});

module.exports = mongoose.model('Studio', StudioSchema);
