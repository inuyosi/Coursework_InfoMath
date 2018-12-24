time=linspace(0.00,2.0*pi,1001);
%theta_hat=[1.999984 -1 0  0.0040000]'; %  % ωT=0.004 00prob.mat
theta_hat=[1.9775 -1 0  0.14944]'; %  % ωT=0.15 10prob.mat
noise=0.02

for(k=1:1:2001)
   if k>2
      u2 = u1;
      u1 =0;
      n=[unifrnd(-noise,noise) n(1)];         % 白色雑音
      w=theta_hat(1)*n(1)+theta_hat(2)*n(2);  % 有色雑音(未利用)
      zeta = [y_hat(1) y_hat(2) u1 u2];
      y_hat=[zeta*theta_hat y_hat];           % グラフ描画用推定出力データ記録
      y1=[y_hat(1)+n(1) u1]';                 % 観測雑音として利用
      y2=[y2' y1]';
   elseif k==1
       u1=1;
      n=unifrnd(-noise,noise);
      w=theta_hat(1)*n+theta_hat(2)*0;
       zeta = [0 0 u1 0];
       y_hat =[zeta*theta_hat 0];
       y2=[y_hat(1)+n u1];
   else
	u2=u1;
        u1=0;
      n=[unifrnd(-noise,noise) n];
      w=theta_hat(1)*n(1)+theta_hat(2)*n(2);
      zeta = [y_hat(1) 0 u1 u2];
      y_hat=[zeta*theta_hat y_hat];           %グラフ描画用推定出力データ記録
      y1=[y_hat(1)+n(1) u1]';
      y2=[y2' y1]';

   endif
endfor
save "10prob_N.mat" y2
