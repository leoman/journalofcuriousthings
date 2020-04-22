import { Node, Text } from 'slate'
import escapeHtml from 'escape-html'

export const serialize = node => {

  if(node.bold) {
    return `<strong>${node.text}</strong>`;
  }

  if(node.italic) {
    return `<em>${node.text}</em>`;
  }

  if(node.code) {
    return `<code>${node.text}</code>`;
  }

  if(node.underline) {
    return `<u>${node.text}</u>`;
  }
  

  if (Text.isText(node)) {
    return escapeHtml(node.text)
  }

  const children = node.children.map(n => serialize(n)).join('')

  switch (node.type) {
    case 'block-quote':
      return `<blockquote><p>${children}</p></blockquote>`
    case 'paragraph':
      return `<p>${children}</p>`
    case 'link':
      return `<a href="${escapeHtml(node.url)}">${children}</a>`
    case 'heading-one':
      return `<h1>${children}</h1>`;
    case 'heading-two':
      return `<h2>${children}</h2>`;
    case 'heading-three':
      return `<h3>${children}</h3>`;
    case 'heading-four':
      return `<h4>${children}</h4>`;
    case 'heading-five':
      return `<h5>${children}</h5>`;
    case 'heading-six':
      return `<h6>${children}</h6>`;
    case 'code':
      return <pre><code>{children}</code></pre>;
    case 'bold':
      return <strong>{children}</strong>;
    case 'italic':
      return <em>{children}</em>;
    case 'underline':
      return <u>{children}</u>;
    default:
      return children
  }
}

export const serializeValueToHtml = value => {
  value.map(node => {
    console.log(serialize(node));
  })
}

export default serializeValueToHtml;