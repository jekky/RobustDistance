function A = DynAffniMatrix(corres_score,corres_x,corres_y)

A = zeros(size(corres_score,1),size(corres_score,1));


for i = 1 : size(corres_score,1)
    for j = 1 : size(corres_score,1)
        if (i~=j)
            
            x_consist = (corres_x(i,1)-corres_x(j,1))*(corres_x(i,2)-corres_x(j,2));
            y_consist = (corres_y(i,1)-corres_y(j,1))*(corres_y(i,2)-corres_y(j,2));
            dist1 = sqrt((corres_x(i,1)-corres_x(j,1))^2+(corres_y(i,1)-corres_y(j,1))^2);
            dist2 = sqrt((corres_x(i,2)-corres_x(j,2))^2+(corres_y(i,2)-corres_y(j,2))^2);
            dist3 = sqrt((corres_x(i,1)-corres_x(i,2))^2+(corres_y(i,1)-corres_y(i,2))^2);
            dist4 = sqrt((corres_x(j,1)-corres_x(j,2))^2+(corres_y(j,1)-corres_y(j,2))^2);
            
            if (x_consist>0) && (y_consist>0)
                A(i,j)=exp(-(dist3)^2)*exp(-(dist4)^2)*corres_score(i)*corres_score(j);
            else
                A(i,j)=0;
            end
        end
    end
end

%A = A./sum(sum(A));