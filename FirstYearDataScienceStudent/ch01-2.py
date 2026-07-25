import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

sns.set_theme()
plt.rcParams["font.family"] = "Hiragino Sans"

df = pd.DataFrame(
    {
        "値段": [100, 120, 110, 130, 150],
        "日付": pd.date_range("2023-01-01", periods=5),
        "販売数": [10, 15, 12, 20, 25],
    }
)

fig, ax_price = plt.subplots()
ax_sales = ax_price.twinx()

df.plot(
    x="日付",
    y="値段",
    ax=ax_price,
    marker="o",
    linestyle="-",
    color="green",
    legend=False,
)
ax_sales.bar(
    df["日付"],
    df["販売数"],
    width=0.8,
    color="blue",
    alpha=0.3,
    label="販売数",
)

ax_price.set_title("値段と販売数の推移")
ax_price.set_ylabel("値段")
ax_sales.set_ylabel("販売数")

lines = ax_price.get_lines() + ax_sales.get_lines()
labels = [line.get_label() for line in lines]
ax_price.legend(lines, labels, loc="upper left")

fig.autofmt_xdate()

plt.show()
