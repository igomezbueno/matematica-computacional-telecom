function y_filt = suavizado5(x)
  N = length(x);
  y_filt = x;
  for k = 3:N-2
    y_filt(k) = (x(k-2) + x(k-1) + x(k) + x(k+1) + x(k+2))/5;
  end
end
