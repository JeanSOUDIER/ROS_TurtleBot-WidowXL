function P = TakeODOMros()
    sub = rossubscriber('/odom');
    pause(5);
    P = sub.LatestMessage.Pose.Pose.Position
end