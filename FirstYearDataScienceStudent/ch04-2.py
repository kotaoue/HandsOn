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

dice_1 = []
for i in range(10000):
    dice_1.append(random.randint(1, 6))
df = pd.DataFrame({"サイコロの目": dice_1})


df.hist(bins=6)
plt.title("サイコロを10000回振ったときの目の出現回数")
plt.xlabel("サイコロの目")
plt.xticks(range(1, 7))
plt.show()
