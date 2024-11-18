const express = require('express');
const mysql = require("mysql");
const dotenv = require("dotenv");
const path = require('path');
const session = require('express-session');

dotenv.config({ path: './.env' });

const app = express();
const port = 5000;

// Middleware
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: true
}));

const db = mysql.createConnection({
    host: process.env.DATABASE_HOST,
    user: process.env.DATABASE_USER,
    password: process.env.DATABASE_PASSWORD,
    database: process.env.DATABASE
});

db.connect((error) => {
    if (error) {
        console.log(error);
    } else {
        console.log("MySQL has been connected");
    }
});

const publicDirectory = path.join(__dirname, './public');
app.use(express.static(publicDirectory));
app.set('view engine', 'hbs');

// Middleware to check if user is authenticated
function isAuthenticated(req, res, next) {
    if (req.session.user) {
        next();
    } else {
        res.redirect('/signin');
    }
}

// Routes
app.get("/", (req, res) => {
    console.log("Home route accessed");
    res.render("index");
});

app.get("/timetable", (req, res) => {
    res.render("timetable");
});

app.get("/signin", (req, res) => {
    res.render("signin", { error: null });
});

app.post("/signin", (req, res) => {
    const { IDNumber, password } = req.body;

    // Update table name to 'user'
    const query = 'SELECT * FROM user WHERE IDnumber = ? AND Password = ?';
    db.query(query, [IDNumber, password], (err, results) => {
        if (err) {
            console.error('Database error:', err);
            return res.render("signin", { error: "An error occurred. Please try again." });
        }

        if (results.length > 0) {
            // Successful login
            const user = results[0];
            req.session.user = user;
            return res.redirect("/indexsigned");
        } else {
            // Invalid credentials
            return res.render("signin", { error: "Invalid ID Number or password" });
        }
    });
});

app.get("/indexsigned", isAuthenticated, (req, res) => {
    res.render("indexsigned", { username: req.session.user.Name });
});

app.get("/logout", (req, res) => {
    req.session.destroy((err) => {
        if (err) {
            console.error('Logout error:', err);
        }
        res.redirect('/');
    });
});

// Club routes
const clubRoutes = [
    "chessclub", "gamingclub", "musicclub", "dramaclub",
    "debateclub", "fashionclub", "footballclub", "mediaclub", "basketballclub"
];

clubRoutes.forEach(club => {
    app.get(`/${club}`, (req, res) => {  // Removed `isAuthenticated` middleware
        // Query the member count for the specific club
        const clubQuery = 'SELECT MemberCount FROM club WHERE club_name = ?';  // Adjusted query based on your table and column names
        db.query(clubQuery, [club], (err, results) => {
            if (err) {
                console.error('Error fetching member count:', err);
                return res.render(club, { error: 'An error occurred. Please try again.' });
            }

            const memberCount = results[0] ? results[0].MemberCount : 0; // Default to 0 if no data is returned
            // Render the club page and pass the member count to it
            res.render(club, { memberCount });
        });
    });
});



app.listen(port, () => {
    console.log(`Server started on Port ${port}`);
});
