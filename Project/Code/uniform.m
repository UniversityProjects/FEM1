function [nver,nele,nedge,xv,yv,vertexmarker,vertices,edges,endpoints,edgemarker]=uniform(N,M)

switch nargin
    case 0
        N = 10;
        M = 10;
    case 1
        M = N;
end

nver = (N+1)*(M+1);
nele = 2*N*M;

xv = zeros(nver,1);
yv = zeros(nver,1);
vertexmarker = zeros(nver,1);
vertices = zeros(nele,3);

ug=inline('j*(N+1)+i+1','i','j','N');

for i=0:N
    for j=0:M

        iv = ug(i,j,N);

        xv(iv) = i/N;
        yv(iv) = j/M;
        
        if i==0 || i==N || j==0 || j==M
            vertexmarker(iv) = 1;
        else
            vertexmarker(iv) = 0;
        end
        
    end
end

for i=1:N
    for j=1:M
        q = (j-1)*N+i;
        iele1 = 2*q-1;
        iele2 = 2*q;
        
        vertices(iele1,1) = ug(i-1,j-1,N);
        vertices(iele1,2) = ug( i ,j-1,N);
        vertices(iele1,3) = ug(i-1, j ,N);
        
        vertices(iele2,1) = ug(i-1, j ,N);
        vertices(iele2,2) = ug( i ,j-1,N);
        vertices(iele2,3) = ug( i , j ,N);
    end
end

% edge

iedge = 0;

for j=0:M-1
    for i=1:N
        
        iv1 = ug(i,j,N);
        iv2 = ug(i-1,j,N);
        iedge = iedge+1;
        endpoints(iedge,1) = iv1;
        endpoints(iedge,2) = iv2;
        if j==0
            edgemarker(iedge) = +1;
        else
            edgemarker(iedge) = 0;
        end
        
        iv1 = ug(i,j,N);
        iv2 = ug(i-1,j+1,N);
        iedge = iedge+1;
        endpoints(iedge,1) = iv1;
        endpoints(iedge,2) = iv2;
        edgemarker(iedge) = 0;
        
        iv1 = ug(i,j,N);
        iv2 = ug(i,j+1,N);
        iedge = iedge+1;
        endpoints(iedge,1) = iv1;
        endpoints(iedge,2) = iv2;
        if i==N
            edgemarker(iedge) = +1;
        else
            edgemarker(iedge) = 0;
        end
    end
end

for j=0:M-1
    iv1 = ug(0,j,N);
    iv2 = ug(0,j+1,N);
    iedge = iedge+1;
    endpoints(iedge,1) = iv1;
    endpoints(iedge,2) = iv2;
    edgemarker(iedge) = +1;
end

for i=0:N-1
    iv1 = ug(i,M,N);
    iv2 = ug(i+1,M,N);
    iedge = iedge+1;
    endpoints(iedge,1) = iv1;
    endpoints(iedge,2) = iv2;
    edgemarker(iedge) = +1;
end

nedge = iedge;

for iele=1:nele
    for i=1:3
        switch i
            case 1
                ei = [vertices(iele,2) vertices(iele,3)];
            case 2
                ei = [vertices(iele,3) vertices(iele,1)];
            case 3
                ei = [vertices(iele,1) vertices(iele,2)];
        end
        for iedge=1:nedge
            v1 = endpoints(iedge,1);
            v2 = endpoints(iedge,2);
            if (v1==ei(1) && v2==ei(2)) || (v1==ei(2) && v2==ei(1))
                edges(iele,i) = iedge;
                break
            end
        end
    end
end

end