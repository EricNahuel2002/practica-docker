import express, { type Request, type Response } from 'express';
import routes from './routes/index.js';

const app = express();
const port = 3000;

app.use(express.json());

app.use('/api', routes);


app.listen(port, () => {
	console.log(`Server listening on http://localhost:${port}`);
});
