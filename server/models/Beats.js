const mongoose = require("mongoose");

const BeatsSchema = new mongoose.Schema(
  {
    title: { type: String, required: true },
    likes: { type: Number, required: true },
    artists: [{ type: String, required: true }], // There can be multiple artists
    key: { type: String, required: true },
    bpm: { type: Number, required: true },
    price: { type: String, required: true },
    priceRaw: { type: Number, required: true },
    imageUrl: { type: String, required: true }, // URL to the image of the beat
    producerId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Beats", BeatsSchema);
