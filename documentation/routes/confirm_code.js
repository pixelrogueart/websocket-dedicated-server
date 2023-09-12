/**
 * @swagger
 * /confirm_code:
 *   post:
 *     tags:
 *       - Database
 *     summary: Request the database an account confirmation.
 *     description: Request the database an account confirmation.
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
 *               code:
 *                 type: int
 *                 description: Code sent to the user's email
 *             required:
 *               - email
 *               - code
 *           example:
 *             email: user123@example.com
 *             code: 123456
 *     responses:
 *       200:
 *         description: Sucess.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *             example:
 *               message: 'Sucess message'
 *       400:
 *         description: Fail.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *             example:
 *               message: 'Error message'
 *       500:
 *         description: Fail.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *             example:
 *               message: 'Error message'
 */

router.post('/login', (req, res) => {
    res.json([
        { message: 'Email confirmed successfully.' },
    ]);
});
