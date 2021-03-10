.PHONY: install
install:
	pip install coverage

.PHONY: uninstall
unittest: install
	coverage run --source tests -m unittest discover tests
	coverage report --precision=2
	coverage xml -o tests/coverage.xml
