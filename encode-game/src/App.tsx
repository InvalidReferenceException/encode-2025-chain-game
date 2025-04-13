import { GameProvider } from './providers/GameProvider'
import Game from './Game'

function App() {
  return (
    <GameProvider>
      <Game />
    </GameProvider>
  )
}

export default App
