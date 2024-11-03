import sys
import re
import os
from datetime import datetime

def slugify(text):
  """Converts a string to a slug."""

  text = text.lower()
  text = re.sub(r"[^a-zA-Z0-9\s-]", "", text)  # Remove special characters
  text = re.sub(r"\s+", "-", text)  # Replace whitespace with hyphens
  return text

def main():
  if len(sys.argv) < 2:
    print("Usage: python script.py <title>")
    sys.exit(1)

  title = sys.argv[1]
  slug = slugify(title)

  today = datetime.today().strftime("%Y-%m-%d")
  directory_name = f"{today}_{slug}"

  os.makedirs(directory_name, exist_ok=True)

  file_path = os.path.join(directory_name, "index.qml")
  with open(file_path, "w") as f:
    f.write(f"""---
title: {title}
slug: {slug}
date: {today}
date-modified: ""
description: ""
categories:
  -
draft: true
---
""")

if __name__ == "__main__":
  main()
