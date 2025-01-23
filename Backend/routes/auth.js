const express = require('express');
const { checkAccount } = require('../services/accountCheck');
const router = express.Router();

// Endpoint to check user accounts
router.post('/check-account', async (req, res) => {
  const { email } = req.body;
  if (!email) {
    return res.status(400).json({ error: 'Email is required' });
  }

  try {
    const accountStatus = await checkAccount(email);
    res.json(accountStatus);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Failed to check accounts' });
  }
});

module.exports = router;
