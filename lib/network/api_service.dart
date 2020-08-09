import 'package:chopper/chopper.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: 'https://rickandmortyapi.com/api/')
abstract class ApiService extends ChopperService {
  @Get(path: 'location?page={page}')
  Future<Response> getLocations(@Path() int page);

  @Get(path: 'episode')
  Future<Response> getEpisodes();

  static ApiService create() {
    final client = ChopperClient(
      services: [
        _$ApiService(),
      ],
    );
    return _$ApiService(client);
  }
}