function [] = cycle_analysis(obj)
% Overall rankine cycle analysis.

% total destroyed exergy
obj.total.xdest = sum([ ...
    obj.pump.xdest,     ...
    obj.turbine.xdest,  ...
    obj.openFWH.xdest,  ... 
    obj.procheat.xdest, ...
    obj.heatx.xdest,    ...
    obj.condenser.xdest]);

% total generated entropy
obj.total.xdest = sum([ ...
    obj.pump.sgen,      ...
    obj.turbine.sgen,   ...
    obj.openFWH.sgen,   ... 
    obj.procheat.sgen,  ...
    obj.heatx.sgen,     ...
    obj.condenser.sgen]);

% total work input
obj.total.Win = sum([obj.pump.win]);
obj.total.Win_rev = sum([obj.pump.win_rev]);

% total work output
obj.total.Wout = sum([obj.turbine.wout]);
obj.total.Wout_rev = sum([obj.turbine.wout_rev]);

% total heat input
obj.total.Qin = sum([obj.heatx.Qin]);

% total heat output
obj.total.Qout = sum([  ...
    obj.condenser.Qout, ... 
    obj.procheat.Qout]);

% overall second law efficiency
obj.total.eff2 = obj.total.Wout/obj.total.Wout_rev;

end

