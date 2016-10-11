% Plot The Exact Solution Ue
% By plotting it edge by edge

figure();

for iedge=1:nedge
    
    % Find edge's first end point
    v1 = endpoints(iedge,1);
    x1 = xv(v1);
    y1 = yv(v1);
    
    % Find edge' second end point
    v2 = endpoints(iedge,2);
    x2 = xv(v2);
    y2 = yv(v2);
    
    % Medium Point
    xm = (x1+x2)/2;
    ym = (y1+y2)/2;
    
    % Compute uh on the edge
    ue1 = ue(x1,y1); % Ue in v1
    ue2 = ue(x2,y2); % Ue in v2
    uem = ue(xm,ym); % Ue in medium point between v1 and v2
    
    % Compute uh on the referement edge
    t = linspace(0,1,100); % Linspace sampling of the edge
    zt = polyval(polyfit([0 1/2 1],[ue1 uem ue2],2), t);
    
    % Compute the sampled coordinated on the actual edge
    xt = (1-t)*x1 + t*x2;
    yt = (1-t)*y1 + t*y2;
    
    % Plot uh on the whole edge    
    line(xt, yt, zt,'Color','b');
    
end

view(3);