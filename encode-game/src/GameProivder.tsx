// src/GameProvider.tsx
import { createContextProvider } from '@dojoengine/create-react-context'
import manifest from '../manifests/dev/manifest.json'

const toriiUrl = 'http://localhost:8080'

export const { GameProvider, useGameContext } = createContextProvider({
  manifest,
  toriiUrl,
})
