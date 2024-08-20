FROM gcc:14.2

RUN : \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends jq r-base python3-venv \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && :

WORKDIR /usr/src/aoc

ENV PATH=/venv/bin:$PATH PYTHONUNBUFFERED=1

COPY requirements.txt .

RUN : \
  && python3 -m venv /venv \
  && pip --no-cache-dir --disable-pip-version-check install --upgrade -r requirements.txt \
  && :
