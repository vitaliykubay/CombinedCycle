function [] = states_isn(obj)
% find isentropic rankine obj.states.isn

bisectp = PressureBisection(1e-6);      % Initialize with allowable error
bisectm = MassFractionBisection(1e-6);  % Initialize with allowable error

pump_enthalpy = @(state1, state2) state1.h + state1.v*(state2.p*100 - state1.p*100);


obj.states.isn(1).p = xsteam('psat_T', 30); % Tsat at 30 degC
obj.states.isn(1).x = 0;
obj.states.isn(1).h = xsteam('h_px', obj.states.isn(1).p, obj.states.isn(1).x);
obj.states.isn(1).s = xsteam('s_ph', obj.states.isn(1).p, obj.states.isn(1).h);
obj.states.isn(1).v = xsteam('v_ph', obj.states.isn(1).p, obj.states.isn(1).h);
obj.states.isn(1).t = xsteam('T_ph', obj.states.isn(1).p, obj.states.isn(1).h);

obj.states.isn(2).p = PARAMS.PROC_HEAT_PRES;  
obj.states.isn(2).h = pump_enthalpy(obj.states.isn(1), obj.states.isn(2));
obj.states.isn(2).s = xsteam('s_ph', obj.states.isn(2).p, obj.states.isn(2).h);
obj.states.isn(2).t = xsteam('T_ph', obj.states.isn(2).p, obj.states.isn(2).h);

obj.states.isn(12).p = obj.states.isn(2).p;
obj.states.isn(12).x = 0;
obj.states.isn(12).h = xsteam('h_px', obj.states.isn(12).p, obj.states.isn(12).x);
obj.states.isn(12).s = xsteam('s_ph', obj.states.isn(12).p, obj.states.isn(12).h);
obj.states.isn(12).t = xsteam('T_ph', obj.states.isn(12).p, obj.states.isn(12).h);

obj.states.isn(7).p = PARAMS.PEAK_PRES;
obj.states.isn(7).t = PARAMS.PEAK_TEMP;
obj.states.isn(7).h = xsteam('h_pT', obj.states.isn(7).p, obj.states.isn(7).t);
obj.states.isn(7).s = xsteam('s_pT', obj.states.isn(7).p, obj.states.isn(7).t);

obj.states.isn(10).p = obj.states.isn(1).p;
obj.states.isn(10).x = 0.90;
obj.states.isn(10).h = xsteam('h_px', obj.states.isn(10).p, obj.states.isn(10).x);
obj.states.isn(10).s = xsteam('s_ph', obj.states.isn(10).p, obj.states.isn(10).h);
obj.states.isn(10).t = xsteam('T_ph', obj.states.isn(10).p, obj.states.isn(10).h);

obj.states.isn(11).p = obj.states.isn(2).p;
obj.states.isn(11).s = obj.states.isn(10).s;
obj.states.isn(11).h = xsteam('h_ps', obj.states.isn(11).p, obj.states.isn(11).s);
obj.states.isn(11).t = xsteam('T_ph', obj.states.isn(11).p, obj.states.isn(11).h);

obj.states.isn(9).s = obj.states.isn(10).s;
obj.states.isn(9) = bisectp.set(obj.states.isn(9), 550, 3, 30).solve();

obj.states.isn(8).p = obj.states.isn(9).p;
obj.states.isn(8).s = obj.states.isn(7).s;
obj.states.isn(8).t = xsteam('T_ps', obj.states.isn(8).p, obj.states.isn(8).s);
obj.states.isn(8).h = xsteam('h_pT', obj.states.isn(8).p, obj.states.isn(8).t);

obj.states.isn(5).p = obj.states.isn(9).p;
obj.states.isn(5).x = 0;
obj.states.isn(5).h = xsteam('h_px', obj.states.isn(5).p, obj.states.isn(5).x);
obj.states.isn(5).s = xsteam('s_ph', obj.states.isn(5).p, obj.states.isn(5).h);
obj.states.isn(5).v = xsteam('v_ph', obj.states.isn(5).p, obj.states.isn(5).h);
obj.states.isn(5).t = xsteam('T_ph', obj.states.isn(5).p, obj.states.isn(5).h);

obj.states.isn(6).p = obj.states.isn(7).p;
obj.states.isn(6).h = pump_enthalpy(obj.states.isn(5), obj.states.isn(6));
obj.states.isn(6).s = xsteam('s_ph', obj.states.isn(6).p, obj.states.isn(6).h);
obj.states.isn(6).t = xsteam('T_ph', obj.states.isn(6).p, obj.states.isn(6).h);

obj.states.isn(3).p = obj.states.isn(2).p;
obj.states.isn(4).p = obj.states.isn(9).p;
[obj.states.isn, obj.mfrac.isn] = bisectm.set(obj.states.isn, PARAMS.FRAC_Z, 100, 1000).solve();
end








