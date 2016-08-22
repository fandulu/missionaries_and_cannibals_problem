%% Missionaries and Cannibals Problem (Copyright (c) 2016, Fan Yang)

function [e L] = CM (n, cap) 

% [cost route] = CM (number of m&c pairs, capacity)

%% Initiallize state
% m(missionaries on left), c(cannibals on left), n(the number of m&c pairs) 
% Each row of I is a triple vector, [(#m on left), (#c on left), (boat left(0)/right(1))]
z = 1;
for m = 0:n
    for c = 0:n
        if (m~=0)
            if ((m>=c && (m-c)<1)||m==n) 
                I(z,:)=[m,c,0];
                z = z+1;
                if((m+c)~=2*n)
                I(z,:)=[m,c,1];
                z = z+1;
                end;
            end;
        else
            if (c~=0)
                I(z,:)=[m,c,0];
                z = z+1;
                I(z,:)=[m,c,1];
                z = z+1;
            else
                I(z,:)=[m,c,1];
                z = z+1;
            end   
        end 
    end
end

z = size(I,1);


%% Assign the possible actions
A = zeros(z,z);
for i = 1:z
    for j = 1:z
        MT = I(i,1)-I(j,1);% #mossionaries onboard
        CT = I(i,2)-I(j,2);% #cannibals onboard 
        boat_direction = I(i,3)-I(j,3);
        flag = 0;
        if (boat_direction<0) % boat to right
            if (MT>=0 && CT>=0) % left population decreased 
                flag =1;
            end;
        end;
        if (boat_direction>0) % boat to left
            if (MT<=0 && CT<=0) % left population increased
                flag =1; 
            end;
        end;
        if (boat_direction==0) % impossible action
            flag = 0;
        end;
        MT = abs(MT);
        CT = abs(CT);
        t = CT+MT;
        if   (MT>=CT || MT==0) && t<=cap && t>0 && flag 
                A(i,j) = 1+2*CT; % cost is given by 1+ 2*(number of cannibals on board)
        end;
    end;
end;


%% Dijkstra (From online open source code,Copyright (c) 2012, Dimas Aryo)
[e L] = dijkstra(A,1,z) % [cost route] = dijkstra(Graph, source, destination)

%% Draw policy

I(L,:)







        