
from django.test import TestCase
from django.conf import settings
from myhpom.models import CloudFactoryRun, CloudFactoryUnit


class CloudFactoryRunModelTestCase(TestCase):
    """
    * run created with required data has expected defaults
    * .post_data contains keys: ['units', 'line_id', 'callback_url']
    * .data contains all keys defined in the model.
    """

    def test_create_run(self):
        line_id = settings.CLOUDFACTORY_PRODUCTION_LINES['TEST']
        run = CloudFactoryRun.objects.create(line_id=line_id)
        self.assertEqual(run.post_data, {'line_id': line_id, 'callback_url': '', 'units': []})
        self.assertEqual(run.data['units'], [])
        for key in ['run_id', 'callback_url', 'status', 'message']:
            self.assertEqual(run.data[key], '')
        for key in ['created_at', 'processed_at']:
            self.assertIsNone(run.data[key])


class CloudFactoryUnitModelTestCase(TestCase):
    """
    * unit created with required data has expected defaults
    * .input is a dict, not a string, in all user-facing object states
    * .output is a dict, not a string, in all user-facing object states
    * .post_data contains the content of .input
    * .data contains the all the keys defined in the model (with .input and .output as objects)
    """

    def setUp(self):
        line_id = settings.CLOUDFACTORY_PRODUCTION_LINES['TEST']
        self.run = CloudFactoryRun.objects.create(line_id=line_id)
        self.unit = CloudFactoryUnit.objects.create(run=self.run)

    def test_create_unit(self):
        self.assertEqual(self.unit.run, self.run)
        for key in ['status', 'input', 'output']:
            self.assertEqual(self.unit.data[key], '')
        for key in ['created_at', 'processed_at']:
            self.assertIsNone(self.unit.data[key])

    def test_unit_input_output(self):
        """since Django 1.8 doesn't have a JSONField, we're storing input and output as strings.
        This test just ensures that they are stored and presented correctly.
        """

        input = {
            'state': 'NC',
            'full_name': 'Joe Tester',
            'date_signed': '2018-09-18',
            'pdf_url': '',
        }
        output = {
            'owner_name_matches': 'true',
            'witness_signature_1': 'true',
            'witness_signature_2': 'false',
            'notarized': 'true',
            'signed_by_owner': 'not applicable',
        }
        self.unit.input = input
        self.unit.output = output
        self.unit.save()

        self.assertEqual(self.unit.input, input)
        self.assertEqual(self.unit.output, output)

        unit = CloudFactoryUnit.objects.get(id=self.unit.id)
        self.assertEqual(unit.input, input)
        self.assertEqual(unit.output, output)
