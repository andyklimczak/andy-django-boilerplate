from django.test import SimpleTestCase


class HealthzTest(SimpleTestCase):
    def test_healthz_works(self):
        response = self.client.get("/healthz/")
        assert response.content.decode() == "OK"
