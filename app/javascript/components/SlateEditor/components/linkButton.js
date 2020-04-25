import React, { useState } from 'react'
import { Range } from 'slate'
import { useSlate } from 'slate-react'
import Button from './button'
import Icon from './icon'
import LinkOverlay from './linkOverlay'
import { isBlockActive, insertLink } from '../helpers'

const LinkButton = ({ format, icon, ...props }) => {
  const editor = useSlate()
  const [showLinkOverlay, setShowLinkOverlay] = useState(false)
  const [selection, setSelection] = useState(null)
  const handleShowLinkOverlay = selection => {
    setSelection(selection)
    setShowLinkOverlay(true)
  }
  const handleClose = () => setShowLinkOverlay(false)
  const handleSubmit = url => insertLink(editor, url, selection)
  return (
    <>
      <LinkOverlay
        showLinkOverlay={showLinkOverlay}
        handleSubmit={handleSubmit}
        handleClose={handleClose}
      />
      <Button
        active={isBlockActive(editor, format)}
        onMouseDown={event => {
          event.preventDefault()
          const { selection } = editor
          const isCollapsed = selection && Range.isCollapsed(selection)
          if (selection && !isCollapsed) handleShowLinkOverlay(selection)
        }}
        {...props}
      >
        <Icon>{icon}</Icon>
      </Button>
    </>
  )
}

export default LinkButton