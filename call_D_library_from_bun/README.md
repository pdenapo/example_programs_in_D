# bun-ffi

This example shows how to call a D library from javascript code in Bun.

First build the library with

```bash
cd mylib
dub build
cd ..
```

Then, you can run the example with

```bash
bun run index.ts
```

