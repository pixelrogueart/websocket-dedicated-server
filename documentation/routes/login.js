/**
 * @swagger
 * /login:
 *   post:
 *     tags:
 *       - Database
 *     summary: Request the database if the account exists.
 *     description: Request the database if the account exists, if it does, retrieves the username. If it doesn't or the email is not active, retrieves an error message.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *                 description: Email address of the user
 *                 format: email
 *               password:
 *                 type: string
 *                 description: Password chosen by the user
 *                 format: password
 *             required:
 *               - email
 *               - password
 *           example:
 *             email: user123@example.com
 *             password: superPassword
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
 *               action: 'login_sucessful'
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
 *               action: 'login_failed'
 *               message: 'Error message'
 */

router.post('/login', (req, res) => {
    res.json([
        { action: 'login_sucessful' },
        { message: 'Logged in successfully!' },
        { username: 'user123' },
    ]);
});
