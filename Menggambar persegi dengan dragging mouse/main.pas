uses crt, mouse, keyboard;

var 
    start_x: integer = 3;
    start_y: integer = 2;
    x : integer = 20;
    y : integer = 10;
    event : TMouseEvent;
    key : TKeyEvent;
                                                              // libc.so for Linux
function printf(mask : pchar) : integer; cdecl; varargs; external 'msvcrt.dll' name 'printf';

procedure draw();
var 
    i : integer = 1;
    temp, temp_start_x, temp_start_y, temp_x, temp_y : integer;
begin
    temp_start_x := start_x;
    temp_start_y := start_y;

    // swap if start_x > x
    if start_x > x then begin
        temp := start_x;
        start_x := x;
        x := temp;
    end;

    // swap if start_y < y
    if start_y > y then begin
        temp := start_y;
        start_y := y;
        y := temp;
    end;

    temp_x := x;
    temp_y := y;

    // clrscr;
    // writeln('start_X: ', start_x);
    // writeln('start_y: ', start_y);
    // writeln('x: ', x);
    // writeln('y: ', y);
    // writeln('temp_x: ', temp_x);
    // writeln('temp_y: ', temp_y);

    if (temp_x > 0) and (temp_y > 0) and (start_x <> x) and (start_y <> y) and (start_x < x) and (start_y < y) then begin
        clrscr;

        while i < 5 do begin
            gotoxy(x, y);

            case i of
                1: begin
                        printf('%c', chr(179));

                        if y = start_y then i := i + 1
                        else y := y - 1;
                    end;
                2: begin
                        if x = temp_x then printf('%c', chr(191))
                        else printf('%c', chr(196));

                        if x = start_x then i := i + 1
                        else x := x - 1;
                    end;
                3: begin
                        if y = start_y then printf('%c', chr(218))
                        else printf('%c', chr(179));

                        if y = temp_y then i := i + 1
                        else y := y + 1;
                    end;
                4: begin
                        if x = start_x then printf('%c', chr(192))
                        else if x = temp_x then printf('%c', chr(217)) 
                        else printf('%c', chr(196));

                        if x = temp_x then i := i + 1
                        else x := x + 1;
                    end;
            end;
        end;
    end;

    start_x := temp_start_x;
    start_y := temp_start_y;
end;

begin
    clrscr;

    writeln('Click and drag your mouse (from TOP LEFT to BOTTOM RIGHT) to draw a rectangle');
    writeln('Press ''q'' to exit');
    
    initMouse; // Initialize mouse driver
    initKeyboard; // Initialize keyboard driver

    while true do begin
        key := pollKeyEvent;

        if key <> 0 then // exit if 'q' is pressed
            if getKeyEventChar(translateKeyEvent(getKeyEvent)) = 'q' then break;

        if pollMouseEvent(event) then
        begin
            getMouseEvent(event);
            
            if event.buttons = mouseLeftButton then begin
                if event.action = mouseLeftButton then begin
                    start_x := getMouseX;
                    start_y := getMouseY; 

                // if mouse click and drag
                end else if event.action = 4 then begin
                    x := getMouseX;
                    y := getMouseY;

                    draw();

                    continue;
                end;
            end;
            
            // clear mouse event queue
            while event.buttons = 0 do begin
                if pollMouseEvent(event) = false then break;

                getMouseEvent(event);
            end;
        end;
        
        delay(50);
    end;

    doneMouse; // Deactivate mouse driver
    doneKeyboard; // Deactivate keyboard driver
end.
