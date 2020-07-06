function y = Forward(W1, W2, W3, x)

v1 = W1*x;
y1 = max(0,v1);

v2 = W2*y1;
y2 = max(0,v2);

v3 = W3*y2;
y3 = max(0,v3);

y = 1 ./ (1 + exp(-y3));

% v1 = W1*x;
% y1 = max(0,v1);
% 
% v2 = W2*y1;
% y2 = max(0,v2);
% 
% v3 = W3*y2;
% y = 1 ./ (1 + exp(-v3));
end