# ライブラリ呼び出し
import pulp
import numpy as np
import matplotlib.pyplot as plt
import sys
import dual
import re

# 問題の定義
lp = pulp.LpProblem('lp', pulp.LpMaximize)
argvs = sys.argv  # コマンドライン引数を格納したリストの取得
argc = len(argvs) # 引数の個数
xa = np.linspace(0, 5, 1000)

# 変数の設定
x = pulp.LpVariable('x',lowBound=0)
y = pulp.LpVariable('y',lowBound=0)

# 評価関数の生成
dual0 = argvs[1] + " x + " + argvs[2] + " y"
lp += int(argvs[1])*x + int(argvs[2])*y

# 制約条件の生成
label1 = int(argvs[3])*x + int(argvs[4])*y
dual1 = argvs[3] + " x + " + argvs[4] + " y <= " + argvs[5]
lp += label1  <= int(argvs[5])

label2 = int(argvs[6])*x + int(argvs[7])*y
dual2 = argvs[6] + " x + " + argvs[7] + " y <= " + argvs[7]
lp += label2 <= int(argvs[8])

# 最適化問題の確認
print(lp)

# 求解
lp.solve()

# 結果の確認
print('x=',x.value())
print('y=',y.value())

# グラフ表示
y1 = int(argvs[5]) / int(argvs[4]) - (int(argvs[3]) / int(argvs[4])) * xa
y2 = int(argvs[8]) / int(argvs[7]) - (int(argvs[6]) / int(argvs[7])) * xa
y3 = np.zeros_like(xa)
y4 = np.minimum(y1, y2)
plt.figure()
plt.plot(xa, y1, label=label1)
plt.plot(xa, y2, label=label2)
plt.fill_between(xa, y3, y4, where=y4>y3, facecolor='yellow', alpha=0.3)
plt.ylim(0, 8.5)
plt.xlim(0, 4.5)
plt.legend(loc=0)
plt.show()

# 双対問題の表示
dualy = "max " + dual0 + "\n" + dual1 + "\n" + dual2 + "\nx >= 0 \ny >= 0"
dual_result = dual.dual(dualy)
print ("\ndual_data")
print (re.sub('\^T','',str(dual_result)))