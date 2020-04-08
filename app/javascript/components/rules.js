import React from 'react';

/**
 * Используется для десериализации HTML
 * Соответствие между блочными HTML-элементами и объектами в состоянии Slate
 */
const BLOCK_TAGS = {
 
  blockquote: 'quote',
  pre       : 'code',
  table     : 'table',
  tr        : 'table-row',
  th        : 'table-cell',
  ul        : 'bulleted-list',
  ol        : 'numbered-list',
  li        : 'list-item',
};

/**
 * Используется для десериализации HTML
 * Для этих элементов поддерживаем выравнивание
 */
const BLOCK_TAGS_WITH_ALIGNMENT = {
  h1: 'header-1',
  h2: 'header-2',
  h3: 'header-3',
  h4: 'header-4',
  h5: 'header-5',
  h6: 'header-6',
  p : 'paragraph',
};

/**
 * Используется для десериализации HTML
 * Соответствие между строчными HTML-элементами и объектами в состоянии Slate
 */
const MARK_TAGS = {
  em    : 'italic',
  strong: 'bold',
  u     : 'underline',
};

export const rules = [
  // Блочные элементы
  {
    deserialize(el, next) {
      const type = BLOCK_TAGS[ el.tagName ];
      if (!type) {
        return;
      }
      
      return {
        kind : 'block',
        type,
        nodes: next(el.childNodes),
      };
    },
    serialize(object, children) {
      if (object.kind !== 'block') {
        return;
      }

      switch (object.type) {
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
        case 'quote':
          return <blockquote>{children}</blockquote>;
        case 'code':
          return <pre><code>{children}</code></pre>;
        case 'table':
          return <table>{children}</table>;
        case 'table-row':
          return <tr>{children}</tr>;
        case 'numbered-list':
          return <ol>{children}</ol>;
        case 'bulleted-list':
          return <ul>{children}</ul>;
        case 'list-item':
          return <li>{children}</li>;
        default:
          return;
      }
    },
  },
  // Строчные элементы
  {
    deserialize(el, next) {
      const type = MARK_TAGS[ el.tagName ];
      if (!type) {
        return;
      }

      return {
        kind : 'mark',
        type,
        nodes: next(el.childNodes),
      };
    },
    serialize(object, children) {
      if (object.kind !== 'mark') {
        return;
      }

      switch (object.type) {
        case 'bold':
          return <strong>{children}</strong>;
        case 'italic':
          return <em>{children}</em>;
        case 'underline':
          return <u>{children}</u>;
        default:
          return;
      }
    },
  },
  // Ряд html-элементов требует специальной обработки (соответственно их нет в словарях выше)
  // Ячейки таблиц (Вытаскиваем colspan и rowspan)
  {
    deserialize(el, next) {
      if (el.tagName !== 'td') {
        return;
      }
      const colspanAttribute = el.attrs
        .find(({ name }) => name === 'colspan');
      const rowspanAttribute = el.attrs
        .find(({ name }) => name === 'rowspan');
      return {
        kind : 'block',
        type : 'table-cell',
        nodes: next(el.childNodes),
        data : {
          colspan: colspanAttribute ? colspanAttribute.value : undefined,
          rowspan: rowspanAttribute ? rowspanAttribute.value : undefined,
        },
      };
    },
    serialize(object, children) {
      if (object.kind !== 'block' || object.type !== 'table-cell') {
        return;
      }
      const colspan = object.data.get('colspan');
      const rowspan = object.data.get('rowspan');
      return <td colSpan={colspan} rowSpan={rowspan}>{children}</td>;
    },
  },
  // Элементы, для которых поддерживаем выравнивание (параграфы и все header'ы)
  {
    deserialize(el, next) {
      const type = BLOCK_TAGS_WITH_ALIGNMENT[ el.tagName ];
      if (!type) {
        return;
      }
      // Через этот рукотворный атрибут мы получаем выравнивание
      // Значение аттрибута, если он есть - объект, который может быть
      // передан в качестве пропса style Реакту при рендере.
      const dataStyleAttribute = el.attrs
        .find(({ name }) => name === 'data-style');
      return {
        kind : 'block',
        type,
        nodes: next(el.childNodes),
        data : {
          'data-style': dataStyleAttribute ? dataStyleAttribute.value : undefined,
        },
      };
    },
    serialize(object, children) {
      if (object.kind !== 'block') {
        return;
      }

      const dataStyle = {
        'data-style': object.data.get('data-style'),
      };

      switch (object.type) {
        case 'header-1':
          return <h1 {...dataStyle}>{children}</h1>;
        case 'header-2':
          return <h2 {...dataStyle}>{children}</h2>;
        case 'header-3':
          return <h3 {...dataStyle}>{children}</h3>;
        case 'header-4':
          return <h4 {...dataStyle}>{children}</h4>;
        case 'header-5':
          return <h5 {...dataStyle}>{children}</h5>;
        case 'paragraph':
          return <p {...dataStyle}>{children}</p>;
        default:
          return;
      }
    },
  },
  {
    // Якоря
    deserialize(el, next) {
      if(el.tagName !== 'a' || !el.attrs.find(({ name }) => name === 'id')) {
        return;
      }
      const hasChildNodes = el.childNodes.length > 0;
      return {
        kind  : 'inline',
        type  : 'anchor',
        isVoid: !hasChildNodes,
        /* Если передаем undefined в nodes, нужное значение
          (которое сответствует пустому узлу) проставится автоматически */
        nodes : hasChildNodes ? next(el.childNodes) : undefined,
        data  : {
          id: el.attrs.find(({ name }) => name === 'id').value,
        },
      };
    },
    serialize(object, children) {
      if (object.kind !== 'inline' || object.type !== 'anchor') {
        return;
      }

      const id = object.data.get('id').value;
      return <a id={id} >{children}</a>;
    },
  },
  {
    // Ссылки (нужно извлечь адрес)
    deserialize(el, next) {
      if (el.tagName !== 'a') {
        return;
      }
      const hrefAttribute = el.attrs
        .find(({ name }) => name === 'href');
      return {
        kind : 'inline',
        type : 'link',
        nodes: next(el.childNodes),
        data : {
          href: hrefAttribute ? hrefAttribute.value : '',
        },
      };
    },
    serialize(object, children) {
      if (object.kind !== 'inline' || object.type !== 'link') {
        return;
      }

      const href = object.data.get('href');
      return <a href={href}>{children}</a>;
    },
  },
  {
    // Картинки (нужно извлечь src)
    deserialize(el, next) {
      if(el.tagName !== 'img') {
        return;
      }

      return {
        kind : 'block',
        type : 'image',
        nodes: next(el.childNodes),
        data : {
          src: el.attrs.find(({ name }) => name === 'src').value,
        },
      };
    },
    serialize(object) {
      if (object.kind !== 'block' || object.type !== 'image') {
        return;
      }
      const src = object.data.get('src');
      return <img src={src} />;
    },
  },
];