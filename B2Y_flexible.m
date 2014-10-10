function [ B ] = B2Y( i , c, d)
%B2Y Benefit to type i when both switch
%   Payoff is i+2 in the original case. However, because we consider types
%   0.5, 1.5,...,9.5, but index by integers, we subtract 0.5 from each
%   payoff that depends on i

[B] = d*i + c - 0.5;

end

