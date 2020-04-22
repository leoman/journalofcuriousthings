import React from 'react'
import { useEditor } from 'slate-react'
import { insertImage } from '../helpers'
import Button from './button'
import Icon from './icon'

export const ImageButton = ({ ...props }) => {
  const editor = useEditor()
  return (
    <Button
      onMouseDown={event => {
        event.preventDefault()
        const url = window.prompt('Enter the URL of the image:')
        if (!url) return
        insertImage(editor, url)
      }}
      {...props}
    >
      <Icon>image</Icon>
    </Button>
  )
}

export default ImageButton