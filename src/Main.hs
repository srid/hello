module Main where

import Network.HTTP.Types (status200)
import Network.HTTP.Types.Header (hContentType)
import Network.Wai (Application, responseLBS)
import Network.Wai.Handler.Warp (Port, run)
import Options.Applicative

main :: IO ()
main = do
  Options {host, port} <- execParser opts
  putStrLn $ "Starting server on http://" <> host <> ":" <> show port <> "..."
  run port app

app :: Application
app _req respond =
  respond $
    responseLBS
      status200
      [(hContentType, "text/plain")]
      "Hello world (github:srid/hello)"

-- Command-line options data type
data Options = Options
  { host :: String
  , port :: Port
  }

-- Parser for command-line options
optionsParser :: Parser Options
optionsParser =
  Options
    <$> strOption
      ( long "host"
          <> metavar "HOST"
          <> help "Host address to bind to (e.g., 0.0.0.0)"
          <> value "127.0.0.1"
      )
    <*> option
      auto
      ( long "port"
          <> metavar "PORT"
          <> help "Port number to listen on (e.g., 3000)"
          <> value 3000
      )

-- Parser info with additional metadata
opts :: ParserInfo Options
opts =
  info
    (optionsParser <**> helper)
    ( fullDesc
        <> progDesc "Run a simple web server serving 'Hello world'"
        <> header "Hello World Web App"
    )
