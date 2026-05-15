import { render, screen } from "@testing-library/react";
import { CrudAdmin } from "../CrudAdmin";
import "@testing-library/jest-dom";
import { expect, test, describe } from "vitest";

describe('Pruebas en <CrudAdmin />', () => {
    test('debe renderizar el título correctamente', () => {
        render(<CrudAdmin />);
        expect(screen.getByText(/Despacho Dashboard/i)).toBeInTheDocument();
    });
});