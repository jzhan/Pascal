uses crt;

var 
    panjang : integer = 20;
    lebar : integer = 10;
    x : integer = 20;
    y : integer = 10;
    i : integer = 1;

begin
    clrscr;

    while i < 5 do begin
        gotoxy(x, y);
        write('*');

        case i of
            1: begin
                    y := y - 1;

                    if (y = 2) then i := i + 1;
                end;
            2: begin
                    x := x - 1;

                    if(x = 2) then i := i + 1;
                end;
            3: begin
                    y := y + 1;

                    if(y = lebar) then i := i + 1;
                end;
            4: begin
                    x := x + 1;

                    if(x = panjang) then i := i + 1;
                end;
        end;

        delay(50);
    end;
end.
