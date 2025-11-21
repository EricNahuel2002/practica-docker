import { type Request, type Response } from 'express';
import pigService from '../service/pigService.js';

const listPigs = async (req: Request, res: Response) => {
  try {
    const pigs = await pigService.getAllPigs();
    return res.json(pigs);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Error retrieving pigs' });
  }
};

// Aquí se crea el cerdo con datos hardcodeados para pruebas
const createPig = async (req: Request, res: Response) => {
  try {
    const hardcoded = { nombre: 'Porky', peso: '42.50' };
    const created = await pigService.createPig(hardcoded);
    return res.status(201).json(created);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Error creating pig' });
  }
};

export default { listPigs, createPig };
