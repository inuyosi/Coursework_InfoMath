import numpy as np
import matplotlib.pyplot as plt

x = np.linspace(0, 5, 100)

y1 = 5 - 0.5*x
y2 =  8 - 2*x
y3 = np.zeros_like(x)

print(y1)

y4 = np.minimum(y1, y2)
plt.figure()
plt.plot(x, y1, label="x1+2x2 <= 10")
plt.plot(x, y2, label="2x1+x2<=8")
plt.fill_between(x, y3, y4, where=y4>y3, facecolor='yellow', alpha=0.3)
plt.ylim(0, 8.5)
plt.xlim(0, 4.5)
plt.legend(loc=0)

plt.show()