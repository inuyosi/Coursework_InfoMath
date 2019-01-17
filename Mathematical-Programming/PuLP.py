import numpy as np
from pulp import LpProblem, LpVariable, lpSum
A = np.array([[1, 0], [0, 1]])
b = np.array([1, 1])
c = np.array([1, 1])

# 主問題
primal_model = LpProblem(sense=LpMaximize)
x = [LpVariable(f'x{i}', lowBound=0) for i in range(2)]
primal_model += lpSum(c.T * x)
for row, rhs in  zip(A, b):
    primal_model += lpSum(row * x) <= rhs
