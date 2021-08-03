% take the absolute value of an array and scales it to [0,1]

function scu1 = scaleabs(u1)
scu1 = abs(u1)/max(max(abs(u1)));
end
