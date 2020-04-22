import React, { useCallback } from 'react'
import { useSelected, useFocused, useEditor } from 'slate-react'
import { css } from 'emotion'

export const Leaf = ({ attributes, children, leaf }) => {
  if (leaf.bold) {
    children = <strong>{children}</strong>
  }

  if (leaf.code) {
    children = <code>{children}</code>
  }

  if (leaf.italic) {
    children = <em>{children}</em>
  }

  if (leaf.underline) {
    children = <u>{children}</u>
  }

  return <span {...attributes}>{children}</span>
}

export const ImageElement = ({ attributes, children, element }) => {
  const selected = useSelected()
  const focused = useFocused()
  return (
    <div {...attributes}>
      <div contentEditable={false}>
        <img
          src={element.url}
          className={css`
            display: block;
            max-width: 100%;
            max-height: 20em;
            box-shadow: ${selected && focused ? '0 0 0 3px #B4D5FF' : 'none'};
          `}
        />
      </div>
      {children}
    </div>
  )
}

export const VideoElement = ({ attributes, children, element }) => {
  const { url } = element
  const selected = useSelected()
  const focused = useFocused()
  return (
    <div {...attributes}>
      <div
        contentEditable={false}
        className={css`
          margin-top: 1rem;
          display: block;
          padding: 10px 0;
          background: #edf2f7;
          box-shadow: ${selected && focused ? '0 0 0 3px #B4D5FF' : 'none'};
        `}
        >
        <div
          className={css`
            padding: 75% 0 0 0;
            position: relative;
          `}
        >
          <iframe
            src={`${url}?title=0&byline=0&portrait=0`}
            frameBorder="0"
            style={{
              position: 'absolute',
              top: '0',
              left: '0',
              width: '100%',
              height: '100%',
            }}
          />
        </div>
      </div>
      {children}
    </div>
  )
}

export const Element = ({ attributes, children, element }) => {
  switch (element.type) {
    case 'block-quote':
      return <blockquote {...attributes}>{children}</blockquote>
    case 'bulleted-list':
      return <ul {...attributes}>{children}</ul>
    case 'heading-one':
      return <h1 {...attributes}>{children}</h1>
    case 'heading-two':
      return <h2 {...attributes}>{children}</h2>
    case 'heading-three':
      return <h3 {...attributes}>{children}</h3>
    case 'heading-four':
      return <h4 {...attributes}>{children}</h4>
    case 'heading-five':
      return <h5 {...attributes}>{children}</h5>
    case 'heading-six':
      return <h6 {...attributes}>{children}</h6>
    case 'list-item':
      return <li {...attributes}>{children}</li>
    case 'numbered-list':
      return <ol {...attributes}>{children}</ol>
    case 'image':
      return <ImageElement attributes={attributes} children={children} element={element} />
    case 'link':
      return (
        <a {...attributes} href={element.url}>
          {children}
        </a>
      )
    case 'video':
      return <VideoElement attributes={attributes} children={children} element={element} />
    default:
      return <p {...attributes}>{children}</p>
  }
}