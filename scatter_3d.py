import pandas as pd
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# 读取数据
df = pd.read_csv("fiber_shape_descriptors.csv")

# 提取特征
x = df["length"]
y = df["span"]
z = df["volume"]
c = z  # 使用 volume 映射颜色

# 创建画布
fig = plt.figure(figsize=(8, 6))
ax = fig.add_subplot(111, projection='3d')

# 设置背景为黑色
fig.patch.set_facecolor('black')
ax.set_facecolor('black')

# 绘制散点图，使用 colormap 上色
sc = ax.scatter(x, y, z, c=c, cmap='viridis', s=5)

# 添加颜色条（colormap legend）
cb = fig.colorbar(sc, ax=ax, pad=0.1, fraction=0.03)
cb.set_label("volume", color='white', size='15')
cb.ax.yaxis.set_tick_params(color='white')
plt.setp(plt.getp(cb.ax.axes, 'yticklabels'), color='white')  # 刻度文字颜色

# 坐标轴标签设置为白色
ax.set_xlabel("length", color='white', size='15')
ax.set_ylabel("span", color='white', size='15')
ax.set_zlabel("volume", color='white', size='15')

# 坐标刻度设置为白色
ax.tick_params(colors='white')

# 标题
# ax.set_title("3D Scatter: length vs span vs volume", color='white')

# 白色网格线
ax.grid(color='white', linestyle=':', linewidth=0.5)

# 保存图像
plt.tight_layout()
plt.savefig("3d_scatter_colored_black.png", dpi=300)
plt.close()
