function f = Forward32(brick)
    % Forward 1 square length

    brick.MoveMotorAngleRel('AB', 40, 1170, 'Coast');
    brick.WaitForMotor('AB');
    
    f = true;
end 