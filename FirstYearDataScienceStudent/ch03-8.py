import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import StandardScaler


def pretty_print(value):
    print("-" * 64)
    if isinstance(value, (pd.Series, pd.DataFrame)):
        print(value.to_string())
    else:
        print(value)


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

scaler = StandardScaler()
normalized_data = scaler.fit_transform(df[["年齢", "身長", "体重", "血圧"]])
normalized_df = pd.DataFrame(normalized_data, columns=["年齢", "身長", "体重", "血圧"])

sns.boxplot(data=normalized_df)
plt.title("正規化されたデータの箱ひげ図")
plt.ylabel("標準化スコア")
plt.tight_layout()
plt.show()
