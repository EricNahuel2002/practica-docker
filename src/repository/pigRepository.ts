import prisma from '../prisma.js';

const findAll = async () => {
  return prisma.cerdos.findMany();
};

const create = async (data: { nombre: string; peso?: string | null }) => {
  return prisma.cerdos.create({ data });
};

export default { findAll, create };
