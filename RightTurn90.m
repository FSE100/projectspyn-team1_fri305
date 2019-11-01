function R = RightTurn90(brick)

    % Right turn

    brick.MoveMotorAngleRel('A', 20, 173, 'Brake');
    brick.MoveMotorAngleRel('B', -20, 173 , 'Brake');
    brick.WaitForMotor('AB');
    R = true;
end 

