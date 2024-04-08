import 'package:cubex/core/core.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final allProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => BaseVM()),
  ChangeNotifierProvider(create: (_) => AuthVM()),
  ChangeNotifierProvider(create: (_) => RegisterVM()),
];
