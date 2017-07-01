
clear;clc;

n=8;                    %主梁个数
a=0.425;                %G/E的值
I=0.007321892;          %抗弯惯矩
It=0.02023675;          %抗扭惯矩
b=1;                    %主梁宽度
l=6.2;                  %主梁计算跨径
r=pi^2*I*(b/l)^2/4/It/a;     %刚度参数伽马
z11=2*(1+r);            %正则方程系数矩阵（以下简称系数矩阵）主系数
z12=-(1-r);             %系数矩阵副系数

k=zeros(n-1,n-1);     %系数矩阵初始化
for i=1:n-1
    for j=1:(n-1)
        if i==j
            k(i,j)=k(i,j)+z11;   %赋值主系数
        elseif j==(i+1)          %列比行大1
            k(i,j)=k(i,j)+z12;
            k(j,i)=k(i,j);
        end
    end
end


p=zeros(n-1,n);
%p(:,j):对应于第j块板的正则方程组，右边一列
for i=1:n
    if i==1
        p(1,i)=p(1,i)+(+1);
    elseif (i>1 && i<n)
        p(i-1,i)=p(i-1,i)+(-1);
        p(i,i)=p(i,i)+(+1);
    else    %最后一块板
        p(i-1,i)=p(i-1,i)+(+1);
    end
end


g=k\p;
%g(:,j):求第j块板影响线所需要的各个j

yita=zeros(n,n);    %yita(i,j)含义与桥梁工程书上统一

for i=1:n
    for j=1:n     
        if i==j
            yita(i,j)=yita(i,j)+1;
        end
        if j==1
            yita(i,j)=yita(i,j)-g(j,i);
        elseif (j>1 && j<n)
            yita(i,j)=yita(i,j)+g(j-1,i)-g(j,i);
        else
            yita(i,j)=yita(i,j)+g(j-1,i);
        end
    end
end
