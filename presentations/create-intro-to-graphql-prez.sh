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

#pandoc -t html5 -s --template=template.revealjs.html --standalone --section-divs --variable theme="sky" -o slides.html slides.md

# pandoc -t html5 \
#     --from markdown-markdown_in_html_blocks+raw_html \
#     --standalone \
#     -V revealjs-url=https://revealjs.com \
#     -V theme=moon \
#     -V highlight=pygments \
#     -V center=false \
#     -V transition=convex \
#     -o intro-to-graphql.html \
#     intro-to-graphql.md
