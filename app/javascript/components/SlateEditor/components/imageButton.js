import React, { useState } from 'react'
import { useEditor } from 'slate-react'
import { insertImage, isImageActive } from '../helpers'
import Button from './button'
import Icon from './icon'
import ImageOverlay from './imageOverlay'

export const ImageButton = ({ icon, ...props }) => {
  const editor = useEditor()
  const [showImageOverlay, setShowImageOverlay] = useState(false)
  const [selection, setSelection] = useState(null)
  const handleShowImageOverlay = selection => {
    setSelection(selection)
    setShowImageOverlay(true)
  }
  const handleClose = () => setShowImageOverlay(false)
  const handleSubmit = image => insertImage(editor, image, selection)

  return (
    <>
      <ImageOverlay
        showImageOverlay={showImageOverlay}
        handleSubmit={handleSubmit}
        handleClose={handleClose}
      />
      <Button
        active={isImageActive(editor)}
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

export default ImageButton