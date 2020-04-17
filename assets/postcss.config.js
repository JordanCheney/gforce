const purgecss = require('@fullhuman/postcss-purgecss')({
  content: [
    './js/**/*.svelte'
  ],

  whitelist: ['opacity-0', 'pointer-events-none', 'hidden', 'invisible'],
  whitelistPatterns: [/svelte-/],

  defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || []
});

const production = process.env.MIX_ENV === 'prod'

module.exports = {
  plugins: [
    require('tailwindcss'),
    ...(production ? [purgecss] : [])
  ]
};
