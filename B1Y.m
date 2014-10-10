function [ B ] = B1Y( i , a, b)
%B1Y Benefit to type i when only agent of type i switches
%   Payoff is i in the original case. However, because we consider types
%   0.5, 1.5,...,9.5, but index by integers, we subtract 0.5 from each
%   payoff that depends on i

[B] = a + b*(i-0.5);

end

