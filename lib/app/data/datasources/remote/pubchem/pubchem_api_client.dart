import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:pubchem/app/core/values/api_end_points.dart';
import 'model/pubchem_cid_response.dart';
import 'model/pubchem_property_response.dart';

part 'pubchem_api_client.g.dart';

@RestApi()
abstract class PubChemApiClient {
  factory PubChemApiClient(Dio dio, {String? baseUrl}) = _PubChemApiClient;

  @GET(ApiEndPoints.compoundPropertiesByName)
  Future<HttpResponse<PubChemPropertyResponse>> getCompoundProperties(
    @Path('name') String name,
  );

  @GET(ApiEndPoints.compoundCidsByName)
  Future<HttpResponse<PubChemCidResponse>> getCompoundCids(
    @Path('name') String name,
  );
}
