import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties: AdditionalProperties(pubName: 'netcastsoss_data_api'),
    alwaysRun: true,
    inputSpecFile: 'https://netcastsoss-data.herokuapp.com/openapi.json',
    generatorName: 'dart-jaguar',
    outputDirectory: 'lib/services/api/netcastsoss_data')
class NetcastsOSSDataConfig extends OpenapiGeneratorConfig {}
