import { render, screen } from '@testing-library/react';
import React from 'react';
import { CrudAdmin } from './CrudAdmin';
import '@testing-library/jest-dom';

describe('Pruebas en <CrudAdmin />', () => {
    
    test('debe renderizar el título del dashboard y el navbar correctamente', () => {
        // En lugar de <CrudAdmin />, usamos JavaScript puro:
        render(React.createElement(CrudAdmin));
        
        const titleElement = screen.getByText(/Despacho Dashboard/i);
        expect(titleElement).toBeInTheDocument();

        expect(screen.getByText(/Usuarios/i)).toBeInTheDocument();
    });

    test('debe tener la clase de fondo gris en el contenedor principal', () => {
        const { container } = render(React.createElement(CrudAdmin));
        const mainDiv = container.firstChild;
        
        expect(mainDiv).toHaveClass('bg-gray-50');
    });
});