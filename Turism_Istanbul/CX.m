function [y1,y2] = CX(x1,x2)
    s = numel(x1);
    y1=zeros(1,s);
    y2=zeros(1,s);
    t=find(x1==1);
    while (y1(t)==0)
      y1(t)=x1(t);
      t=find(x1==x2(t));
    end
    left=find(y1==0);
    y1(left)=x2(left);
    
    t=find(x2==1);
    while (y2(t)==0)
      y2(t)=x2(t);
      t=find(x2==x1(t));
    end
    left=find(y2==0);
    y2(left)=x1(left);
end