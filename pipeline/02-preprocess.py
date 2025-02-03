from sklearn.preprocessing import StandardScaler

import src
import src.load


def preprocess():
    df = src.load.raw_data()
    scaler = StandardScaler()
    df["y"] = scaler.fit_transform(df[["y"]])
    return df


if __name__ == "__main__":
    df = preprocess()
    df.to_parquet(src.PATH / "data/interim/interim.parquet")
