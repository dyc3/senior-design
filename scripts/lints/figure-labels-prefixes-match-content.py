#!/usr/bin/env python3

import subprocess
import json
from pathlib import Path
import shlex
from multiprocessing import Pool, Queue
import os
import logging
import re
import lintutil
import sys

logging.basicConfig()
log = logging.getLogger(__name__)
log.setLevel(logging.INFO)

GET_LABELS = "grep -rn '<.*::.*>' ./*.typ"
FIG_KIND_PREFIXES = {
	'image': 'Figure',
	'table': 'Table',
	'req': 'Req',
	'usecase': 'UseCase',
	'userstory': 'UserStory',
}

fig_label_lines = subprocess.check_output(GET_LABELS, shell=True).decode('utf-8').strip('\n').split('\n')
errors = []

def check_all_labels_prefix_match(doc_head):
	cmd = f"typst query {doc_head} \"figure.where(kind: image)\""
	figs = json.loads(subprocess.check_output(cmd, shell=True).decode('utf-8'))
	for fig in figs:
		try:
			error = check_fig_label_prefix_match(fig)
		except Exception as e:
			error = f"Unexpected error: {e}"
		if error:
			errors.append(f"{doc_head}: {error}")

def check_fig_label_prefix_match(fig):
	if 'label' not in fig:
		return None
	label = fig['label'].strip('<>')
	prefix, label_without_prefix = label.split('::')

	if fig['func'] != "figure":
		return

	if fig['kind'] not in FIG_KIND_PREFIXES:
		return
	expected_prefix = FIG_KIND_PREFIXES[fig['kind']]
	if prefix != expected_prefix:
		file = next((line for line in fig_label_lines if label_without_prefix in line), None)
		return f"Figure {label} label prefix '{prefix}' should be '{expected_prefix}' -- change the label to '<{expected_prefix}::{label_without_prefix}>' (found at {file})"

docs = sys.argv[1:]

for doc in docs:
	check_all_labels_prefix_match(doc)

if errors:
	logging.error("Errors found:")
	for error in errors:
		logging.error(error)
	os._exit(1)

