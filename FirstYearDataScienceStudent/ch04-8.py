import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import scipy.stats as stats
from statsmodels.stats.power import TTestIndPower


def pretty_print(value):
    print("-" * 64)
    if isinstance(value, (pd.Series, pd.DataFrame)):
        print(value.to_string())
    else:
        print(value)


sns.set_theme()
plt.rcParams["font.family"] = "Hiragino Sans"

df = pd.DataFrame(
    {
        "暗記": [75, 82, 90, 30, 95, 100, 45, 70, 85, 20],
        "問題演習": [70, 80, 85, 25, 90, 95, 40, 65, 80, 15],
        "グループ学習": [80, 85, 95, 35, 100, 105, 50, 75, 90, 25],
    }
)

f_static, p_value = stats.f_oneway(df["暗記"], df["問題演習"], df["グループ学習"])

print(f"F統計量: {f_static:.4f}, p値: {p_value:.4f}")

if p_value < 0.05:
    print("学習方法によってテストの点数が変わる可能性が高いです")
else:
    print("学習方法によってテストの点数が変わる可能性は低いです")
