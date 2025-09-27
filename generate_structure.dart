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

  final folders = [
    '$basePath/core/utils',
    '$basePath/core/Services',
    // '$basePath/features/$screenName/data/api_sources',
    // '$basePath/features/$screenName/data/models',
    // '$basePath/features/$screenName/data/mappers',
    // '$basePath/features/$screenName/data/repo_impl',
    // '$basePath/features/$screenName/domain/repo',
    // '$basePath/features/$screenName/domain/entities',
    '$basePath/features/$screenName/presentation/cubits',
    '$basePath/features/$screenName/presentation/view/widgets',
    '$basePath/features/$screenName/presentation/view/{$screenName}_view.dart',
    '$basePath/features/$screenName/presentation/view/widgets/{$screenName}_view_body.dart',
  ];

  for (var folder in folders) {
    final dir = Directory(folder);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
      log('✅ Created: ${dir.path}');
    } else {
      log('⚠️ Already exists: ${dir.path}');
    }
  }

  log('\n🎉 Done setting up "$screenName" structure!');
}
