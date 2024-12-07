class ProgramMapper {
  static String mapProgramString(String name) {
    return switch(name) {
      "cat program"       => "cat:\n  in\n  out\n  jmp cat",
      "decrement counter" => "push 11\nstart:\n  push 1\n  sub\n  out\n  jnz start\n  hlt",
      _ => ""
    };
  }
}