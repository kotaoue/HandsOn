import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

sns.set_theme()
plt.rcParams["font.family"] = "Hiragino Sans"

df = pd.DataFrame(
    {"値段": [100, 120, 110, 130, 150], "日付": pd.date_range("2023-01-01", periods=5)}
)

ax = df.plot(x="日付", y="値段", marker="o", linestyle="-", color="green")
ax.set_title("値段の推移")

plt.show()
