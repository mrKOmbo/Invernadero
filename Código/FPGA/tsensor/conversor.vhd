LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY conversor IS
    PORT(
        VALOR_IN: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        D,U: OUT INTEGER RANGE 0 TO 9
    );
END ENTITY conversor;

ARCHITECTURE BEAS OF conversor IS
    SIGNAL T : INTEGER RANGE 0 TO 255;
BEGIN
    -- Proceso para calcular valor
    PROCESS (VALOR_IN)
    BEGIN
        T <= TO_INTEGER(unsigned(VALOR_IN));
    END PROCESS;

    -- Decodificación de Vm_scaled para obtener unidades y decenas
    U <= T mod 10;
    D <= (T / 10) mod 10;

END ARCHITECTURE BEAS;
