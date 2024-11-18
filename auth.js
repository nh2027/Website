const db = require('./db');

const loginUser = (req, res) => {
    const { IDNumber, Password } = req.body;

    const query = 'SELECT * FROM User WHERE IDNumber = ? AND Password = ?';
    db.execute(query, [IDNumber, Password], (err, results) => {
        if (err) {
            return res.status(500).send('Database error');
        }
        if (results.length > 0) {
            // Save session data
            req.session.user = { IDNumber, Name: results[0].Name, isAdmin: results[0].isAdmin };

            // Redirect to signed-in page
            res.redirect('/indexsigned');
        } else {
            res.status(401).send('Invalid username or password');
        }
    });
};

module.exports = { loginUser };
