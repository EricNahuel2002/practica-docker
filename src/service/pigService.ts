import pigRepository from '../repository/pigRepository.js';

const getAllPigs = async () => {
  return pigRepository.findAll();
};

const createPig = async (data: { nombre: string; peso?: string | null }) => {
  return pigRepository.create(data);
};

export default { getAllPigs, createPig };
