import 'package:pubchem/app/core/base/base_remote_source.dart';
import 'package:pubchem/app/core/values/api_end_points.dart';
import 'package:pubchem/app/network/dio_provider.dart';
import 'model/pubchem_cid_response.dart';
import 'model/pubchem_property_response.dart';
import 'pubchem_api_client.dart';
import 'pubchem_remote_source.dart';

class PubChemRemoteSourceImpl extends BaseRemoteSource
    implements PubChemRemoteSource {
  final PubChemApiClient _apiClient;

  PubChemRemoteSourceImpl({PubChemApiClient? apiClient})
      : _apiClient = apiClient ??
            PubChemApiClient(
              DioProvider.client,
              baseUrl: ApiEndPoints.pubChemBaseUrl,
            );

  @override
  Future<PubChemPropertyResponse> getCompoundProperties(String name) async {
    final response = await callApiWithErrorParser(
      _apiClient.getCompoundProperties(name).then((value) => value.response),
    );
    return PubChemPropertyResponse.fromJson(response.data);
  }

  @override
  Future<PubChemCidResponse> getCompoundCids(String name) async {
    final response = await callApiWithErrorParser(
      _apiClient.getCompoundCids(name).then((value) => value.response),
    );
    return PubChemCidResponse.fromJson(response.data);
  }
}
