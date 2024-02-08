#!/usr/bin/env python3

import subprocess
import json
from pathlib import Path
import shlex
from multiprocessing import Pool, Queue
import os
import logging

logging.basicConfig()
log = logging.getLogger(__name__)
log.setLevel(logging.INFO)

GET_LABELS = "grep -rn '<Figure::.*>' ./*.typ"

fig_label_lines = subprocess.check_output(GET_LABELS, shell=True).decode('utf-8').strip('\n').split('\n')

def check_label_file_match(label_line):
	file, label = label_line.split(' ')
	label = label.replace('<', '').replace('>', '')
	log.debug(f"checking label {label}")
	cmd = f"typst query main.typ \"<{label}>\" --one"
	try:
		fig = json.loads(subprocess.check_output(cmd, stderr=subprocess.PIPE, shell=True).decode('utf-8'))
	except subprocess.CalledProcessError as e:
		log.error(f"Figure {label} not found: subprocess failed {e}")
		return f"Figure {label} label not found"
	if fig['kind'] != 'image':
		return f"Figure {label} label is not an image -- Only images should have the `Figure` prefix"
	if 'path' not in fig['body']:
		return None

	_, label_without_prefix = label.split('::')
	path = Path(fig['body']['path'])
	if path.stem != label_without_prefix:
		return f"Figure {label} label does not match file name {path.stem} (found at {file})"
	log.debug(f"Figure {label} label matches file name {path.stem}")

with Pool(os.cpu_count()) as pool:
	errors = pool.map(check_label_file_match, fig_label_lines)
	errors = list([e for e in errors if e])

if errors:
	print("Errors found:")
	for error in errors:
		print(error)
	os._exit(1)

