import React, { useState, useCallback, useEffect } from 'react'
import { useSelected, useFocused, useEditor } from 'slate-react'
import { css } from 'emotion'
import { insertNewImage, removeElement, insertNewLink, unWrapElement } from '../helpers'
import Icon from '../components/icon'

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
  const editor = useEditor()
  const { selection } = editor
  const [showImageOverlay, setShowImageOverlay] = useState(false)
  const handleShowImageOverlay = event => {
    event.preventDefault()
    console.log('handleShowImageOverlay');
    setShowImageOverlay(true)
  } 
  const handleClose = () => setShowImageOverlay(false)
  const handleSubmit = url => insertNewImage(editor, selection, url)
  return (
    <ContentWrapperWithRemove attributes={attributes} element={element}>
      <div>
        <div contentEditable={false}>
          <img
            onDoubleClick={handleShowImageOverlay}
            src={element.url}
            className={css`
              display: block;
              box-shadow: ${selected && focused ? '0 0 0 3px #B4D5FF' : 'none'};
            `}
          />
        </div>
        {children}
      </div>
    </ContentWrapperWithRemove>
  )
}

export const DoubleImageElement = ({ attributes, children, element }) => {
  const selected = useSelected()
  const focused = useFocused()
  const editor = useEditor()
  return (
    <ContentWrapperWithRemove attributes={attributes} element={element}>
      <div>
        <div contentEditable={false}>
          <div className="double">
            <img
             // onDoubleClick={handleShowImageOverlay}
              src={element.data.url1}
              className={css`
                display: block;
                box-shadow: ${selected && focused ? '0 0 0 3px #B4D5FF' : 'none'};
              `}
            />
            <img
              src={element.data.url2}
              className={css`
                display: block;
                box-shadow: ${selected && focused ? '0 0 0 3px #B4D5FF' : 'none'};
              `}
            />
          </div>
        </div>
        {children}
      </div>
    </ContentWrapperWithRemove>
  )
}

export const VideoElement = ({ attributes, children, element }) => {
  const { url } = element
  const selected = useSelected()
  const focused = useFocused()
  return (
    <ContentWrapperWithRemove attributes={attributes} element={element}>
      <div>
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
    </ContentWrapperWithRemove>
  )
}

export const LinkElement = ({ attributes, children, element }) => {
  const editor = useEditor()
  return (
    <a
      {...attributes}
      // onDoubleClick={() => insertNewLink(editor, element)}
      href={element.url}
    >
      {children}
    </a>
  )
}; 

export const LineBreakElement = ({ attributes, children, element }) => {
  const selected = useSelected()
  const focused = useFocused()
  return (
    <ContentWrapperWithRemove attributes={attributes} element={element}>
      <div>
        <div contentEditable={false}>
          <div
            className={'hr'}
            style={{ boxShadow: selected && focused ? '0 0 0 3px #B4D5FF' : 'none' }}
          >{children}
          </div>
        </div>
      </div>
    </ContentWrapperWithRemove>
  )
}

export const ContentWrapperWithRemove = ({ attributes, element, children }) => {
  const editor = useEditor()
  const selected = useSelected()
  const focused = useFocused()
  const [elementSelected, setElementSelected] = useState(null)

  useEffect(() => {
    const { selection } = editor;
    setElementSelected(selection);
  }, [selected])

  const removeContent = (event) => {
    event.preventDefault()
    removeElement(editor, elementSelected)
  }
  return (
    <div {...attributes} className="slate-editor-content-wrapper">
      <div style={{display: selected && focused ? 'block' : 'none'}} className="slate-editor-content-toolbar">
        <Icon onClick={removeContent}>delete_forever</Icon>
      </div>
      {children}
    </div>
  )
}

export const Element = ({ attributes, children, element, element: { inlineStyles = {} } }) => {
  switch (element.type) {
    case 'block-quote':
      return <blockquote style={inlineStyles} {...attributes}>{children}</blockquote>
    case 'bulleted-list':
      return <ul style={inlineStyles} {...attributes}>{children}</ul>
    case 'heading-one':
      return <h1 style={inlineStyles} {...attributes}>{children}</h1>
    case 'heading-two':
      return <h2 style={inlineStyles} {...attributes}>{children}</h2>
    case 'heading-three':
      return <h3 style={inlineStyles} {...attributes}>{children}</h3>
    case 'heading-four':
      return <h4 style={inlineStyles} {...attributes}>{children}</h4>
    case 'heading-five':
      return <h5 style={inlineStyles} {...attributes}>{children}</h5>
    case 'heading-six':
      return <h6 style={inlineStyles} {...attributes}>{children}</h6>
    case 'list-item':
      return <li style={inlineStyles} {...attributes}>{children}</li>
    case 'numbered-list':
      return <ol style={inlineStyles} {...attributes}>{children}</ol>
    case 'image':
      return <ImageElement attributes={attributes} children={children} element={element} />
    case 'double-image':
      return <DoubleImageElement attributes={attributes} children={children} element={element} />
    case 'link':
      return <LinkElement attributes={attributes} children={children} element={element} />
    case 'video':
      return <VideoElement attributes={attributes} children={children} element={element} />
    case 'line-break':
      return <LineBreakElement attributes={attributes} children={children} element={element} />
    default:
      return <p style={inlineStyles} {...attributes}>{children}</p>
  }
}