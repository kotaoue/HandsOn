import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import random


def pretty_print(value):
    print("-" * 64)
    if isinstance(value, (pd.Series, pd.DataFrame)):
        print(value.to_string())
    else:
        print(value)


sns.set_theme()
plt.rcParams["font.family"] = "Hiragino Sans"

dice_50_avg = []
for i in range(10000):
    dice_50 = []
    for j in range(50):
        dice_50.append(random.randint(1, 6))
    dice_50_avg.append(sum(dice_50) / 50)
df = pd.DataFrame({"サイコロの目の平均": dice_50_avg})


df.hist(bins=20)
plt.title("サイコロを10000回振ったときの目の平均の分布")
plt.xlabel("サイコロの目の平均")
plt.show()
