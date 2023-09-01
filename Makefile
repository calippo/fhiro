health:
	curl http://0.0.0.0:8081/health

test-magic:
	curl -X POST http://0.0.0.0:8081/extract_fhir_objects -H "Content-Type: application/json" -d '{"text":"Momecort spray nasale 1 puff per narice 2 vv die fino al controllo tra 1 mese\nFlixotide 125 spray bronchiale 1 puff al mattino+ 1 puff alla sera (lava i denti) fino al controllo tra 1 mese\nSingulair 10 1 cp alla sera con lo schema precedente"}'

run:
	poetry run python app/app.py

install:
	poetry install

build:
	docker build -t fhiro .

tag:
	docker tag fhiro ghcr.io/calippo/fhiro:v1

push:
	docker push ghcr.io/calippo/fhiro:v1
