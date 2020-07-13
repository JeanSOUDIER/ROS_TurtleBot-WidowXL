function AdjustOrientation(A0, tbot)
    a = TakeOdom(tbot);
    Go([0 0 a(3)-A0], tbot);
end