#!/bin/bash

pandoc -t revealjs \
    --template=template-revealjs.html \
    --from markdown-markdown_in_html_blocks+raw_html \
    --standalone \
    -V revealjs-url=https://revealjs.com \
    -V theme=moon \
    -V highlight=pygments \
    -V center=false \
    -V transition=convex \
    -o intro-to-graphql.html \
    intro-to-graphql.md


pandoc -t beamer intro-to-graphql.md -o intro-to-graphql.pdf
