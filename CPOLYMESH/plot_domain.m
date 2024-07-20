
function plot_domain(domain)

Nsubs=length(domain.degrees);

for k=1:Nsubs

    if not(iscell(domain.intervals))
        dom_intvL=domain.intervals;
    else
        dom_intvL=domain.intervals{k};
    end

    if not(iscell(domain.functions))
        dom_functL=domain.functions;
    else
        dom_functL=domain.functions{k};
    end

    if not(iscell(domain.curve_types))
        dom_curveL=domain.curve_types;
    else
        dom_curveL=domain.curve_types{k};
    end


    t=linspace(dom_intvL(1),dom_intvL(end),1000);

    switch dom_curveL
        case {'polygon','spline'}
            ppx=dom_functL(1); ppy=dom_functL(2);
            xv=ppval(ppx,t); yv=ppval(ppy,t);
            zL=xv+1i*yv;
        otherwise
            zL=feval(dom_functL,t);
    end

    xv=zeros(1,length(zL)+1); yv=xv;
    xv(1:length(zL))=real(zL); yv(1:length(zL))=imag(zL);
    xv(length(xv))=xv(1); yv(length(yv))=yv(1);

    my_color=200*[1 1 1]/256;
    fill(xv,yv,my_color,'LineStyle','none');
    hold on;

end




