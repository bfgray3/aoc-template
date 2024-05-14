FROM gcc:13.2

RUN : \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends jq r-base python3-venv \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && :

WORKDIR /usr/src/aoc

COPY requirements.txt .

ENV PATH=/venv/bin:$PATH

ENV PYTHONUNBUFFERED 1

RUN : \
  && python3 -m venv /venv \
  && pip --no-cache-dir --disable-pip-version-check install --upgrade -r requirements.txt \
  && :
