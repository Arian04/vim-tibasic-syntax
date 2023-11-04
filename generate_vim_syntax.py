#!/usr/bin/env python3

import sys
import xml.etree.ElementTree as ET
import re
from time import strftime, gmtime


def generate_full_vim_syntax_file(tokens):
    file_content = ""

    # Start of file
    with open(PREPEND_FILE_NAME, "r") as file:
        file_content += file.read()
        file_content += "\n"

    # Generate keyword lists and highlight definitions
    keywords = ""
    for category, arr in tokens.items():
        keywords += generate_vim_syntax_group_definition(arr, category)

    highlights = generate_vim_highlight_definitions()

    # Add to file
    file_content += keywords + "\n" + highlights

    # Enable syntax at the end of file
    file_content += "\n"
    file_content += 'let b:current_syntax = "tibasic"'

    return file_content


def generate_vim_highlight_definitions():
    file_content = ""

    for category in ALL_CATEGORIES:
        # Find category's highlight group
        # TODO: remove this after I refactor the code to make the category's hold relevant info better
        category_highlight_group = None
        for group, array in HIGHLIGHT_GROUPS.items():
            # print(f"is {category} in {group}?") #DEBUG
            if category in array:
                category_highlight_group = group
                break

        file_content += f"hi def link {category} {category_highlight_group}"
        file_content += "\n"

    # intentionally leaving the trailing newline in here because otherwise the next line
    # will start on the end of this one. kinda obvious in hindsight but just leaving
    # this comment here for clarity

    return file_content


def generate_vim_syntax_group_definition(token_array, syntax_group):
    START = f"syn keyword {syntax_group} \t"
    special_output_lines = []
    normal_output_lines = []
    current_line = ""
    for token in token_array:
        # if token contains any vim-specific special chars, add it to the file in a different way
        # so that vim doesn't interpret it incorrectly
        special_chars = set("|'*~{}")
        if any((char in special_chars) for char in token):
            # escape single quotes so they dont mess with the ones in "syn match"
            token = token.replace("'", r"\'")

            # apparently unescaped tildes cause problems, so escape them here
            token = token.replace("~", r"\~")

            # escape brackets because I don't want them interpreted using their regex meaning
            token = token.replace("[", r"\[")
            token = token.replace("]", r"\]")

            special_output_lines.append(f"syn match {syntax_group} '{token}'")

            # skip to next iteration immediately so we don't put this token with the normal ones as well
            continue

        # Make another line when it gets too long
        if len(current_line) < 70:
            current_line += f"{token} "
        else:
            current_line = current_line[:-1]  # strip trailing space
            normal_output_lines.append(START + current_line)
            current_line = ""

    # Flush the current line to the array if it hasn't been already added
    if current_line != "":
        current_line = current_line[:-1]  # strip trailing space
        normal_output_lines.append(START + current_line)
        current_line = ""

    merged_output_lines = normal_output_lines + special_output_lines

    return "\n".join(merged_output_lines) + "\n"


def categorize_token_dict(token, tokens):
    # Determine type of token using hardcoded dictionary
    for category, token_array in TOKEN_TO_CATEGORY.items():
        if token in token_array:
            tokens[category].append(token)
            return True
        # else: Try next array

    # didn't match any dictionary entry
    return False


def categorize_token_regex(token, tokens):
    # Determine type of token using regexes
    for regex, category in REGEX_TO_CATEGORY.items():
        if re.match(regex + "$", token):
            tokens[category].append(token)
            return True
        # else: Try the next regex

    # didn't match any regex
    return False


def categorize_token(token, tokens):
    if categorize_token_dict(token, tokens):
        return
    elif categorize_token_regex(token, tokens):
        return
    else:
        # No match :(
        tokens[OTHER_CATEGORY].append(token)


def main():
    root = ET.parse(TOKENS_FILE_PATH).getroot()

    # create set of tokens to process
    all_tokens_to_process = set()
    for token in root.iter(TOKEN_CHAR_XML_TAG):
        token = str(token.text)
        token = token.strip()  # trim whitespace

        # Only categorize a token if it isn't excluded by these tests
        if token == "":  # empty string
            continue
        elif token in EXCLUDE_LIST:
            continue
        elif any(re.match(f"{regex}$", token) for regex in EXCLUDE_REGEXES):
            continue
        else:
            all_tokens_to_process.add(token)

    # Init token dictionary (each category : array of tokens in that category)
    tokens = {}
    for category in ALL_CATEGORIES:
        tokens[category] = []
    tokens[OTHER_CATEGORY] = []  # For the non-matches

    # Put every token into an array based on its category
    for token in all_tokens_to_process:
        categorize_token(token, tokens)

    # generate file contents
    file_contents = generate_full_vim_syntax_file(tokens)

    # prepend the file creation timestamp and git commit hash for script that generated this file
    commit_hash = None
    with open(".git/refs/heads/main", "r") as file:
        commit_hash = file.read().strip()

    timestamp = strftime("%Y-%m-%d %H:%M:%S", gmtime())

    prepend_lines = ""
    if commit_hash is not None:  # todo match regex
        prepend_lines += f'" File generated using script from commit hash {commit_hash}\n'
    if timestamp is not None:
        prepend_lines += f'" File generated at {timestamp} UTC\n'

    # Write vim syntax file
    with open(OUTPUT_FILE_NAME, "w") as file:
        if prepend_lines != "":
            file.write(prepend_lines)
            file.write('"\n')
        file.write(file_contents)

    print(f"Wrote vim syntax file to: {OUTPUT_FILE_NAME}")


if __name__ == "__main__":
    PREPEND_FILE_NAME = "tibasic-prepend.vim"
    OUTPUT_FILE_NAME = "tibasic.vim"

    TOKENS_FILE_PATH = "./tokens/8X.xml"
    TOKEN_CHAR_XML_TAG = "accessible"  # since the tokens I want are in <accessible>

    # TODO finish token mappings:

    # I determined the mappings of tokens to categories by:
    # - looking at them and just deciding
    # - referencing the subpages of http://tibasicdev.wikidot.com/variables

    # When writing regexes, remember:
    # - re.match will match the beginning by default (so don't use ^)
    # - my function already includes $ at the end (so don't use $)
    #
    # NOTE: some of these regexes aren't as accurate as they could be, because I don't need them
    #       to be perfect, since the token list I'm interpreting is pretty limited. That could
    #       lead to breakages in the future.
    REGEX_TO_CATEGORY = {
        r".*[\(]": "tiFunctions",  # foo(
        r"[\d]": "tiDigits",  # single digit
        # equation variables
        r"{Y[0-9]}": "tiYVars",  # variables: {Y1}, {Y6}, etc.
        r"{[XY][0-9]T}": "tiParametricVars",  # variables: {X1T}, {X6T}, {Y1T}, {Y6T}, etc.
        r"{r[0-9]}": "tiPolarVars",  # variables: {r1}, {r4}, etc.
        # FIXME: regexes below are broken
        r"[uvw]\(n\)": "tiSequentialVars",
        r"[uvw]\(n-1\)": "tiSequentialVars",
        r"[uvw]\(n-2\)": "tiSequentialVars",
        r"[uvw]\(n\+1\)": "tiSequentialVars",
        # graphing variables
        r"t()": "tiWindowVars",
        r"": "tiWindowVars",
        # misc variables
        r"[A-Z]": "tiLetters",  # capitalized letter (variable): A, B, F, etc.
        r"\[([a-zA-Z^/0-9]+)\]": "tiVariables",  # variables: [foo1], [bar6], [foo^2], [n/d] etc.
        r"L[0-9]": "tiListVars",  # variables: L1, L4, etc.
        r"Pic[0-9]": "tiPicVars",
        r"Image[0-9]": "tiImageVars",
        r"GDB[0-9]": "tiGraphDatabases",
        r"Str[0-9]": "tiStrings",
        # This just matches any token with one or more pipe chars ( | ) in it
        # Could've done a better set of regexes but only these vars contain the '|' char so it works fine
        r".*[|]+.*": "tiPipeVars",  # variables: [|a], [|b], |N, |P/Y, |<, etc.
        r"small(10|[L|T|0-9])": "tiSubscripts",
    }

    TOKEN_TO_CATEGORY = {
        "tiOperators": [
            # Relational
            "=",
            "<",
            ">",
            "<=",
            ">=",
            "!=",
            # Logical
            "and",
            "or",
            "xor",
            "not(",
            # Arithmetic
            # should these even be included in highlighting?
            "+",
            "-",
            "*",
            "/",
            "!",  # factorial
            # Assignment
            "->",
        ],
        "tiColors": [
            "BLUE",
            "RED",
            "BLACK",
            "MAGENTA",
            "GREEN",
            "ORANGE",
            "BROWN",
            "NAVY",
            "LTBLUE",
            "YELLOW",
            "WHITE",
            "LTGRAY",
            "MEDGRAY",
            "GRAY",
            "DARKGRAY",
        ],
        "tiConstants": [
            "theta",
            "pi",
            "alpha",
            "beta",
            "delta",
            "Delta",
            "lambda",
            "mu",
            "greek_pi",  # ?? is this like the letter pi rather than the constant pi ?
            "rho",
            "sigma",
            "Sigma",
            "Phi",
            "phat",
            "Omega",
            "chi",
            "gamma",
            "epsilon",
            "tau",
        ],
        "tiTrigFunctions": [
            # sin/sinh
            "sin",
            "sinh",
            "sin^-1",
            "sinh^-1",
            # cos/cosh
            "cos",
            "cosh",
            "cos^-1",
            "cosh^-1",
            # tan/tanh
            "tan",
            "tanh",
            "tan^-1",
            "tanh^-1",
        ],
        "tiFinanceVars": [
            "N",
            "I%",
            "PV",
            "PMT",
            "FV",
            "P/Y",
            "C/Y",
        ],
        "tiLoop": [
            "For(",
            "While",
            "Repeat",
        ],
        "tiConditional": [
            "If",
            "Then",
            "Else",
            "IS>(",
            "DS<(",
        ],
        "tiLabel": [
            "Lbl",
        ],
        "tiMiscStatement": [
            "Goto",
            "End",
        ],
        "tiUserInputCommand": [
            "Prompt",
            "Input",
        ],
        "tiMiscCommand": [
            "getKey",
        ],
    }
    OTHER_CATEGORY = "tiOther"

    ALL_CATEGORIES = set([*TOKEN_TO_CATEGORY.keys()] + [*REGEX_TO_CATEGORY.values()])

    # Since (I think) the token list contains everything you can send to the calculator, it also
    # includes lots of tokens that are unnecessary to consider when handling syntax highlighting
    #
    # I've separated them into logical chunks and sometimes included commented-out symbols with
    # reasons that they're commented-out as a reminder for myself so I don't accidentally exclude
    # important tokens
    #
    # NOTE:If a token is EXACTLY this, then it's excluded. NOT if it just contains one of these
    EXCLUDE_LIST = {
        ### Quotes
        '"',
        "'",
        "`",
        ### Brackets
        "[",
        "]",
        "(",
        ")",
        "{",
        "}",
        ### Number row symbols (on a standard US keyboard)
        # "!", # factorial
        "@",
        "#",
        "$",
        "%",
        "^",
        "&",
        # "*", # multiplication
        # "(", # already excluded above
        # ")", # already excluded above
        "_",
        # "+", # addition
        ### Misc symbols
        ",",
        ".",
        ":",
        ";",
        # "/", # division
        "\\",
        "?",
        "~",
    }

    # Same as the list above but (as you'd expect) contains regexes
    EXCLUDE_REGEXES = {
        # non-variable letters. not syntactically significant
        r"[a-zÀ-ÖØ-öø-ÿ]",
        # idk
        # r"",
    }

    # Declare what categories go in each highlight group
    HIGHLIGHT_GROUPS = {
        "Constant": [
            "tiConstants",
            "tiColors",
        ],
        "Number": [
            "tiDigits",
        ],
        "Identifier": [
            "tiLetters",
            "tiGraphDatabases",
            "tiVariables",
            "tiStrings",
            "tiPicVars",
            "tiImageVars",
            "tiPipeVars",
            "tiListVars",
            "tiPolarVars",
            "tiParametricVars",
            "tiYVars",
            "tiSequentialVars",
            "tiWindowVars",
            "tiFinanceVars",
        ],
        "Function": [
            "tiFunctions",
            "tiTrigFunctions",
        ],
        "Statement": [
            "tiUserInputCommand",
            "tiMiscCommand",
            "tiMiscStatement",
        ],
        "Conditional": [
            "tiConditional",
        ],
        "Repeat": [
            "tiLoop",
        ],
        "Label": [
            "tiLabel",
        ],
        "Operator": [
            "tiOperators",
        ],
        "Special": [
            "tiSubscripts",
        ],
    }

    # Check that all categories have been added to a highlight group
    # if not, exit and print error about it
    missing_categories = set({})
    present_categories = set({})
    duplicate_categories = set({})
    for category in ALL_CATEGORIES:
        found_it = False
        for highlighted_categories in HIGHLIGHT_GROUPS.values():
            if category in highlighted_categories:
                if category in present_categories:
                    # oh no! this category was already added, meaning it's in multiple highlight groups
                    duplicate_categories.add(category)
                else:
                    present_categories.add(category)
                    found_it = True
        if not found_it:
            missing_categories.add(category)

    if len(missing_categories) != 0 or len(duplicate_categories) != 0:
        # If there were categories missing highlight groups, throw error
        if len(missing_categories) != 0:
            missing_categories_str = ", ".join(missing_categories)
            print(f"ERROR: the following categories are MISSING highlight groups: {missing_categories_str}")
            print("This is a bug in the script")

        # If there were categories present in multiple highlight groups, throw error
        if len(duplicate_categories) != 0:
            duplicate_categories_str = ", ".join(duplicate_categories)
            print(
                "ERROR: the following categories are in MULTIPLE highlight groups:"
                f" {duplicate_categories_str}"
            )
            print("This is a bug in the script")

        sys.exit(1)
    main()
