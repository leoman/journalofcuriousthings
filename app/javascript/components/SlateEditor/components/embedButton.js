import React from 'react'
import { useEditor } from 'slate-react'
import { insertEmbed } from '../helpers'
import Button from './button'
import Icon from './icon'

export const EmbedButton = ({ icon, ...props }) => {
  const editor = useEditor()
  return (
    <Button
      onMouseDown={event => {
        event.preventDefault()
        const url = window.prompt('Enter the URL of the video:')
        if (!url) return
        insertEmbed(editor, url)
      }}
      {...props}
    >
      <Icon>{icon}</Icon>
    </Button>
  )
}

export default EmbedButton