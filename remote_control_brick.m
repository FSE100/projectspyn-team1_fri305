function r = remote_control_brick(brick)
    global key

    InitKeyboard()

    infinite = true;
    manualControl = false;

    while infinite
        if(key == 'e')
            manualControl = true;
        end

        if(manualControl == true)
        switch key
            case 'w'
                brick.StopMotor('A');
                brick.StopMotor('B');
                brick.MoveMotor('A',50);
                brick.MoveMotor('B',50);
            case 's'
                brick.StopMotor('A');
                brick.StopMotor('B');
                brick.MoveMotor('A',-50);
                brick.MoveMotor('B',-50);
            case 'a'
                brick.StopMotor('A');
                brick.StopMotor('B');
                brick.MoveMotor('A',-20);
                brick.MoveMotor('B',20);
            case 'd'
                brick.StopMotor('A');
                brick.StopMotor('B');
                brick.MoveMotor('A',20);
                brick.MoveMotor('B',-20);
            case 'p'
                manualControl = false;
            case 'shift'
                brick.StopMotor('A');
                brick.StopMotor('B');
            case 'c'
                brick.MoveMotor('D', 5);
                pause(0.5);
                brick.StopMotor('D');
            case 'v'
                brick.MoveMotor('D', -5);
                pause(0.5);
                brick.StopMotor('D');
            case 'q'
                brick.StopMotor('A');
                brick.StopMotor('B');
                infinite = false;
        end 
        end 
        pause(0.1);
    end
end 
