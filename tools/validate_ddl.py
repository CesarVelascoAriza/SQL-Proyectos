#!/usr/bin/env python3
"""Simple DDL validator: checks for PKs and referenced tables in SQL files."""
import re
from pathlib import Path


def extract_tables(sql_text):
    # find CREATE TABLE <name>
    pattern = re.compile(r"CREATE\s+TABLE\s+(IF\s+NOT\s+EXISTS\s+)?[`\[]?([\w\.]+)[`\]]?", re.I)
    return [m.group(2) for m in pattern.finditer(sql_text)]


def has_primary_key(sql_text):
    return bool(re.search(r"PRIMARY\s+KEY", sql_text, re.I) or re.search(r"IDENTITY\(|GENERATED\s+ALWAYS", sql_text, re.I))


def referenced_tables(sql_text):
    return [m.group(1) for m in re.finditer(r"REFERENCES\s+[`\[]?([\w\.]+)[`\]]?", sql_text, re.I)]


def validate_file(path: Path):
    txt = path.read_text(encoding="utf-8")
    tables = extract_tables(txt)
    problems = []
    for t in tables:
        # extract block for table by naive split
        m = re.search(rf"CREATE\s+TABLE[^;]*?{re.escape(t)}[^;]*?(;|$)", txt, re.I | re.S)
        block = m.group(0) if m else ''
        if not has_primary_key(block):
            problems.append((t, 'missing_primary_key'))
        for ref in referenced_tables(block):
            # ensure ref exists in the file
            if ref not in tables and ref.lower() not in [x.lower() for x in tables]:
                problems.append((t, f'references_missing_table:{ref}'))
    return tables, problems


def main():
    root = Path(__file__).resolve().parents[1] / 'db-projects'
    sql_files = list(root.glob('**/schema/*.sql'))
    total_problems = 0
    for f in sql_files:
        tables, problems = validate_file(f)
        print(f"File: {f.relative_to(root)}")
        print(f"  Found tables: {', '.join(tables) if tables else '(none)'}")
        if problems:
            total_problems += len(problems)
            for p in problems:
                print(f"  Problem: table={p[0]} issue={p[1]}")
        else:
            print("  OK: primary keys and references appear present")
        print()
    if total_problems == 0:
        print("Validation completed: no obvious problems detected.")
    else:
        print(f"Validation completed: {total_problems} potential problems found.")


if __name__ == '__main__':
    main()
