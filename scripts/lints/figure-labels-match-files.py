#!/usr/bin/env python3

import subprocess
import json
from pathlib import Path
from multiprocessing import Pool, Queue
import os
import logging
import re
import lintutil
import sys

logging.basicConfig()
log = logging.getLogger(__name__)
log.setLevel(logging.INFO)

GET_LABELS = "grep -rn '<Figure::.*>' ./*.typ"
LABEL_REGEX = re.compile(r'(.*\.typ:\d+).*<(.*)::(.*)>')

fig_label_lines = subprocess.check_output(GET_LABELS, shell=True).decode('utf-8').strip('\n').split('\n')
errors = []

def check_all_labels_match_files(doc_head):
	cmd = f"typst query {doc_head} \"figure.where(kind: image)\""
	figs = json.loads(subprocess.check_output(cmd, shell=True).decode('utf-8'))
	for fig in figs:
		try:
			error = check_fig_label_match(fig)
		except Exception as e:
			error = f"Unexpected error: {e}"
		if error:
			errors.append(f"{doc_head}: {error}")

def check_fig_label_match(fig):
	if 'label' not in fig:
		return None

	label = fig['label'].strip('<>')
	if fig['kind'] != 'image':
		return f"Figure {label} label is not an image -- Only images should have the `Figure` prefix"
	if 'path' not in fig['body']:
		return None

	_, label_without_prefix = label.split('::')
	path = Path(fig['body']['path'])
	if path.stem != label_without_prefix:
		file = next((line for line in fig_label_lines if label_without_prefix in line), None)
		return f"Figure {label} label does not match file name {path.stem} (found in {file})"

docs = sys.argv[1:]

for doc in docs:
	check_all_labels_match_files(doc)

if errors:
	logging.error("Errors found:")
	for error in errors:
		logging.error(error)
	os._exit(1)

