% Plot The Approximated Solution Uh
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
    
    % Compute uh on the edge
    uh1 = uh(v1); % Uh in v1
    uh2 = uh(v2); % Uh in v2
    uhm = uh(nver+iedge); % Uh in medium point between v1 and v2
    
    % Compute uh on the referement edge
    t = linspace(0,1,100); % Linspace sampling of the edge
    zt = polyval(polyfit([0 1/2 1],[uh1 uhm uh2],2), t);
    
    % Compute the sampled coordinated on the actual edge
    xt = (1-t)*x1 + t*x2;
    yt = (1-t)*y1 + t*y2;
    
    % Plot uh on the whole edge    
    line(xt, yt, zt,'Color','b');
    
end

title ('Approximated Solution On Edges');
view(3);