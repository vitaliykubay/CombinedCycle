classdef HeatOut
% Given states before and after process heater find:
%   Qout  - total heat supplied
%   Sgen  - entropy generated
%   Xdest - exergy destroyed

properties (Constant)
    entropy_gen = @(state1, state2, Qout, Tout) ...
      PARAMS.MASS_FLOW * state1.mfrac * (state2.s - state1.s) + Qout/Tout;
    
    exergy_dest = @(state1, state2, Qout, Tout) ... 
      PARAMS.MASS_FLOW * state1.mfrac * (state1.psi - state2.psi) - ...
      (1 - PARAMS.DS_TEMP/Tout) * Qout;
end

methods (Static)
    function [res] = solve(state1, state2, Tout)
        res.Qout  = PARAMS.MASS_FLOW * state1.mfrac * (state1.h - state2.h);
        res.Sgen  = HeatX.entropy_gen(state1, state2, res.Qout, Tout);
        res.Xdest = HeatX.exergy_dest(state1, state2, res.Qout, Tout);
        res.Xheat = (1 - PARAMS.DS_TEMP/Tout) * res.Qout;
    end
end
    
end

