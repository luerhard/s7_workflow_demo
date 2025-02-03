import pandas as pd

import src


def raw_data():
    """Load raw data for analysis.

    Returns:
        pd.DataFrame: A dataframe with features and target (y). Target column is MedHouseVal.
    """

    features = pd.read_parquet(src.PATH / "data/raw/features.parquet")
    target = pd.read_parquet(src.PATH / "data/raw/target.parquet")
    target.columns = ["y"]

    df = pd.concat([features, target], axis=1)

    return df
