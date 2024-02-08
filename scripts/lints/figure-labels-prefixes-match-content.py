#!/usr/bin/env python3

import subprocess
import json
from pathlib import Path
import shlex
from multiprocessing import Pool, Queue
import os
import logging
import re

logging.basicConfig()
log = logging.getLogger(__name__)
log.setLevel(logging.INFO)

GET_LABELS = "grep -rn '<.*::.*>' ./*.typ"

fig_label_lines = subprocess.check_output(GET_LABELS, shell=True).decode('utf-8').strip('\n').split('\n')

FIG_KIND_PREFIXES = {
	'image': 'Figure',
	'table': 'Table',
	'req': 'Req',
	'usecase': 'UseCase',
	'userstory': 'UserStory',
}

def check_label_prefix_match(label_line):
	LABEL_REGEX = re.compile(r'<(.*)::(.*)>')
	matches = LABEL_REGEX.search(label_line)
	prefix, label_without_prefix = matches.groups()
	label = f"{prefix}::{label_without_prefix}"

	log.debug(f"checking label {label}")
	cmd = f"typst query main.typ \"<{label}>\" --one"
	try:
		fig = json.loads(subprocess.check_output(cmd, stderr=subprocess.PIPE, shell=True).decode('utf-8'))
	except subprocess.CalledProcessError as e:
		log.error(f"Figure {label} not found: subprocess failed {e}")
		return f"Figure {label} label not found"

	if fig['func'] != "figure":
		return

	if fig['kind'] not in FIG_KIND_PREFIXES:
		return
	expected_prefix = FIG_KIND_PREFIXES[fig['kind']]
	if prefix != expected_prefix:
		return f"Figure {label} label prefix '{prefix}' should be '{expected_prefix}' -- change the label to '<{expected_prefix}::{label_without_prefix}>'"

with Pool(os.cpu_count()) as pool:
	errors = pool.map(check_label_prefix_match, fig_label_lines)
	errors = list([e for e in errors if e])

if errors:
	print("Errors found:")
	for error in errors:
		print(error)
	os._exit(1)

