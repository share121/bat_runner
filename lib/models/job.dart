// ignore_for_file: avoid_dynamic_calls

class Job {
  final String name;
  final List<Job> step;
  final String? author;
  final String? license;
  final JobType type;
  final String? description;
  final String? authorUrl;
  final String? sourceUrl;
  final String? placeholder;
  final String? version;
  final String? defaultValue;
  final String? id;

  Job({
    required this.author,
    required this.license,
    required this.name,
    required this.step,
    required this.type,
    required this.description,
    required this.sourceUrl,
    required this.authorUrl,
    required this.version,
    required this.placeholder,
    required this.defaultValue,
    required this.id,
  });

  factory Job.fromJson(dynamic yaml) {
    var type = JobType.root;
    if (yaml case {'type': final String typeStr}) {
      type = {
        'run': JobType.run,
        'input-text': JobType.inputText,
        'input-number': JobType.inputNumber,
        'input-password': JobType.inputPassword,
      }[typeStr]!;
    } else if (yaml['run'] is String) {
      type = JobType.run;
    }
    return Job(
      name: yaml['name'] as String,
      step: (yaml['step'] as List).map((e) => Job.fromJson(e)).toList(),
      author: yaml['author'] as String?,
      license: yaml['license'] as String?,
      description: yaml['description'] as String?,
      authorUrl: yaml['author-url'] as String?,
      sourceUrl: yaml['source-url'] as String?,
      type: type,
      placeholder: yaml['placeholder'] as String?,
      version: yaml['version'] as String?,
      defaultValue: yaml['default'] as String?,
      id: yaml['id'] as String?,
    );
  }
}

enum JobType { inputNumber, inputText, inputPassword, run, root }
