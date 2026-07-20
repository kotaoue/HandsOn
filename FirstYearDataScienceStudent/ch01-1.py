import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

sns.set_theme()
df = pd.DataFrame({"値段": [100, 120, 110, 130, 150]})
df.plot()
plt.title("値段の推移")
plt.show()
