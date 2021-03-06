import React from 'react'
import { cx, css } from 'emotion'
import Menu from './menu'
import MarkButton from './markButton'
import BlockButton from './blockButton'
import ImageButton from './imageButton'
import LinkButton from './linkButton'
import UnLinkButton from './unlinkButton'
import EmbedButton from './embedButton'
import AlignButton from './alignButton'
import LineBreakButton from './lineBreakButton'
import ImageDoubleButton from './imageDoubleButton'
import DeleteButton from './deleteButton'

export const ToolbarWrapper = React.forwardRef(({ className, ...props }, ref) => (
  <Menu
    {...props}
    ref={ref}
    className={cx(
      className,
      css`
        padding: 1px 18px 17px;
      `
    )}
  />
))

export const Toolbar = () => (
  <ToolbarWrapper>
    <AlignButton format="left" icon="format_align_left" title="Align Center" />
    <AlignButton format="center" icon="format_align_center" title="Align Center" />
    <AlignButton format="right" icon="format_align_right" title="Align Center" />
    <MarkButton format="bold" icon="format_bold" title="Bold" />
    <MarkButton format="italic" icon="format_italic" title="Italic" />
    <MarkButton format="underline" icon="format_underlined" title="Underline" />
    <BlockButton format="block-quote" icon="format_quote" title="Quote" />
    <BlockButton format="heading-one" icon="looks_one" title="Heading 1" />
    <BlockButton format="heading-two" icon="looks_two" title="Heading 2" />
    <BlockButton format="heading-three" icon="looks_3" title="Heading 3" />
    <BlockButton format="heading-four" icon="looks_4" title="Heading 4" />
    {/* <BlockButton format="heading-five" icon="looks_5" title="Heading 5" /> */}
    {/* <BlockButton format="heading-six" icon="looks_6" title="Heading 6" /> */}
    <BlockButton format="numbered-list" icon="format_list_numbered" title="Ordered List" />
    <BlockButton format="bulleted-list" icon="format_list_bulleted" title="Unordered List" />
    <ImageButton format="image" title="Image" icon="image" />
    <ImageDoubleButton format="double-image" title="Split Image" icon="flip" />
    <LinkButton format="link" title="Link" icon="link" />
    <UnLinkButton format="link" title="Remove link" icon="link_off" />
    <EmbedButton title="Video" icon="movie" />
    <LineBreakButton format="line-break" title="Ruler" icon="view_stream" />
    {/* <MarkButton format="code" icon="code" title="Code" /> */}
    <DeleteButton format="remove" title="Remove" icon="delete" />
  </ToolbarWrapper>
)

export default Toolbar;