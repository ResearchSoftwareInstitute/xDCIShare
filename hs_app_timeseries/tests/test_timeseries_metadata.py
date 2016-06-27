import os
import tempfile
import shutil
from dateutil import parser

from xml.etree import ElementTree as ET

from django.test import TransactionTestCase
from django.core.exceptions import ValidationError
from django.core.files.uploadedfile import UploadedFile
from django.contrib.auth.models import Group
from django.db import IntegrityError

from hs_core import hydroshare
from hs_core.hydroshare import utils
from hs_core.models import CoreMetaData, Creator, Contributor, Coverage, Rights, Title, Language, \
    Publisher, Identifier, Type, Subject, Description, Date, Format, Relation, Source
from hs_core.testing import MockIRODSTestCaseMixin
from hs_app_timeseries.models import TimeSeriesResource, Site, Variable, Method, ProcessingLevel, TimeSeriesResult


class TestTimeSeriesMetaData(MockIRODSTestCaseMixin, TransactionTestCase):
    def setUp(self):
        super(TestTimeSeriesMetaData, self).setUp()
        self.group, _ = Group.objects.get_or_create(name='Hydroshare Author')
        self.user = hydroshare.create_account(
            'user1@nowhere.com',
            username='user1',
            first_name='Creator_FirstName',
            last_name='Creator_LastName',
            superuser=False,
            groups=[self.group]
        )

        self.resTimeSeries = hydroshare.create_resource(
            resource_type='TimeSeriesResource',
            owner=self.user,
            title='Test Time Series Resource'
        )

        self.temp_dir = tempfile.mkdtemp()
        self.odm2_sqlite_file_name = 'ODM2_valid.sqlite'
        self.odm2_sqlite_file = 'hs_app_timeseries/tests/{}'.format(self.odm2_sqlite_file_name)
        target_temp_sqlite_file = os.path.join(self.temp_dir, self.odm2_sqlite_file_name)
        shutil.copy(self.odm2_sqlite_file, target_temp_sqlite_file)
        self.odm2_sqlite_file_obj = open(target_temp_sqlite_file, 'r')

        self.odm2_sqlite_bad_file_name = 'ODM2_invalid.sqlite'
        self.odm2_sqlite_bad_file = 'hs_app_timeseries/tests/{}'.format(self.odm2_sqlite_bad_file_name)
        target_temp_bad_sqlite_file = os.path.join(self.temp_dir, self.odm2_sqlite_bad_file_name)
        shutil.copy(self.odm2_sqlite_bad_file, target_temp_bad_sqlite_file)
        self.odm2_sqlite_bad_file_obj = open(target_temp_bad_sqlite_file, 'r')

        temp_text_file = os.path.join(self.temp_dir, 'ODM2.txt')
        text_file = open(temp_text_file, 'w')
        text_file.write("ODM2 records")
        self.text_file_obj = open(temp_text_file, 'r')

    def tearDown(self):
        super(TestTimeSeriesMetaData, self).tearDown()
        if os.path.exists(self.temp_dir):
            shutil.rmtree(self.temp_dir)

    def test_allowed_file_types(self):
        # test allowed file type is '.sqlite'
        self.assertIn('.sqlite', TimeSeriesResource.get_supported_upload_file_types())
        self.assertEquals(len(TimeSeriesResource.get_supported_upload_file_types()), 1)

        # there should not be any content file
        self.assertEquals(self.resTimeSeries.files.all().count(), 0)

        files = [UploadedFile(file=self.text_file_obj, name=self.text_file_obj.name)]
        # trying to add a text file to this resource should raise exception
        with self.assertRaises(utils.ResourceFileValidationException):
            utils.resource_file_add_pre_process(resource=self.resTimeSeries, files=files, user=self.user,
                                                extract_metadata=False)

        # trying to add sqlite file should pass the file add pre process check
        files = [UploadedFile(file=self.odm2_sqlite_bad_file_obj, name=self.odm2_sqlite_bad_file_name)]
        utils.resource_file_add_pre_process(resource=self.resTimeSeries, files=files, user=self.user,
                                            extract_metadata=False)

        # should raise file validation error and the file will not be added to the resource
        with self.assertRaises(utils.ResourceFileValidationException):
            utils.resource_file_add_process(resource=self.resTimeSeries, files=files, user=self.user,
                                            extract_metadata=False)

        # there should not be aby content file
        self.assertEquals(self.resTimeSeries.files.all().count(), 0)

        # there should no content file
        self.assertEquals(self.resTimeSeries.files.all().count(), 0)

        # use a valid ODM2 sqlite which should pass both the file pre add check post add check
        files = [UploadedFile(file=self.odm2_sqlite_file_obj, name=self.odm2_sqlite_file_name)]
        utils.resource_file_add_pre_process(resource=self.resTimeSeries, files=files, user=self.user,
                                            extract_metadata=False)

        utils.resource_file_add_process(resource=self.resTimeSeries, files=files, user=self.user,
                                        extract_metadata=False)

        # there should one content file
        self.assertEquals(self.resTimeSeries.files.all().count(), 1)

        # file pre add process should raise validation error if we try to add a 2nd file when the resource has
        # already has one content file
        with self.assertRaises(utils.ResourceFileValidationException):
            utils.resource_file_add_pre_process(resource=self.resTimeSeries, files=files, user=self.user,
                                                extract_metadata=False)

    def test_metadata_extraction_on_resource_creation(self):
        # passing the file object that points to the temp dir doesn't work - create_resource throws error
        # open the file from the fixed file location
        self.odm2_sqlite_file_obj = open(self.odm2_sqlite_file, 'r')

        self.resTimeSeries = hydroshare.create_resource(
            resource_type='TimeSeriesResource',
            owner=self.user,
            title='My Test TimeSeries Resource',
            files=(self.odm2_sqlite_file_obj,)
            )
        utils.resource_post_create_actions(resource=self.resTimeSeries, user=self.user, metadata=[])

        self._test_metadata_extraction()

    def test_metadata_extraction_on_content_file_add(self):
        # test the core metadata at this point
        self.assertEquals(self.resTimeSeries.metadata.title.value, 'Test Time Series Resource')

        # there shouldn't any abstract element
        self.assertEquals(self.resTimeSeries.metadata.description, None)

        # there shouldn't any coverage element
        self.assertEquals(self.resTimeSeries.metadata.coverages.all().count(), 0)

        # there shouldn't any format element
        self.assertEquals(self.resTimeSeries.metadata.formats.all().count(), 0)

        # there shouldn't any subject element
        self.assertEquals(self.resTimeSeries.metadata.subjects.all().count(), 0)

        # there shouldn't any contributor element
        self.assertEquals(self.resTimeSeries.metadata.contributors.all().count(), 0)

        # check that there are no extended metadata elements at this point
        self.assertEquals(self.resTimeSeries.metadata.sites.all().count(), 0)
        self.assertEquals(self.resTimeSeries.metadata.variables.all().count(), 0)
        self.assertEquals(self.resTimeSeries.metadata.methods.all().count(), 0)
        self.assertEquals(self.resTimeSeries.metadata.processing_levels.all().count(), 0)
        self.assertEquals(self.resTimeSeries.metadata.time_series_results.all().count(), 0)

        # adding a valid ODM2 sqlite file should generate some core metadata and all extended metadata
        files = [UploadedFile(file=self.odm2_sqlite_file_obj, name=self.odm2_sqlite_file_name)]
        utils.resource_file_add_pre_process(resource=self.resTimeSeries, files=files, user=self.user,
                                            extract_metadata=False)

        utils.resource_file_add_process(resource=self.resTimeSeries, files=files, user=self.user,
                                        extract_metadata=True)

        self._test_metadata_extraction()

    def test_metadata_on_content_file_delete(self):
        # test that metadata is not deleted (except format element) on content file deletion
        # adding a valid ODM2 sqlite file should generate some core metadata and all extended metadata
        files = [UploadedFile(file=self.odm2_sqlite_file_obj, name=self.odm2_sqlite_file_name)]
        utils.resource_file_add_pre_process(resource=self.resTimeSeries, files=files, user=self.user,
                                            extract_metadata=False)

        utils.resource_file_add_process(resource=self.resTimeSeries, files=files, user=self.user,
                                        extract_metadata=True)

        # there should one content file
        self.assertEquals(self.resTimeSeries.files.all().count(), 1)

        # there should be one format element
        self.assertEquals(self.resTimeSeries.metadata.formats.all().count(), 1)

        # delete content file that we added above
        hydroshare.delete_resource_file(self.resTimeSeries.short_id, self.odm2_sqlite_file_name, self.user)
        # there should no content file
        self.assertEquals(self.resTimeSeries.files.all().count(), 0)

        # test the core metadata at this point
        self.assertNotEquals(self.resTimeSeries.metadata.title, None)

        # there should be an abstract element
        self.assertNotEquals(self.resTimeSeries.metadata.description, None)

        # there should be one creator element
        self.assertEquals(self.resTimeSeries.metadata.creators.all().count(), 1)

        # there should be one contributor element
        self.assertEquals(self.resTimeSeries.metadata.contributors.all().count(), 1)

        # there should be 2 coverage element -  point type and period type
        self.assertEquals(self.resTimeSeries.metadata.coverages.all().count(), 2)
        self.assertEquals(self.resTimeSeries.metadata.coverages.all().filter(type='point').count(), 1)
        self.assertEquals(self.resTimeSeries.metadata.coverages.all().filter(type='period').count(), 1)
        # there should be no format element
        self.assertEquals(self.resTimeSeries.metadata.formats.all().count(), 0)
        # there should be one subject element
        self.assertEquals(self.resTimeSeries.metadata.subjects.all().count(), 1)

        # testing extended metadata elements
        self.assertNotEquals(self.resTimeSeries.metadata.sites.all().count(), 0)
        self.assertNotEquals(self.resTimeSeries.metadata.variables.all().count(), 0)
        self.assertNotEquals(self.resTimeSeries.metadata.methods.all().count(), 0)
        self.assertNotEquals(self.resTimeSeries.metadata.processing_levels.all().count(), 0)
        self.assertNotEquals(self.resTimeSeries.metadata.time_series_results.all().count(), 0)

    def test_metadata_delete_on_resource_delete(self):
        # generate metadata by adding a valid odm2 sqlite file
        files = [UploadedFile(file=self.odm2_sqlite_file_obj, name=self.odm2_sqlite_file_name)]
        utils.resource_file_add_pre_process(resource=self.resTimeSeries, files=files, user=self.user,
                                            extract_metadata=False)

        utils.resource_file_add_process(resource=self.resTimeSeries, files=files, user=self.user,
                                        extract_metadata=True)

        # before resource delete
        core_metadata_obj = self.resTimeSeries.metadata
        self.assertEquals(CoreMetaData.objects.all().count(), 1)
        # there should be Creator metadata objects
        self.assertTrue(Creator.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be Contributor metadata objects
        self.assertTrue(Contributor.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be Identifier metadata objects
        self.assertTrue(Identifier.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be Type metadata objects
        self.assertTrue(Type.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Source metadata objects
        self.assertFalse(Source.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Relation metadata objects
        self.assertFalse(Relation.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Publisher metadata objects
        self.assertFalse(Publisher.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be Title metadata objects
        self.assertTrue(Title.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be Description (Abstract) metadata objects
        self.assertTrue(Description.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be Date metadata objects
        self.assertTrue(Date.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be Subject metadata objects
        self.assertTrue(Subject.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be Coverage metadata objects
        self.assertTrue(Coverage.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be Format metadata objects
        self.assertTrue(Format.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be Language metadata objects
        self.assertTrue(Language.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be Rights metadata objects
        self.assertTrue(Rights.objects.filter(object_id=core_metadata_obj.id).exists())

        # resource specific metadata
        # there should be Site metadata objects
        self.assertTrue(Site.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be Variable metadata objects
        self.assertTrue(Variable.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be Method metadata objects
        self.assertTrue(Method.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be ProcessingLevel metadata objects
        self.assertTrue(ProcessingLevel.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be TimeSeriesResult metadata objects
        self.assertTrue(TimeSeriesResult.objects.filter(object_id=core_metadata_obj.id).exists())

        # delete resource
        hydroshare.delete_resource(self.resTimeSeries.short_id)
        self.assertEquals(CoreMetaData.objects.all().count(), 0)

        # there should be no Creator metadata objects
        self.assertFalse(Creator.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Contributor metadata objects
        self.assertFalse(Contributor.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Identifier metadata objects
        self.assertFalse(Identifier.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Type metadata objects
        self.assertFalse(Type.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Source metadata objects
        self.assertFalse(Source.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Relation metadata objects
        self.assertFalse(Relation.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Publisher metadata objects
        self.assertFalse(Publisher.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Title metadata objects
        self.assertFalse(Title.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Description (Abstract) metadata objects
        self.assertFalse(Description.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Date metadata objects
        self.assertFalse(Date.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Subject metadata objects
        self.assertFalse(Subject.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Coverage metadata objects
        self.assertFalse(Coverage.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Format metadata objects
        self.assertFalse(Format.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Language metadata objects
        self.assertFalse(Language.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Rights metadata objects
        self.assertFalse(Rights.objects.filter(object_id=core_metadata_obj.id).exists())

        # resource specific metadata
        # there should be no Site metadata objects
        self.assertFalse(Site.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Variable metadata objects
        self.assertFalse(Variable.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no Method metadata objects
        self.assertFalse(Method.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no ProcessingLevel metadata objects
        self.assertFalse(ProcessingLevel.objects.filter(object_id=core_metadata_obj.id).exists())
        # there should be no TimeSeriesResult metadata objects
        self.assertFalse(TimeSeriesResult.objects.filter(object_id=core_metadata_obj.id).exists())

        # TODO: check the deletion of CV lookup objects

    def test_extended_metadata_CRUD(self):
        # create
        self.assertEquals(self.resTimeSeries.metadata.is_dirty, False)
        self.assertEquals(self.resTimeSeries.metadata.sites.all().count(), 0)
        self.resTimeSeries.metadata.create_element('site', series_ids=['a456789-89yughys'],  site_code='LR_WaterLab_AA',
                                                   site_name='Logan River at the Utah Water Research Laboratory '
                                                             'west bridge', elevation_m=1414, elevation_datum='EGM96',
                                                   site_type='Stream')

        site_element = self.resTimeSeries.metadata.sites.all().first()
        self.assertEqual(len(site_element.series_ids), 1)
        self.assertIn('a456789-89yughys', site_element.series_ids)
        self.assertEquals(site_element.site_code, 'LR_WaterLab_AA')
        self.assertEquals(site_element.site_name, 'Logan River at the Utah Water Research Laboratory west bridge')
        self.assertEquals(site_element.elevation_m, 1414)
        self.assertEquals(site_element.elevation_datum, 'EGM96')
        self.assertEquals(site_element.site_type, 'Stream')
        self.assertEquals(site_element.is_dirty, False)

        self.assertEquals(self.resTimeSeries.metadata.is_dirty, False)

        self.assertEquals(self.resTimeSeries.metadata.variables.all().count(), 0)
        self.resTimeSeries.metadata.create_element('variable', series_ids=['a456789-89yughys'], variable_code='ODO',
                                                   variable_name='Oxygen, dissolved',
                                                   variable_type='Concentration', no_data_value=-9999,
                                                   variable_definition='Concentration of oxygen gas dissolved in '
                                                                       'water.', speciation='Not Applicable')

        variable_element = self.resTimeSeries.metadata.variables.all().first()
        self.assertEqual(len(variable_element.series_ids), 1)
        self.assertIn('a456789-89yughys', variable_element.series_ids)
        self.assertEquals(variable_element.variable_code, 'ODO')
        self.assertEquals(variable_element.variable_name, 'Oxygen, dissolved')
        self.assertEquals(variable_element.variable_type, 'Concentration')
        self.assertEquals(variable_element.no_data_value, -9999)
        self.assertEquals(variable_element.variable_definition, 'Concentration of oxygen gas dissolved in water.')
        self.assertEquals(variable_element.speciation, 'Not Applicable')
        self.assertEquals(variable_element.is_dirty, False)

        self.assertEquals(self.resTimeSeries.metadata.is_dirty, False)

        self.assertEquals(self.resTimeSeries.metadata.methods.all().count(), 0)
        self.resTimeSeries.metadata.create_element('method', series_ids=['a456789-89yughys'], method_code='Code59',
                                                   method_name='Optical DO',
                                                   method_type='Instrument deployment',
                                                   method_description='Dissolved oxygen concentration measured '
                                                                      'optically using a YSI EXO multi-parameter water '
                                                                      'quality sonde.',
                                                   method_link='http://www.exowater.com')

        method_element = self.resTimeSeries.metadata.methods.all().first()
        self.assertEqual(len(method_element.series_ids), 1)
        self.assertIn('a456789-89yughys', method_element.series_ids)
        self.assertEquals(method_element.method_code, 'Code59')
        self.assertEquals(method_element.method_name, 'Optical DO')
        self.assertEquals(method_element.method_type, 'Instrument deployment')
        method_desc = 'Dissolved oxygen concentration measured optically using a YSI EXO multi-parameter water ' \
                      'quality sonde.'
        self.assertEquals(method_element.method_description, method_desc)
        self.assertEquals(method_element.method_link, 'http://www.exowater.com')
        self.assertEquals(method_element.is_dirty, False)

        self.assertEquals(self.resTimeSeries.metadata.is_dirty, False)

        self.assertEquals(self.resTimeSeries.metadata.processing_levels.all().count(), 0)
        exp_text = """Raw and unprocessed data and data products that have not undergone quality control.
        Depending on the variable, data type, and data transmission system, raw data may be available within seconds
        or minutes after the measurements have been made. Examples include real time precipitation, streamflow and
        water quality measurements."""
        self.resTimeSeries.metadata.create_element('processinglevel', series_ids=['a456789-89yughys'],
                                                   processing_level_code=0, definition='Raw data',
                                                   explanation=exp_text)

        proc_level_element = self.resTimeSeries.metadata.processing_levels.all().first()
        self.assertEqual(len(proc_level_element.series_ids), 1)
        self.assertIn('a456789-89yughys', proc_level_element.series_ids)
        self.assertEquals(proc_level_element.processing_level_code, 0)
        self.assertEquals(proc_level_element.definition, 'Raw data')
        self.assertEquals(proc_level_element.explanation, exp_text)
        self.assertEquals(proc_level_element.is_dirty, False)

        self.assertEquals(self.resTimeSeries.metadata.is_dirty, False)

        self.assertEquals(self.resTimeSeries.metadata.time_series_results.all().count(), 0)
        self.resTimeSeries.metadata.create_element('timeseriesresult', series_ids=['a456789-89yughys'],
                                                   units_type='Concentration',
                                                   units_name='milligrams per liter', units_abbreviation='mg/L',
                                                   status='Complete', sample_medium='Surface water', value_count=11283,
                                                   aggregation_statistics="Average")

        ts_result_element = self.resTimeSeries.metadata.time_series_results.all().first()
        self.assertEqual(len(ts_result_element.series_ids), 1)
        self.assertIn('a456789-89yughys', ts_result_element.series_ids)
        self.assertEquals(ts_result_element.units_type, 'Concentration')
        self.assertEquals(ts_result_element.units_name, 'milligrams per liter')
        self.assertEquals(ts_result_element.units_abbreviation, 'mg/L')
        self.assertEquals(ts_result_element.status, 'Complete')
        self.assertEquals(ts_result_element.sample_medium, 'Surface water')
        self.assertEquals(ts_result_element.value_count, 11283)
        self.assertEquals(ts_result_element.aggregation_statistics, 'Average')
        self.assertEquals(ts_result_element.is_dirty, False)

        self.assertEquals(self.resTimeSeries.metadata.is_dirty, False)

        # update
        self.resTimeSeries.metadata.update_element('site', self.resTimeSeries.metadata.sites.all().first().id,
                                                   site_code='LR_WaterLab_BB',
                                                   site_name='Logan River at the Utah WRL '
                                                             'west bridge', elevation_m=1515, elevation_datum='EGM97',
                                                   site_type='Stream flow')

        site_element = self.resTimeSeries.metadata.sites.all().first()
        self.assertEquals(site_element.site_code, 'LR_WaterLab_BB')
        self.assertEquals(site_element.site_name, 'Logan River at the Utah WRL west bridge')
        self.assertEquals(site_element.elevation_m, 1515)
        self.assertEquals(site_element.elevation_datum, 'EGM97')
        self.assertEquals(site_element.site_type, 'Stream flow')
        self.assertEquals(site_element.is_dirty, True)

        # since there is no sqlite file for the resource, the 'is_dirty' flag of metadata still be False
        self.assertEquals(self.resTimeSeries.files.all().count(), 0)
        self.assertEquals(self.resTimeSeries.metadata.is_dirty, False)

        self.resTimeSeries.metadata.update_element('variable', self.resTimeSeries.metadata.variables.all().first().id,
                                                   variable_code='ODO-1', variable_name='H2O dissolved',
                                                   variable_type='Concentration-1', no_data_value=-999,
                                                   variable_definition='Concentration of oxygen dissolved in '
                                                                       'water.', speciation='Applicable')

        variable_element = self.resTimeSeries.metadata.variables.all().first()
        self.assertEquals(variable_element.variable_code, 'ODO-1')
        self.assertEquals(variable_element.variable_name, 'H2O dissolved')
        self.assertEquals(variable_element.variable_type, 'Concentration-1')
        self.assertEquals(variable_element.no_data_value, -999)
        self.assertEquals(variable_element.variable_definition, 'Concentration of oxygen dissolved in water.')
        self.assertEquals(variable_element.speciation, 'Applicable')
        self.assertEquals(variable_element.is_dirty, True)

        self.assertEquals(self.resTimeSeries.metadata.is_dirty, False)

        method_desc = 'Dissolved oxygen concentration measured optically using a YSI EXO multi-parameter water ' \
                      'quality sonde-1.'
        self.resTimeSeries.metadata.update_element('method', self.resTimeSeries.metadata.methods.all().first().id,
                                                   method_code='Code 69',
                                                   method_name='Optical DO-1',
                                                   method_type='Instrument deployment-1',
                                                   method_description=method_desc,
                                                   method_link='http://www.ex-water.com')

        method_element = self.resTimeSeries.metadata.methods.all().first()
        self.assertEquals(method_element.method_code, 'Code 69')
        self.assertEquals(method_element.method_name, 'Optical DO-1')
        self.assertEquals(method_element.method_type, 'Instrument deployment-1')

        self.assertEquals(method_element.method_description, method_desc)
        self.assertEquals(method_element.method_link, 'http://www.ex-water.com')
        self.assertEquals(method_element.is_dirty, True)

        self.assertEquals(self.resTimeSeries.metadata.is_dirty, False)

        self.resTimeSeries.metadata.update_element('processinglevel',
                                                   self.resTimeSeries.metadata.processing_levels.all().first().id,
                                                   processing_level_code=9, definition='data',
                                                   explanation=exp_text + 'some more text')

        proc_level_element = self.resTimeSeries.metadata.processing_levels.all().first()
        self.assertEquals(proc_level_element.processing_level_code, 9)
        self.assertEquals(proc_level_element.definition, 'data')
        self.assertEquals(proc_level_element.explanation, exp_text + 'some more text')
        self.assertEquals(proc_level_element.is_dirty, True)

        self.assertEquals(self.resTimeSeries.metadata.is_dirty, False)

        self.resTimeSeries.metadata.update_element('timeseriesresult',
                                                   self.resTimeSeries.metadata.time_series_results.all().first().id,
                                                   units_type='Concentration-1',
                                                   units_name='milligrams per GL', units_abbreviation='mg/GL',
                                                   status='Incomplete', sample_medium='Fresh water', value_count=11211,
                                                   aggregation_statistics="Mean")

        ts_result_element = self.resTimeSeries.metadata.time_series_results.all().first()
        self.assertEquals(ts_result_element.units_type, 'Concentration-1')
        self.assertEquals(ts_result_element.units_name, 'milligrams per GL')
        self.assertEquals(ts_result_element.units_abbreviation, 'mg/GL')
        self.assertEquals(ts_result_element.status, 'Incomplete')
        self.assertEquals(ts_result_element.sample_medium, 'Fresh water')
        self.assertEquals(ts_result_element.value_count, 11211)
        self.assertEquals(ts_result_element.aggregation_statistics, 'Mean')
        self.assertEquals(ts_result_element.is_dirty, True)

        self.assertEquals(self.resTimeSeries.metadata.is_dirty, False)

        # delete
        # extended metadata deletion is not allowed - should raise exception
        with self.assertRaises(ValidationError):
            self.resTimeSeries.metadata.delete_element('site', self.resTimeSeries.metadata.sites.all().first().id)

        with self.assertRaises(ValidationError):
            self.resTimeSeries.metadata.delete_element('variable',
                                                       self.resTimeSeries.metadata.variables.all().first().id)

        with self.assertRaises(ValidationError):
            self.resTimeSeries.metadata.delete_element('method', self.resTimeSeries.metadata.methods.all().first().id)

        with self.assertRaises(ValidationError):
            self.resTimeSeries.metadata.delete_element('processinglevel',
                                                       self.resTimeSeries.metadata.processing_levels.all().first().id)
        with self.assertRaises(ValidationError):
            self.resTimeSeries.metadata.delete_element('timeseriesresult',
                                                       self.resTimeSeries.metadata.time_series_results.all().first().id)

    def test_metadata_is_dirty_flag(self):
        # resource.metadata.is_dirty flag be set to True if any of the resource specific metadata elements
        # is updated when the resource has a sqlite file

        # create a resource with uploded sqlite file
        self.odm2_sqlite_file_obj = open(self.odm2_sqlite_file, 'r')

        self.resTimeSeries = hydroshare.create_resource(
            resource_type='TimeSeriesResource',
            owner=self.user,
            title='My Test TimeSeries Resource',
            files=(self.odm2_sqlite_file_obj,)
            )
        utils.resource_post_create_actions(resource=self.resTimeSeries, user=self.user, metadata=[])

        # at this point the is_dirty be set to false
        self.assertEquals(self.resTimeSeries.metadata.is_dirty, False)
        site = self.resTimeSeries.metadata.sites.all().first()
        self.assertEquals(site.is_dirty, False)
        # now update the site element
        self.resTimeSeries.metadata.update_element('site', site.id,
                                                   site_code='LR_WaterLab_BB',
                                                   site_name='Logan River at the Utah WRL west bridge',
                                                   elevation_m=1515,
                                                   elevation_datum=site.elevation_datum,
                                                   site_type=site.site_type)

        site = self.resTimeSeries.metadata.sites.all().first()
        self.assertEquals(site.is_dirty, True)
        # at this point the is_dirty must be true
        self.assertEquals(self.resTimeSeries.metadata.is_dirty, True)
        site.is_dirty = False
        site.save()
        site = self.resTimeSeries.metadata.sites.all().first()
        self.assertEquals(site.is_dirty, False)
        # at this point the is_dirty must be true
        self.assertEquals(self.resTimeSeries.metadata.is_dirty, False)

        # TODO: test updating other elements

    def test_cv_lookup_tables(self):
        # TODO:
        # Here we will test that when new CV terms are used for updating metadata elements, there should be
        # new records added to the corresponding CV table (Django db table)
        pass

    def test_get_xml(self):
        # add a valid odm2 sqlite file to generate metadata
        files = [UploadedFile(file=self.odm2_sqlite_file_obj, name=self.odm2_sqlite_file_name)]
        utils.resource_file_add_pre_process(resource=self.resTimeSeries, files=files, user=self.user,
                                            extract_metadata=False)

        utils.resource_file_add_process(resource=self.resTimeSeries, files=files, user=self.user,
                                        extract_metadata=True)

        # test if xml from get_xml() is well formed
        ET.fromstring(self.resTimeSeries.metadata.get_xml())

    def test_multiple_content_files(self):
        self.assertFalse(TimeSeriesResource.can_have_multiple_files())

    def test_public_or_discoverable(self):
        self.assertFalse(self.resTimeSeries.has_required_content_files())
        self.assertFalse(self.resTimeSeries.metadata.has_all_required_elements())
        self.assertFalse(self.resTimeSeries.can_be_public_or_discoverable)

        # adding a valid ODM2 sqlite file should generate required core metadata and all extended metadata
        files = [UploadedFile(file=self.odm2_sqlite_file_obj, name=self.odm2_sqlite_file_name)]
        utils.resource_file_add_pre_process(resource=self.resTimeSeries, files=files, user=self.user,
                                            extract_metadata=False)

        utils.resource_file_add_process(resource=self.resTimeSeries, files=files, user=self.user,
                                        extract_metadata=True)

        self.assertTrue(self.resTimeSeries.has_required_content_files())
        self.assertTrue(self.resTimeSeries.metadata.has_all_required_elements())
        self.assertTrue(self.resTimeSeries.can_be_public_or_discoverable)

    def _test_metadata_extraction(self):
        # there should one content file
        self.assertEquals(self.resTimeSeries.files.all().count(), 1)

        # there should be one contributor element
        self.assertEquals(self.resTimeSeries.metadata.contributors.all().count(), 1)

        # test core metadata after metadata extraction
        extracted_title = "Water temperature in the Little Bear River at Mendon Road near Mendon, UT"
        self.assertEquals(self.resTimeSeries.metadata.title.value, extracted_title)

        # there should be an abstract element
        self.assertNotEquals(self.resTimeSeries.metadata.description, None)
        extracted_abstract = "This dataset contains observations of water temperature in the Little Bear River at " \
                             "Mendon Road near Mendon, UT. Data were recorded every 30 minutes. The values were " \
                             "recorded using a HydroLab MS5 multi-parameter water quality sonde connected to a " \
                             "Campbell Scientific datalogger. Values represent quality controlled data that have " \
                             "undergone quality control to remove obviously bad data."
        self.assertEquals(self.resTimeSeries.metadata.description.abstract, extracted_abstract)

        # there should be 2 coverage element -  point type and period type
        self.assertEquals(self.resTimeSeries.metadata.coverages.all().count(), 2)
        self.assertEquals(self.resTimeSeries.metadata.coverages.all().filter(type='point').count(), 1)
        self.assertEquals(self.resTimeSeries.metadata.coverages.all().filter(type='period').count(), 1)

        point_coverage = self.resTimeSeries.metadata.coverages.all().filter(type='point').first()
        self.assertEquals(point_coverage.value['projection'], 'Unknown')
        self.assertEquals(point_coverage.value['units'], 'Decimal degrees')
        self.assertEquals(point_coverage.value['east'], -111.946402)
        self.assertEquals(point_coverage.value['north'], 41.718473)

        temporal_coverage = self.resTimeSeries.metadata.coverages.all().filter(type='period').first()
        self.assertEquals(parser.parse(temporal_coverage.value['start']).date(), parser.parse('01/01/2008').date())
        self.assertEquals(parser.parse(temporal_coverage.value['end']).date(), parser.parse('01/31/2008').date())

        # there should be one format element
        self.assertEquals(self.resTimeSeries.metadata.formats.all().count(), 1)
        format_element = self.resTimeSeries.metadata.formats.all().first()
        self.assertEquals(format_element.value, 'application/sqlite')

        # there should be one subject element
        self.assertEquals(self.resTimeSeries.metadata.subjects.all().count(), 1)
        subj_element = self.resTimeSeries.metadata.subjects.all().first()
        self.assertEquals(subj_element.value, 'Temperature')

        # testing extended metadata elements
        self.assertNotEquals(self.resTimeSeries.metadata.sites.all().count(), 0)
        site = self.resTimeSeries.metadata.sites.all().first()
        # there should be only 1 series id
        self.assertEqual(len(site.series_ids), 1)
        self.assertIn('eaa89194-3638-11e5-9955-6c4008bf018e', site.series_ids)
        self.assertEquals(self.resTimeSeries.metadata.sites.all().first().site_code, 'USU-LBR-Mendon')
        site_name = 'Little Bear River at Mendon Road near Mendon, Utah'
        self.assertEquals(self.resTimeSeries.metadata.sites.all().first().site_name, site_name)
        self.assertEquals(self.resTimeSeries.metadata.sites.all().first().elevation_m, 1345)
        self.assertEquals(self.resTimeSeries.metadata.sites.all().first().elevation_datum, 'NGVD29')
        self.assertEquals(self.resTimeSeries.metadata.sites.all().first().site_type, 'Stream')

        self.assertNotEquals(self.resTimeSeries.metadata.variables.all().count(), 0)
        variable = self.resTimeSeries.metadata.variables.all().first()
        # there should be only 1 series id
        self.assertEqual(len(variable.series_ids), 1)
        self.assertIn('eaa89194-3638-11e5-9955-6c4008bf018e', variable.series_ids)
        self.assertEquals(self.resTimeSeries.metadata.variables.all().first().variable_code, 'USU36')
        self.assertEquals(self.resTimeSeries.metadata.variables.all().first().variable_name, 'Temperature')
        self.assertEquals(self.resTimeSeries.metadata.variables.all().first().variable_type, 'Water Quality')
        self.assertEquals(self.resTimeSeries.metadata.variables.all().first().no_data_value, -9999)
        self.assertEquals(self.resTimeSeries.metadata.variables.all().first().variable_definition, None)
        self.assertEquals(self.resTimeSeries.metadata.variables.all().first().speciation, 'Not Applicable')

        self.assertNotEquals(self.resTimeSeries.metadata.methods.all().count(), 0)
        method = self.resTimeSeries.metadata.methods.all().first()
        # there should be only 1 series id
        self.assertEqual(len(method.series_ids), 1)
        self.assertIn('eaa89194-3638-11e5-9955-6c4008bf018e', method.series_ids)
        self.assertEquals(self.resTimeSeries.metadata.methods.all().first().method_code, '28')
        method_name = 'Quality Control Level 1 Data Series created from raw QC Level 0 data using ODM Tools.'
        self.assertEquals(self.resTimeSeries.metadata.methods.all().first().method_name, method_name)
        self.assertEquals(self.resTimeSeries.metadata.methods.all().first().method_type, 'Instrument deployment')
        method_des = 'Quality Control Level 1 Data Series created from raw QC Level 0 data using ODM Tools.'
        self.assertEquals(self.resTimeSeries.metadata.methods.all().first().method_description, method_des)
        self.assertEquals(self.resTimeSeries.metadata.methods.all().first().method_link, None)

        self.assertNotEquals(self.resTimeSeries.metadata.processing_levels.all().count(), 0)
        proc_level = self.resTimeSeries.metadata.processing_levels.all().first()
        # there should be only 1 series id
        self.assertEqual(len(proc_level.series_ids), 1)
        self.assertIn('eaa89194-3638-11e5-9955-6c4008bf018e', proc_level.series_ids)
        self.assertEquals(self.resTimeSeries.metadata.processing_levels.all().first().processing_level_code, 1)
        self.assertEquals(self.resTimeSeries.metadata.processing_levels.all().first().definition,
                          'Quality controlled data')
        explanation = 'Quality controlled data that have passed quality assurance procedures such as ' \
                      'routine estimation of timing and sensor calibration or visual inspection and removal ' \
                      'of obvious errors. An example is USGS published streamflow records following parsing ' \
                      'through USGS quality control procedures.'
        self.assertEquals(self.resTimeSeries.metadata.processing_levels.all().first().explanation, explanation)

        self.assertNotEquals(self.resTimeSeries.metadata.time_series_results.all().count(), 0)
        ts_result = self.resTimeSeries.metadata.time_series_results.all().first()
        # there should be only 1 series id
        self.assertEqual(len(ts_result.series_ids), 1)
        self.assertIn('eaa89194-3638-11e5-9955-6c4008bf018e', ts_result.series_ids)

        self.assertEquals(self.resTimeSeries.metadata.time_series_results.all().first().units_type, 'Temperature')
        self.assertEquals(self.resTimeSeries.metadata.time_series_results.all().first().units_name, 'degree celsius')
        self.assertEquals(self.resTimeSeries.metadata.time_series_results.all().first().units_abbreviation, 'degC')
        self.assertEquals(self.resTimeSeries.metadata.time_series_results.all().first().status, 'Unknown')
        self.assertEquals(self.resTimeSeries.metadata.time_series_results.all().first().sample_medium, 'Surface Water')
        self.assertEquals(self.resTimeSeries.metadata.time_series_results.all().first().value_count, 1441)
        self.assertEquals(self.resTimeSeries.metadata.time_series_results.all().first().aggregation_statistics,
                          'Average')