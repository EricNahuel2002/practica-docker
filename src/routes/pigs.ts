import { Router, type Request, type Response } from 'express';
import pigController from '../controller/pigController.js';

const router = Router();

router.get('/', pigController.listPigs);
router.get('/create', pigController.createPig);

export default router;
