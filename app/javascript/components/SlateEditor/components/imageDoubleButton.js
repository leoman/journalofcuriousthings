import React, { useState } from 'react'
import { useSlate } from 'slate-react'
import Button from './button'
import Icon from './icon'
import ImageDoubleOverlay from './imageDoubleOverlay'
import { insertDoubleImage, isBlockActive } from '../helpers'

export const ImageDoubleButton = ({ format, icon, ...props }) => {
  const editor = useSlate()
  const [showImageOverlay, setShowImageOverlay] = useState(false)
  const [selection, setSelection] = useState(null)
  const handleShowImageOverlay = selection => {
    setSelection(selection)
    setShowImageOverlay(true)
  }
  const handleClose = () => setShowImageOverlay(false)
  const handleSubmit = (image, image2) => insertDoubleImage(editor, selection, image, image2)

  return (
    <>
      <ImageDoubleOverlay
        showImageOverlay={showImageOverlay}
        handleSubmit={handleSubmit}
        handleClose={handleClose}
      />
      <Button
        active={isBlockActive(editor, format)}
        onMouseDown={event => {
          event.preventDefault()
          const { selection } = editor
          if (selection) handleShowImageOverlay(selection)
        }}
        {...props}
      >
        <Icon>{icon}</Icon>
      </Button>
    </>
  )
}

export default ImageDoubleButton