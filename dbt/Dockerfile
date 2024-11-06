# Use official dbt Docker image
FROM ghcr.io/dbt-labs/dbt-postgres:latest

# Set the working directory
WORKDIR /dbt

# Copy your dbt project files to the container
COPY . .

# Install any additional Python dependencies if needed (Optional)
# RUN pip install -r requirements.txt

# Set the default entrypoint to `dbt`, allowing you to run `dbt` commands directly
ENTRYPOINT ["dbt"]

# Default command (this runs if no other command is specified)
CMD ["run"]
