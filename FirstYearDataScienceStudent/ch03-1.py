import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns


def pritter(s):
    print("-" * 64)
    print(s)


sns.set_theme()
plt.rcParams["font.family"] = "Hiragino Sans"

data = {
    "年齢": [25, 30, 35, 40, 45, 50, 55, 60, 65, 70],
    "身長": [165, 170, 176, 168, 172, 178, 169, 173, 166, 171],
    "体重": [60, 60, 70, 75, 80, 85, 70, 75, 68, 72],
    "血圧": [110, 115, 120, 125, 130, 135, 140, 145, 130, 135],
    "性別": ["男", "女", "男", "女", "男", "女", "男", "女", "男", "女"],
    "運動頻度": ["高", "中", "低", "高", "中", "低", "高", "中", "低", "高"],
}
df = pd.DataFrame(data)
pritter(df.head())
pritter(df.describe())
pritter(df.min())
pritter(df.max())

fig, ax = plt.subplots(figsize=(10, 3))
ax.axis("off")
ax.table(
    cellText=df.head().values,
    colLabels=df.head().columns,
    loc="center",
)
plt.show()
