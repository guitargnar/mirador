.PHONY: install test clean help

help:
	@echo "Mirador AI Framework"
	@echo "==================="
	@echo "make install    Install dependencies and setup"
	@echo "make test       Run test suite"
	@echo "make clean      Clean temporary files"

install:
	./setup_mirador.sh

test:
	python -m pytest tests/

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	rm -rf .pytest_cache
	rm -rf htmlcov
	rm -rf .coverage
