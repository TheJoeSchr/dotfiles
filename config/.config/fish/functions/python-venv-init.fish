function python-venv-init
python -m venv .venv && source ./.venv/bin/activate.fish 
python -m pip install -U pip wheel setuptools
end
