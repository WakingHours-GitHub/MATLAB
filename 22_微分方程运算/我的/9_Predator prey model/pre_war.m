% 战前
function dx = pre_war(t, x)
   dx = [
        x(1)*(0.7 - 0.1*x(2));
        x(2)*(-0.8 + 0.02*x(1))
   ];
end