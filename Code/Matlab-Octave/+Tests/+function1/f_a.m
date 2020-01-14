function f_alpha_value = f_a(idx,x,a,d)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% idx : indice de la fonction choisie
% x   : Xk
% a   : alpha
% d   : direction de descente dans Xk
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f = @Tests.function1.f;

xf = x + a.*d;
f_alpha_value = f(idx, xf);
end