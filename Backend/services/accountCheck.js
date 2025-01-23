const checkAccount = async (email) => {
    // Mock response: Replace with actual API calls in the future
    return {
      spotify: email.endsWith('@spotify.com'),
      youtube: email.endsWith('@gmail.com'),
      netflix: email.endsWith('@netflix.com'),
      prime: email.endsWith('@amazon.com'),
      sonyLIV: email.endsWith('@sonyliv.com'),
    };
  };
  
  module.exports = { checkAccount };
  