def solv_quadratic_equation(a, b, c):
    """ 2次方程式を解く  """
    D = (b**2 - 4*a*c) ** (1/2)
    x_1 = (-b + D) / (2 * a)
    x_2 = (-b - D) / (2 * a)

    return abs(x_1), abs(x_2)

if __name__ == '__main__':
    a =1
    b =input('input b: ')
    c =input('input c: ')

    print(solv_quadratic_equation.__doc__)
    x1, x2 = solv_quadratic_equation(float(a) , float(b) , float(c))

    print('x1:{}'.format(x1))
    print('x2:{}'.format(x2))
