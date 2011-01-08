function [sObjVal,x] = ReplicatorEq(A,x0)
sObjVal = eval_obj(A,x0);
sPreObjVal = -inf;
x = x0;
while (sObjVal-sPreObjVal>1.0e-5)
    x = x.*(A*x)./(x'*A*x);
    sPreObjVal = sObjVal;
    sObjVal = eval_obj(A,x);
end

function objVal = eval_obj(A,x)
objVal = x'*A*x;