const Beat = require("../models/Beats");
const CryptoJS = require("crypto-js");
require('dotenv').config();
const jwt = require('jsonwebtoken');


module.exports = {
    //Findall beats
    findAll: async (req, res) => {
        try {
            let beatsList = await Beat.find({})
            //return json with beatsList if query didn't return error
            res.status(200).json({status: true,success:beatsList});
        } catch (error) {
            res.status(400).json("ERROR");
            console.log(error, 'err---->');
            //next(error);
        }
    },
    
    
};
