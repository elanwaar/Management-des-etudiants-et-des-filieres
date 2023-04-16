  /** @type {import('tailwindcss').Config} */
module.exports = {
  mode: process.env.Node_ENV ? 'jit' : undefined,
  purge :["./src/**/*.html", "./src/**/*.js"],
  content: [],
  theme: {
    extend: {},
  },
  plugins: [],
}

