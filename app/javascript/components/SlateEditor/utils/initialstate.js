export const initialstate = [
  {
    type: 'heading-one',
    inlineStyles: {
      textAlign: 'center'
    },
    children: [
      { text: `Scandi Weekend:`, bold: true },
      {
        type: 'link',
        url: 'http://www.bla.com',
        children: [{ text: ` Stockholm's` }],
      },
      { text: ` Amazing Metro` }
    ],
  },
  {
    type: 'double-image',
    data: {
      url1: 'https://live.staticflickr.com/7876/47200575021_9fb7850399_b.jpg',
      url2: 'https://live.staticflickr.com/65535/49607857182_bd87787fd6_b.jpg'
    },
    children: [{ text: '' }],
  },
  { 
    type: 'line-break', 
    children: [{ text: '' }] 
  },
  {
    type: 'image',
    url: 'https://live.staticflickr.com/7876/47200575021_9fb7850399_b.jpg',
    children: [{ text: '' }],
  },
  {
    type: 'paragraph',
    inlineStyles: {
      textAlign: 'center'
    },
    children: [{ text: `My lovely colleague Wendy and I spent a lovely morning exploring the beautiful Old Town area of Stockholm: the stunning and elaborate palace, the little streets, the colours reflected in the water, the cinnamon buns... I could go on.  But that's a story for another day, as Sunday afternoon proved to be considerably more eclectic.` }],
  },
  {
    type: 'image',
    url: 'https://live.staticflickr.com/7915/46426074584_452191774f_b.jpg',
    children: [{ text: '' }],
  },
  {
    type: 'paragraph',
    inlineStyles: {
      textAlign: 'center'
    },
    children: [{ text: `Lunch warmed us through and we set off in search of the Fotografiska, a photography gallery. We walked there, crossing onto a new island and passing a ferry port where huge cruise ships had lined up to drop off the hoards of tourists. We didn’t actually enter the museum as we lacked the time to justify the entrance fee, but they were exhibiting Kirsty Mitchell’s amazing collection of photographs entitled Wonderland, blending fashion, fantasy and fairytales. I had seen some of these beautiful artworks before in a gallery in London and I would have loved to visit again, but sadly it was gift shop only for us, and I had to settle for flipping through the book of prints.` }],
  },
  {
    type: 'line-break',
    children: [{ text: `` }],
  },
  {
    type: 'paragraph',
    inlineStyles: {
      textAlign: 'center'
    },
    children: [{ text: `Wendy was very keen to visit the Ericsson globe, which she claimed was a must-see sight of Stockholm, being the largest spherical building in the world, or somesuch. I was less convinced, having googled it and found that it was simply a concert venue. There didn't seem to be much there to actually do or enjoy, and it was a solid 45 minute walk away.` }],
  },
  {
    type: 'paragraph',
    inlineStyles: {
      textAlign: 'center'
    },
    children: [{ text: `But Wendy would not be denied and so I dutifully martyred myself to her cause and cheerfully complained the whole way. ` }],
  },
  {
    type: 'image',
    url: 'https://live.staticflickr.com/65535/48007621516_08f737e18c_b.jpg',
    children: [{ text: '' }],
  },
  {
    type: 'paragraph',
    inlineStyles: {
      textAlign: 'center'
    },
    children: [{ text: `Much of Stockholm is incredibly lovely to simply stroll around, but the same could not be said of our lengthy trudge along the duel carriageway in the grey, gathering dusk. We had to divert several times, striking off into a housing estate as the route was not pedestrian friendly. Another obvious indication that VISITING THIS BUILDING IS NOT A COOL OR FUN THING TO DO WENDY!!!` }],
  },



  // testers

  // {
  //   type: 'video',
  //   url: 'https://www.youtube.com/embed/hJa3IX2OKB4',
  //   children: [{ text: '' }],
  // },

  // {
  //   type: 'image',
  //   url: 'https://live.staticflickr.com/7876/47200575021_9fb7850399_b.jpg',
  //   children: [{ text: '' }],
  // },

  // {
  //   type: 'align',
  //   align: 'center',
  //   children: [{ text: 'In addition to block nodes, you can create inline nodes, like' }],
  // },

  // {
  //   children: [
  //     {
  //       text: 'In addition to block nodes, you can create inline nodes, like ',
  //     },
  //     {
  //       type: 'link',
  //       url: 'https://en.wikipedia.org/wiki/Hypertext',
  //       children: [{ text: 'hyperlinks' }],
  //     },
  //     {
  //       text: '!',
  //     },
  //   ],
  // },

  // {
  //   type: 'paragraph',
  //   children: [
  //     { text: 'This is editable ' },
  //     { text: 'rich', bold: true },
  //     { text: ' text, ' },
  //     { text: 'much', italic: true },
  //     { text: ' better than a ' },
  //     { text: '<textarea>', code: true },
  //     { text: '!' },
  //     { text: 'also a underline', underline: true },
  //     { text: '!' },
  //   ],
  // },
  // {
  //   type: 'paragraph',
  //   children: [
  //     {
  //       text:
  //         "Since it's rich text, you can do things like turn a selection of text ",
  //     },
  //     { text: 'bold', bold: true },
  //     {
  //       text:
  //         ', or add a semantically rendered block quote in the middle of the page, like this:',
  //     },
  //   ],
  // },
  
]