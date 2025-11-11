#!/usr/bin/env bash
find . -type f -name '*.nix' -exec nixfmt {} +
