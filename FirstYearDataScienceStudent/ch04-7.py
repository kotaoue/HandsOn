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

plt.figure(figsize=(10, 6))
boxplot = df.boxplot(column=["EatBreakfast", "NoBreakfast"])
plt.title("朝ごはんを食べたグループと食べなかったグループのテストの点数の分布")
plt.ylabel("テストの点数")
plt.show
