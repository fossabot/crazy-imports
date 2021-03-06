install: lint
	( \
		. venv/bin/activate; \
		pip uninstall crazyimports -y; \
		python setup.py install; \
	)

install-dev:
	( \
		rm -rf venv; \
		python3 -m venv venv; \
		. venv/bin/activate; \
		pip install --upgrade pip; \
		pip install -r requirements-dev.txt; \
	)

lint:
	( \
		. venv/bin/activate; \
		python -m black .; \
	)

test: install
	( \
		. venv/bin/activate; \
		mkdir tests/test_data/generated/; \
		python tests/utils/init_data.py; \
		python -m pytest; \
		rm -rf tests/test_data/generated/; \
	)

build-package: 
	( \
		. venv/bin/activate; \
		python3 -m pip install --upgrade setuptools wheel; \
		python3 setup.py sdist bdist_wheel; \
		python3 -m pip install --upgrade twine; \
		python3 -m twine upload dist/* ; \
	)

prepare-docs:
	( \
		cp README.md docs/index.md; \
		cp CONTRIBUTING.md docs/contributing.md; \
	)

prepare-push: lint prepare-docs
