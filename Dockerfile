# Use an official Python runtime as the parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Poetry and dependencies
RUN apt-get update && apt-get install -y make \
    && pip install poetry \
    && poetry config virtualenvs.create false \
    && poetry install --no-dev

# Make port 5000 available to the world outside this container
EXPOSE 8081

# Run app.py when the container launches
CMD ["make", "run"]
