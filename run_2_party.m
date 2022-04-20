function [T, mu]  = run_2_party( mu0, para, t )
[T, mu] = ode45(@(T, x)two_party_de(x, para), t, mu0);
end
