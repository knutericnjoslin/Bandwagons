function [ C ] = go_cutoff( i_star, i_bar,  a, b, c, d)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

C = (i_star-i_bar)*(c + d*i_star) + i_bar*(a + b*i_star)- 7*i_star;

end

