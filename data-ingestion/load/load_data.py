import logging
import os
from sqlalchemy import create_engine
from sqlalchemy.exc import SQLAlchemyError
from dotenv import load_dotenv
from pathlib import Path
import pandas as pd

# Setup logging
logging.basicConfig(
    filename='/app/logs/load_data.log', 
    level=logging.INFO, 
    format='%(asctime)s - %(levelname)s - %(message)s'
)

# Load environment variables from .env file located in 'database/config'
env_path = Path(__file__).parent.parent / 'config' / '.env'
load_dotenv(dotenv_path=env_path)

# Fetching the environment variables
DB_USER = os.getenv('POSTGRES_USER')
DB_PASSWORD = os.getenv('POSTGRES_PASSWORD')
DB_HOST = os.getenv('POSTGRES_HOST')
DB_PORT = os.getenv('POSTGRES_PORT')
DB_NAME = os.getenv('POSTGRES_DB')

# Table name where data will be loaded
TABLE_NAME = "employees"

def load_data_to_postgres(df):
    """
    Load the DataFrame into PostgreSQL table.
    
    Parameters:
    df (pd.DataFrame): DataFrame to be loaded.
    """
    try:
        # Create a connection string
        engine = create_engine(f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}")
        
        # Load data into PostgreSQL
        df.to_sql(TABLE_NAME, engine, if_exists='replace', index=False)
        
        logging.info(f"Data loaded successfully into {TABLE_NAME} table.")
    except SQLAlchemyError as e:
        logging.error(f"Error loading data into PostgreSQL: {e}")
    except Exception as e:
        logging.error(f"Unexpected error: {e}")

if __name__ == "__main__":
    from extract.extract_data import extract_data

    data = extract_data()

    if not data.empty:
        load_data_to_postgres(data)
    else:
        logging.error("No data to load.")
