/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{html,ts}'],
  theme: {
    extend: {
      colors: {
        'brand-amber': '#FAF4E1',
        'brand-blue': '#E4F6FA',
        'brand-amber-deep': '#E5C767',
        'brand-active': '#F2E9D9',
        'brand-secondary-green': '#4AA785',

        'brand-blue': '#5e97c8',
        'brand-button': '#FAF4E1',
        'brand-light-blue': '#79D0E5',
        'brand-navy-blue': '#073C5B',
        'brand-beige': '#EFD0A9',
        'brand-gold': '#E5C767',
        'brand-black': '#1C1C1C66',
        'brand-black-100': '#1C1C1C',
        'brand-black-80': '#1C1C1CCC',
        'brand-black-40': '#00000066',
        'brand-primary-light': '#F7F9FB',
        'brand-primary-purple': '#E5ECF680',
      },
      lineHeight: {
        'extra-loose': '2.5',
        4.5: '1.125rem',
        12: '3rem',
      },
      margin: {
        7.5: '30px',
      },
      padding: {
        7.5: '30px',
      },
    },
  },
  plugins: [require('@tailwindcss/forms')],
};
