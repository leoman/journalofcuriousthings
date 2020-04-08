import { Node, Text } from 'slate'
import escapeHtml from 'escape-html'

const serialize = node => {

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
    case 'header-1':
      return <h1>{children}</h1>;
    case 'header-2':
      return <h2>{children}</h2>;
    case 'header-3':
      return <h3>{children}</h3>;
    case 'header-4':
      return <h4>{children}</h4>;
    case 'header-5':
      return <h5>{children}</h5>;
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

export default serialize;