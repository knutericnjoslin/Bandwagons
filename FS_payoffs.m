function [ B ] = payoff( i, a, b, c ,d)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% B(1) = B_i(1,Y) = a + b*i
% B(2) = B_i(2,Y) = c + d*i
% B(3) = B_i(1,X) = e
% B(4) = B_i(2,X) = f

B(1) = a + b*i;
B(2) = c + d*i;
B(3) = 5;
B(4) = 7;

end

