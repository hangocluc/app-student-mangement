// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostalCodeInfo {
  final String postCode;
  final String address;
  final String address1;
  final String address2;

  const PostalCodeInfo(
      this.postCode, this.address, this.address1, this.address2);

  @override
  String toString() {
    return 'PostalCodeInfo(postCode: $postCode, address: $address, address1: $address1, address2: $address2)';
  }
}
