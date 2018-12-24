load 7prob.mat y2 % 観測データ
t=linspace(0,100,2001); %観測値グラフ描画用時間ステップ
t2=linspace(0,200,4001);%推定値グラフ描画用時間ステップ
datasize=1999;

for k=1:1:datasize %データ数分だけループ
    if(k==1) x2=[0 0 y2(k,2) 0];
    elseif (k==2) x2=[y2(k-1,1) 0 0 y2(k-1,2)];
    else x2=[y2(k-1,1) y2(k-2,1) y2(k,2) y2(k-1,2)];
    endif
    if(k==1)
    X2=x2'; 
    else X2=[X2 x2']; % θ計算用の行列X2を作る
    endif
endfor
theta_hat = inv(X2*X2')*X2*y2(1:datasize,1) % θを一括計算
for(k=1:1:4000)
    if (k>2)
        u2 = u1;
        u1 =0;
        if (k<=2000) zeta = [y_hat(1) y_hat(2) u2 u1];
        else zeta = [y_hat(1) y_hat(2) 0 0];
        endif
        y_hat=[zeta*theta_hat y_hat];
    elseif (k==1)
        u1=1;
        zeta = [0 0 u1 0];
        y_hat =zeta*theta_hat;
    else
        zeta = [0 0 0 u1];
        y_hat =[zeta*theta_hat y_hat];
    endif
endfor
y2(:,1);
plot(t2(:,1:4000),y_hat(4000:-1:1), t(1:2000),y2(1:2000,1));