/**
 * @swagger
 * /register:
 *   post:
 *     tags:
 *       - Database
 *     summary: Register a new user in the database. And sends a code to its email.
 *     description: Register a new user in the database. And sends a code to its email.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               username:
 *                 type: string
 *                 description: Username chosen by the user
 *               password:
 *                 type: string
 *                 description: Password chosen by the user
 *                 format: password
 *               email:
 *                 type: string
 *                 description: Email address of the user
 *                 format: email
 *             required:
 *               - username
 *               - password
 *               - email
 *           example:
 *             username: user123
 *             password: superPassword
 *             email: user123@example.com
*     responses:
 *       200:
 *         description: Sucess.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 action:
 *                   type: string
 *                 message:
 *                   type: string
 *             example:
 *               action: 'register_sucessful'
 *               message: 'Sucess message'
 *       500:
 *         description: Fail.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 action:
 *                   type: string
 *                 message:
 *                   type: string
 *             example:
 *               action: 'register_failed'
 *               message: 'Error message'
 */

router.post('/register', (req, res) => {
    res.json([
        { action: 'register_sucessful' },
        { message: 'User registered. Please check your email for the confirmation code.' },
    ]);
});
