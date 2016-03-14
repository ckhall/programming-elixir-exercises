# Convert float to a string with 2 decimal places. (Erlang)
:io.format("~.2f~n", [1.234])

# Get the value of an operating environment variable. (Elixir)
System.get_env("PWD")

# Return the extension component of a file name. (Elixir)
Path.extname("whatever.exs")

# Return the Process's current working directory. (Elixir)
System.cwd

# Convert a string containing JSON into Elixir data structures
# https://github.com/devinus/poison

# Execute a command in your operating system's shell.
System.cmd("echo", ["hello"])
