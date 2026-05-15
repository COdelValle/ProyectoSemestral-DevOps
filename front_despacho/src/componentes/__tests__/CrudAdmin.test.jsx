import { render, screen } from '@testing-library/react';
import { CrudAdmin } from './CrudAdmin';

describe('Pruebas en <CrudAdmin />', () => {
    test('debe renderizar el título correctamente', () => {
        render(<CrudAdmin />);
        expect(screen.getByText(/Despacho Dashboard/i)).toBeInTheDocument();
    });
});