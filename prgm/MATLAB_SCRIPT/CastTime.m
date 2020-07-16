%Fonction pour caster le temps pour la carte arduino du bras

function TimeC = CastTime(Time, Pos)
    TimeC = [];
    for i = 1:length(Time)
        %forme [NumBras1 LSB_temps1 MSB_temps1 ... NumBrasN LSB_tempsN
        %MSB_tempsN]
        TimeC = [TimeC mod(Pos(i),256) mod(Time(i),256) floor(Time(i)/256)];
    end
end