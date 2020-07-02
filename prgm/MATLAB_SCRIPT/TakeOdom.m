%Function to get the odometry coordinates
% tbot (object Turtlebot)

function P = TakeOdom(tbot)
    Pos = getOdometry(tbot);
    Pos.Position(3) = Pos.Orientation(1);
    Pos = Pos.Position;
    P(2) = -1000*Pos(1);
    P(1) = -1000*Pos(2);
    P(3) = Pos(3);
end