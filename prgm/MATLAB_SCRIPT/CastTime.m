function TimeC = CastTime(Time, Pos)
    TimeC = [];
    for i = 1:length(Time)
        TimeC = [TimeC mod(Pos(i),256) mod(Time(i),256) floor(Time(i)/256)];
    end
end