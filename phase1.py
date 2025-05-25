# %%
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error
from sklearn.model_selection import GridSearchCV
import joblib
import os

# Create charts directory if it doesn't exist
os.makedirs('charts', exist_ok=True)

# %%
# Step 1: Data Collection and Initial Analysis
df = pd.read_csv('Social Meida Dataset.csv')
print("\n=== Initial Dataset Info ===")
print(df.info())

# %%
# Exploratory Data Analysis (EDA)
print("\n=== Basic Statistics ===")
print(df.describe())
df.head()
df.tail()

# %%
# Check for missing values
print("\n=== Missing Values Analysis ===")
missing_data = df.isnull().sum()
missing_percentage = (missing_data / len(df)) * 100
missing_info = pd.DataFrame({
    'Missing Values': missing_data,
    'Percentage': missing_percentage
})
print(missing_info)

# %%
# Distribution of numerical variables
numerical_cols = ['Age', 'Income (USD)', 'Social Media Usage (Hours/Day)']
plt.figure(figsize=(15, 5))
for i, col in enumerate(numerical_cols, 1):
    plt.subplot(1, 3, i)
    sns.histplot(data=df, x=col, kde=True)
    plt.title(f'Distribution of {col}')
plt.tight_layout()
plt.savefig('charts/numerical_distributions.png')
plt.show()

# %%
# Box plots for numerical variables by gender
plt.figure(figsize=(15, 5))
for i, col in enumerate(numerical_cols, 1):
    plt.subplot(1, 3, i)
    sns.boxplot(data=df, x='Gender', y=col)
    plt.title(f'{col} by Gender')
plt.tight_layout()
plt.savefig('charts/numerical_by_gender.png')
plt.show()

# %%
# Categorical variables analysis``
categorical_cols = ['Gender', 'Education Level', 'Influence Level', 'City', 'Product Category']
plt.figure(figsize=(20, 15))
for i, col in enumerate(categorical_cols, 1):
    plt.subplot(2, 3, i)
    value_counts = df[col].value_counts()
    if len(value_counts) > 10:  # For cities, show top 10
        value_counts = value_counts.head(10)
    sns.barplot(x=value_counts.values, y=value_counts.index)
    plt.title(f'Distribution of {col}')
    plt.tight_layout()
plt.savefig('charts/categorical_distributions.png')
plt.show()

# %%
# Correlation analysis
plt.figure(figsize=(10, 8))
correlation_matrix = df[numerical_cols].corr()
sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm', center=0)
plt.title('Correlation Matrix')
plt.tight_layout()
plt.savefig('charts/correlation_matrix.png')
plt.show()
# %%
