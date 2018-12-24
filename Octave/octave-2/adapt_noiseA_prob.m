%逐次最小ニ乗法によるパラメータ推定
load 7prob.mat y2
k=0;         %時間ステップ
y=[0 0 0];  %真の出力値
y_h=0;       %推定出力値
y_hat=0;    %推定出力記録
y_d=0;       %真の出力記録
y_n=0;       %真値+noiseの出力記録
e_k=0;       %信号相殺記録
u=[1 0];     %単位インパルス入力
theta=[0 0 0]';  %推定パラメータ（係数）
theta_dot=[0 0 0]';%推定パラメータ更新用中間変数
lambda=100.0;   %最小二乗法設定パラメータ
gamma=lambda.*[1 0 0;0 1 0;0 0 1]; %共分散行列
t=linspace(1,199,2001);            %グラフ描画用時間ステップ

for k=1:1:2001 %データ数分だけループ
   if k>1
     theta(:,k)=theta_dot(1:3);               %係数データ記録
      y_hat=[y_hat x*theta(1:3,k)];               %グラフ描画用推定出力データ記録
      y_noise=y2(k,1)+noise;
      y_d=[y_d y2(k,1)];    %グラフ描画用出力真値データ記録
      y_n=[y_n y_noise];
      e_k=[e_k e];                                    %グラフ描画用信号相殺データ記録
   endif
   noise=unifrnd(-4.0,4.0);
   x = [y(1) y(2) u(2)];
   u=[0 u];
   y =[ y2(k,1) y]; %実際のy(n)を計算
   y_h=[x*theta(1:3,k) y_h]; 
   e = y(1)+noise-y_h(1); %推定誤差を計算
   gamma=gamma-gamma*x'*x*gamma/(1+x*gamma*x');%共分散行列
   theta_dot(1:3) = theta_dot(1:3)+gamma*x'*e/(1+x*gamma*x');%パラメータ更新則
endfor
theta_dot(1:3)
subplot(3,1,1) 
%plot(t,y_hat,'linewidth',4,t,y_d,'linewidth',4,t,y_n,'linewidth',3); %真のシステム出力と推定出力とを比較
plot(t,y_hat,'linewidth',4,t,y_d,'linewidth',4); %真のシステム出力と推定出力とを比較
%plot(t,y_n,'linewidth',3); %真のシステム出力と推定出力とを比較
subplot(3,1,2) 
plot(t,theta(1,:),t,theta(2,:),t,theta(3,:));%推定パラメータの推移
subplot(3,1,3) 
plot(t,e_k,'-'); %分離したノイズ信号