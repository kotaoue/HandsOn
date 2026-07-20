import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from statsmodels.stats.power import TTestIndPower


def pretty_print(value):
    print("-" * 64)
    if isinstance(value, (pd.Series, pd.DataFrame)):
        print(value.to_string())
    else:
        print(value)


sns.set_theme()
plt.rcParams["font.family"] = "Hiragino Sans"


effect_size = 0.5
power = 0.8
alpha = 0.05

analysis = TTestIndPower()
sample_size = analysis.solve_power(effect_size=effect_size, power=power, alpha=alpha)
print(f"必要なサンプルサイズ: {sample_size:.2f}")
