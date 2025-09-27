import 'dart:developer';
import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    log(
      '❌ Error. \nPlease provide a screen name.\nUsage: dart generate_screen_structure.dart <screen_name>',
    );
    return;
  }

  final screenName = args[0].toLowerCase();
  final basePath = 'lib/';

  // Create folders
  final folders = [
    '$basePath/core/utils',
    '$basePath/core/Services',
    '$basePath/features/$screenName/data/models',
    '$basePath/features/$screenName/data/repo_impl',
    '$basePath/features/$screenName/domain/repo',
    '$basePath/features/$screenName/domain/entities',
    '$basePath/features/$screenName/presentation/cubits',
    '$basePath/features/$screenName/presentation/view/widgets',
  ];

  for (var folder in folders) {
    final dir = Directory(folder);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
      log('✅ Created folder: ${dir.path}');
    } else {
      log('⚠️ Folder already exists: ${dir.path}');
    }
  }

  // Create files
  final files = [
    '$basePath/features/$screenName/presentation/view/${screenName}_view.dart',
    '$basePath/features/$screenName/presentation/view/widgets/${screenName}_view_body.dart',
  ];

  for (var filePath in files) {
    final file = File(filePath);
    if (!file.existsSync()) {
      // Create parent directory if it doesn't exist
      file.parent.createSync(recursive: true);

      // Create file with basic content based on file type
      String content = _generateFileContent(screenName, filePath);
      file.writeAsStringSync(content);

      log('✅ Created file: ${file.path}');
    } else {
      log('⚠️ File already exists: ${file.path}');
    }
  }

  log('\n🎉 Done setting up "$screenName" structure!');
}

String _generateFileContent(String screenName, String filePath) {
  final className = _toPascalCase(screenName);

  if (filePath.endsWith('_view.dart')) {
    return '''import 'package:flutter/material.dart';
import 'widgets/${screenName}_view_body.dart';

class ${className}View extends StatelessWidget {
  const ${className}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ${className}ViewBody(),
    );
  }
}
''';
  } else if (filePath.endsWith('_view_body.dart')) {
    return '''import 'package:flutter/material.dart';

class ${className}ViewBody extends StatelessWidget {
  const ${className}ViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$className Screen',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text('TODO: Implement $className functionality'),
        ],
      ),
    );
  }
}
''';
  }

  return '// TODO: Implement ${_toPascalCase(screenName)} functionality\n';
}

String _toPascalCase(String input) {
  return input
      .split('_')
      .map(
        (word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '',
      )
      .join('');
}


// flutter pub run intl_utils:generate
// flutter clean
// flutter pub get
// dart pub global activate intl_utils
// dart pub global run intl_utils:generate