const express = require('express');
const router = express.Router();
const { loginUser } = require('./auth');

router.post('/signin', loginUser);

module.exports = router;
