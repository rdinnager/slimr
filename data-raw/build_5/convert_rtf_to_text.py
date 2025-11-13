#!/usr/bin/env python3
"""
Convert RTF files to plain text using Python's striprtf package.
This is a fallback when R's striprtf package has issues.
"""

import sys

def convert_rtf_to_text(rtf_file, output_file):
    try:
        from striprtf.striprtf import rtf_to_text
    except ImportError:
        print("Error: striprtf package not found")
        print("Install with: pip install striprtf")
        sys.exit(1)

    try:
        with open(rtf_file, 'r', encoding='utf-8', errors='ignore') as f:
            rtf_content = f.read()

        text = rtf_to_text(rtf_content)

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(text)

        print(f"Converted {rtf_file} -> {output_file}")
        print(f"Output size: {len(text)} characters")

    except Exception as e:
        print(f"Error converting {rtf_file}: {e}")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python convert_rtf_to_text.py input.rtf output.txt")
        sys.exit(1)

    convert_rtf_to_text(sys.argv[1], sys.argv[2])
