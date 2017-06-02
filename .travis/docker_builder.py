#!/usr/bin/env python

import subprocess
import os

# tag to apply to images
tag = os.environ['TAG']

# list of directories that need to be watched for changes
dirs = [
  "blog_backend",
  "blog_ui",
  "golang",
  "mongodb",
  "mongodb_exported",
  "prometheus-grafana",
  "prometheus",
  "ruby",
  "ubuntu"
]

s = subprocess.check_output(['git', 'diff-tree', 'master', '--name-only','-m', '--pretty='])
changed_dirs = s.split('\n')

# print(changed_dirs)

changed_image_dirs = list(set(changed_dirs).intersection(dirs))
print(changed_image_dirs)

for d in changed_image_dirs:
  cmd = 'docker build -t express42/{}:{} {}'.format(d, tag, d)
  os.system(cmd)
