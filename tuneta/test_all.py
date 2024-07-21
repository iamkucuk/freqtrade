# Importing the necessary libraries for tuning the indicators using TuneTA
import numpy as np
import pandas as pd
from pandas_ta import log_return, percent_return
from sklearn.model_selection import train_test_split

from freqtrade.configuration import Configuration
from freqtrade.data.history import load_pair_history
from freqtrade.enums import CandleType
from tuneta.tune_ta import TuneTA


# Customize these according to your needs.

# Initialize empty configuration object
# config = Configuration.from_files([])
# Optionally (recommended), use existing configuration file
config = Configuration.from_files(["user_data/config.json"])

# Define some constants
config["timeframe"] = "5m"
# Name of the strategy class
config["strategy"] = "SampleStrategy"
# Location of the data
data_location = config["datadir"]
# Pair to analyze - Only use one pair here
pair = "BTC/USDT"

candles = load_pair_history(
    datadir=data_location,
    timeframe=config["timeframe"],
    pair=pair,
    data_format="feather",  # Make sure to update this to your data
    candle_type=CandleType.SPOT,
)


X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, shuffle=False)

# Initializing TuneTA
tt = TuneTA(n_jobs=8, verbose=True)

# Fitting the model to tune all available indicators
tt.fit(
    X_train,
    y_train,
    indicators=["all"],
    ranges=[(4, 30)],
    trials=500,
    early_stop=100,
    min_target_correlation=0.05,
)

# Generating the report
report = tt.report(target_corr=True, features_corr=False)

# Transforming the dataset with the tuned indicators
features = tt.transform(X_train)

report, features.head()
