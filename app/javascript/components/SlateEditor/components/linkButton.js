import React from 'react'
import { useSlate } from 'slate-react'
import Button from './button'
import Icon from './icon'
import { isLinkActive, insertLink } from '../helpers'

const LinkButton = ({ ...props }) => {
  const editor = useSlate()
  return (
    <Button
      active={isLinkActive(editor)}
      onMouseDown={event => {
        event.preventDefault()
        const url = window.prompt('Enter the URL of the link:')
        if (!url) return
        insertLink(editor, url)
      }}
      {...props}
    >
      <Icon>link</Icon>
    </Button>
  )
}

export default LinkButton