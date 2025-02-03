from sklearn.preprocessing import StandardScaler


def preprocess(df, scale_y: bool = True):
    if scale_y:
        scaler = StandardScaler()
        df["y"] = scaler.fit_transform(df[["y"]])

    return df
