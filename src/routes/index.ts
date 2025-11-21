import express from 'express';
import pigsRouter from './pigs.js';

const router = express.Router();

router.use('/pigs', pigsRouter);

export default router;
