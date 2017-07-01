
clear;clc;

n=8;                    %��������
a=0.425;                %G/E��ֵ
I=0.007321892;          %����߾�
It=0.02023675;          %��Ť�߾�
b=1;                    %�������
l=6.2;                  %��������羶
r=pi^2*I*(b/l)^2/4/It/a;     %�նȲ���٤��
z11=2*(1+r);            %���򷽳�ϵ���������¼��ϵ��������ϵ��
z12=-(1-r);             %ϵ������ϵ��

k=zeros(n-1,n-1);     %ϵ�������ʼ��
for i=1:n-1
    for j=1:(n-1)
        if i==j
            k(i,j)=k(i,j)+z11;   %��ֵ��ϵ��
        elseif j==(i+1)          %�б��д�1
            k(i,j)=k(i,j)+z12;
            k(j,i)=k(i,j);
        end
    end
end


p=zeros(n-1,n);
%p(:,j):��Ӧ�ڵ�j�������򷽳��飬�ұ�һ��
for i=1:n
    if i==1
        p(1,i)=p(1,i)+(+1);
    elseif (i>1 && i<n)
        p(i-1,i)=p(i-1,i)+(-1);
        p(i,i)=p(i,i)+(+1);
    else    %���һ���
        p(i-1,i)=p(i-1,i)+(+1);
    end
end


g=k\p;
%g(:,j):���j���Ӱ��������Ҫ�ĸ���j

yita=zeros(n,n);    %yita(i,j)������������������ͳһ

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
