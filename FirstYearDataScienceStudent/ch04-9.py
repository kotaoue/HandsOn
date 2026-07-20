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
        "数学": [70, 40],
        "国語": [30, 60],
    },
    index=["男性", "女性"],
)

chi2, p_value, dof, expected = stats.chi2_contingency(df)

print(f"カイ二乗統計量: {chi2:.4f}, p値: {p_value:.4f}")

if p_value < 0.05:
    print("性別と得意な教科には関連がある可能性が高いです")
else:
    print("性別と得意な教科には関連がある可能性は低いです")
