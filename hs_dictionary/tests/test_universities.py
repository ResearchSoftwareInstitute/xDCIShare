import json

from rest_framework.test import APIClient
from rest_framework import status
from rest_framework.test import APITestCase


# TODO broken in myhpom ("oauthlib.oauth2.rfc6749.endpoints.resource: DEBUG: Dispatching token_type Bearer request")
# class TestUniversities(APITestCase):
#     def setUp(self):
#         self.client = APIClient()
#
#     def test_universities_no_query(self):
#         response = self.client.get('/hsapi/dictionary/universities/', format='json')
#         self.assertEqual(response.status_code, status.HTTP_200_OK)
#         content = json.loads(response.content)
#         self.assertEqual(len(content), 1)
#
#     def test_universities_query(self):
#         response = self.client.get('/hsapi/dictionary/universities/?term=dubai', format='json')
#         self.assertEqual(response.status_code, status.HTTP_200_OK)
#         content = json.loads(response.content)
#         self.assertEqual(len(content), 9)
