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
        "EatBreakfast": [75, 82, 90, 30, 95, 100, 45, 70, 85, 20],
        "NoBreakfast": [70, 80, 85, 25, 90, 95, 40, 65, 80, 15],
    }
)

t_static, p_value = stats.ttest_ind(df["EatBreakfast"], df["NoBreakfast"])

print(f"t統計量: {t_static:.4f}, p値: {p_value:.4f}")

if p_value < 0.05:
    print("朝ごはんを食べるとテストの点数が上がる可能性が高いです")
else:
    print("朝ごはんを食べるとテストの点数が上がる可能性は低いです")
