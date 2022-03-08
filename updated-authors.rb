#!/usr/bin/env ruby
require 'yaml'

LANGUAGES = {
  "cs" => "C#",
  "fsharp" => "F#",
  "javascript" => "JavaScript",
  "rescript" => "ReScript",
  "sqlite" => "SQLite",
  "ts" => "TypeScript",
  "php" => "PHP",
  "ms-sql" => "MS SQL"
}.freeze

def language_label(key)
  LANGUAGES.fetch(key, key.capitalize)
end

def authors
  @authors ||= begin
    YAML.load(IO.read('./authors.yml'), symbolize_names: true)
    .fetch(:authors).sort_by { |a| a[:name] }
  end
end

def profile(author)
  "[%{name}](%{profile})" % author
end

def solutions(author)
  groups = author.fetch(:solutions, [])
    .group_by { |path| path.split('/')[1] }
    .map { |k,v| [k, v.map {|p| {name: p.split("/").last, path: p} }]}
    .sort_by { |k,_| k }
    .freeze

  render_groups(groups)
end

def render_groups(groups)
  groups.map do |language, paths|
    if paths.size == 1
      "[%{language}](%{path})" % paths.first.merge!(language: language_label(language))
    else
      "%s:" % language_label(language) + " " + paths.map do |solution|
        "[%{name}](%{path})" % solution
      end.join(", ")
    end
  end.join(", ")
end


def render(authors)
  out = "## Authors\n\n"
  out += "| Author | Solutions |\n"
  out += "| --- | --- |\n"
  authors.each do |author|
    out += "|" + profile(author) + " | " +  solutions(author) + "|\n"
  end
  out += "\n"
  out += "## The Stats 📈\n"
  out += "- The number of authors: #{authors.size}\n"
  out += "- The number of solutions: #{authors.map { |a| a[:solutions] }.flatten.size}\n"
  out += "- The number of programming languages: #{authors.map {|a| a[:solutions]}.flatten.map {|s| s.split('/')[1] }.uniq.size}\n"
  out += "- The language / solutions breakdown: "
  out += authors.map {|a| a[:solutions].map {|s| s.split('/')[1] } }.flatten.tally
    .map {|k,v| [language_label(k),v]}
    .sort_by { |k,v| -v }
    .map { |k,v| "#{k}: #{v}"}
    .join(", ")
  out + "\n\n"
end

def replace_authors
  readme_file = 'README.md'.freeze
  File.read(readme_file).gsub!(/## Authors.*\z/m, render(authors))
end

puts replace_authors()
