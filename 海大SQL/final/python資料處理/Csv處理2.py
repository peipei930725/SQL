import pandas as pd

def count_and_sort_strings(csv_file, output_file):

    df = pd.read_csv(csv_file)

    col = df.columns[0]

    df[col] = df[col].str.split('\n')

    counts = df[col].explode().value_counts()

    result = counts.reset_index().rename(columns={'index': 'string', col: 'frequency'})

    result = result.sort_values(by='count', ascending=False)

    result.to_csv(output_file, index=False)

count_and_sort_strings('uni_country.csv', 'uni_ranking.csv')
