import { render, screen } from '@testing-library/react';
import { CrudAdmin } from './CrudAdmin';
import '@testing-library/jest-dom';

describe('Pruebas en <CrudAdmin />', () => {
    
    test('debe renderizar el título del dashboard y el navbar correctamente', () => {
        render(<CrudAdmin />);
        
        // Verificar que el título del Navbar esté presente
        const titleElement = screen.getByText(/Despacho Dashboard/i);
        expect(titleElement).toBeInTheDocument();

        // Verificar que existan los enlaces de navegación
        expect(screen.getByText(/Usuarios/i)).toBeInTheDocument();
        expect(screen.getByText(/Productos/i)).toBeInTheDocument();
        expect(screen.getByText(/Configuración/i)).toBeInTheDocument();
    });

    test('debe tener la clase de fondo gris en el contenedor principal', () => {
        const { container } = render(<CrudAdmin />);
        const mainDiv = container.firstChild;
        
        // Verifica que se esté aplicando Tailwind correctamente (opcional)
        expect(mainDiv).toHaveClass('bg-gray-50');
    });
});