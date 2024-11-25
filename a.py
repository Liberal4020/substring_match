import matplotlib.pyplot as plt
import numpy as np

# 2019年の東京の最高気温 (h) と最低気温 (l) の月ごとの平均
X = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
H = [10.3,11.6,15.4,19.0,25.3,25.8,27.5,32.8,29.4,23.3,17.7,12.6]
L = [1.4,3.3,6.2,9.2,15.3,18.5,21.6,25.2,21.7,16.4,9.3,5.2]

fig, ax = plt.subplots()
ax.plot(X, H)
plt.show()