import pandas as pd

def remove_dollar_signs(csv_file, output_file):

    df = pd.read_csv(csv_file)

    for col in df.columns:
        if df[col].dtype == 'object':

            df[col] = df[col].str.replace('$', '')


    df.to_csv(output_file, index=False)

remove_dollar_signs('001.csv', '002.csv')