import re
from typing import Tuple

LABEL_REGEX = re.compile(r'(.*\.typ:\d+).*<(.*)::(.*)>')

def extract_labels_from_grep_output(line) -> Tuple[str, str, str, str]:
	"""
	Extract the file, prefix, label_without_prefix, and label from a line of grep output.

	Returns:
		(str, str, str, str): file, prefix, label_without_prefix, label
	"""
	matches = LABEL_REGEX.search(line)
	file, prefix, label_without_prefix = matches.groups()
	label = f"{prefix}::{label_without_prefix}"
	return file, prefix, label_without_prefix, label