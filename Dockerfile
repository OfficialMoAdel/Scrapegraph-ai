FROM --platform=$TARGETPLATFORM python:3.11-slim

# Update packages and clean up to reduce image size
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

# Install ScrapegraphAI and its dependencies
RUN pip install --no-cache-dir scrapegraphai
RUN pip install --no-cache-dir scrapegraphai[burr]

# Install Playwright and its dependencies
RUN python3 -m playwright install-deps
RUN python3 -m playwright install

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Default command
CMD ["python", "-m", "scrapegraphai"]