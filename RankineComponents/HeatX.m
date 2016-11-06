classdef HeatX
% Given states before and after heat exchange find:
%   Qin   - required heat input
%   sgen  - entropy generated
%   xdest - exergy destroyed
% 
% state1 - state before heat exchange (rankine cycle)
% state2 - state after heat exchange (rankine cycle)
% Tin    - Source temp.

properties (Constant)
    entropy_gen = @(state1, state2, Qin, Tin) ...
      PARAMS.MASS_FLOW * state1.mfrac * (state2.s - state1.s) - Qin/Tin;
    
    exergy_dest = @(state1, state2, Qin, Tin) ... 
      PARAMS.MASS_FLOW * state1.mfrac * (state1.psi - state2.psi) + ...
      (1 - PARAMS.DS_TEMP/Tin) * Qin;
end

methods (Static)
    function [res] = solve(state1, state2, Tin)
        res.Qin   = PARAMS.MASS_FLOW * state1.mfrac * (state2.h - state1.h);
        res.sgen  = HeatX.entropy_gen(state1, state2, res.Qin, Tin);
        res.xdest = HeatX.exergy_dest(state1, state2, res.Qin, Tin);
    end
end
    
end