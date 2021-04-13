FROM public.ecr.aws/lambda/python:3.8

COPY Pipfile* .
RUN pip install pipenv \
  && pipenv install --ignore-pipfile --deploy --system

COPY index.py .

CMD ["index.handler"]
