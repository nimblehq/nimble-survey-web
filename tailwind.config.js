const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  purge: [
    './app/views/**/*.html.*'
  ],
  theme: {
    extend: {
      borderRadius: {
        normal: '10px',
        lg: '12px'
      },
      colors: {
        black: {
          default: 'var(--color-black)'
        },
        white: {
          default: 'var(--color-white)',
          180: 'var(--color-white-180)',
          200: 'var(--color-white-200)',
          600: 'var(--color-white-600)'
        }
      },
      fontFamily: {
        sans: ['Neuzeit S LT Std', ...defaultTheme.fontFamily.sans],
        mono: ['Neuzeit S LT Std', ...defaultTheme.fontFamily.mono]
      },
      fontSize: {
        xs: ['13px', '18px'],
        sm: ['15px', '20px'],
        base: ['17px', '22px']
      },
      height: {
        14: '56px'
      },
      letterSpacing: {
        tightest: '-0.41px',
        tighter: '-0.24px',
        tight: '-0.08px'
      }
    }
  },
  variants: {},
  plugins: []
};
