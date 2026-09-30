FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8080

WORKDIR /app

COPY requirements.txt requirements-gemini.txt ./
RUN pip install --no-cache-dir -r requirements.txt -r requirements-gemini.txt

COPY backend ./backend
COPY data ./data
COPY frontend ./frontend

# Seed at startup (not build time) so DEMO_PASSWORD never ends up in an image layer.
CMD python -m backend.app.seed && uvicorn backend.app.main:app --host 0.0.0.0 --port ${PORT}
