// @ts-check
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

// https://astro.build/config
export default defineConfig({
  site: 'https://luis.cumbi.co',
  integrations: [tailwind()],
  output: 'static',
  build: {
    format: 'file',
    assets: '_astro',
  },
  compressHTML: true
});