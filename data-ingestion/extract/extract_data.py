import pandas as pd
import logging
from pathlib import Path

# Setup logging
logging.basicConfig(
    filename='/app/logs/extract_data.log', 
    level=logging.INFO, 
    format='%(asctime)s - %(levelname)s - %(message)s'
)

# File path for the CSV file using pathlib
DATA_PATH = Path(__file__).parent.parent / 'data' / 'employee_performance.csv'  

def extract_data():
    """
    Extracts data from a CSV file and returns a pandas DataFrame.

    Returns:
        pd.DataFrame: Extracted data.
    """
    try:
        # Check if file exists
        if not DATA_PATH.exists():
            logging.error(f"File not found: {DATA_PATH}")
            return None

        # Read the CSV file into a DataFrame
        df = pd.read_csv(DATA_PATH)
        logging.info(f"Data extraction successful: {len(df)} rows extracted.")
        return df

    except Exception as e:
        logging.error(f"Error during data extraction: {e}")
        return None

if __name__ == "__main__":
    data = extract_data()

    if data is not None:
        # Preview the first few rows
        logging.info("Data preview:\n" + data.head().to_string())
    else:
        logging.error("Data extraction failed.")
