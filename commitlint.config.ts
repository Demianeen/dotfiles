import {
  RuleConfigCondition,
  RuleConfigSeverity,
  TargetCaseType,
} from "@commitlint/types";
import { readdirSync } from "fs";

const extractConfigName = (scope) => {
  const parts = scope.split("_");
  if (parts.length > 1) {
    // Join back any parts after the first underscore, in case there are multiple underscores
    return parts.slice(1).join("_");
  }
  return scope; // Return the original scope if it file/folder don't have type
};
const parseScopes = (array) => array.map((item) => extractConfigName(item));

const configScopes = readdirSync("./private_dot_config");

const scopes = [
  ...parseScopes(configScopes),
  "git",
  "mackup",
  "zsh",
  "brew",
  "hammerspoon",
  "bin",
  "chezmoi",
  "docs",
  "asdf",
];

export default {
  rules: {
    "body-leading-blank": [RuleConfigSeverity.Warning, "always"],
    "body-max-line-length": [RuleConfigSeverity.Error, "always", 100],
    "footer-leading-blank": [RuleConfigSeverity.Warning, "always"],
    "footer-max-line-length": [RuleConfigSeverity.Error, "always", 100],
    "header-max-length": [RuleConfigSeverity.Error, "always", 100],
    "header-trim": [RuleConfigSeverity.Error, "always"],
    "subject-case": [
      RuleConfigSeverity.Error,
      "never",
      ["sentence-case", "start-case", "pascal-case", "upper-case"],
    ],
    "subject-empty": [RuleConfigSeverity.Error, "never"],
    "subject-full-stop": [RuleConfigSeverity.Error, "never", "."],
    "type-case": [RuleConfigSeverity.Error, "always", "lower-case"],
    "type-empty": [RuleConfigSeverity.Error, "never"],
    "scope-enum": [RuleConfigSeverity.Error, "always", scopes],
    "type-enum": [
      RuleConfigSeverity.Error,
      "always",
      [
        "build",
        "chore",
        "ci",
        "docs",
        "feat",
        "fix",
        "perf",
        "refactor",
        "revert",
        "style",
        "test",
      ],
    ],
  },
};
