function C = color_pick_up_drop_off(brick)
    brick.SetColorMode(2,2);

    color = brick.ColorCode(2);
    % Blue/Pickup
    if color == 2
      brick.StopMotor('A');
      brick.StopMotor('B');
      remote_control_brick(brick);
    end
    % Green/Dropoff
    if color == 3
      brick.StopMotor('A');
      brick.StopMotor('B');
      remote_control_brick(brick);
    end
    C = color;
end