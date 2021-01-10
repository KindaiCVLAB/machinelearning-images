install:
	pip install coverage

unittest: install
	coverage run --source tests -m unittest discover tests
	coverage report --precision=2
	coverage xml -o tests/coverage.xml
