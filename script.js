/* THIS FILES IS INTENED TO BE USED WITH NODE.JS.
  THE PURPOSE OF THE SCRIPT IS TO CONCATENATE MULTIPLE LIBRARY FILES INTO A SINGLE GILE
 */

var concat = require('concat-files');

createrMockLib()

/* HELPER METHODS */

/* Creates the rMock library */
function createrMockLib() {

  concat([
    'source/library/Actions.brs',
    'source/library/Expectation.brs',
    'source/library/Mock.brs',
    'source/Utils/arrayUtils.brs',
    'source/Utils/cloneObject.brs',
    'source/Utils/generalUtils.brs',
  ], 'source/rMock.brs', concatError );

}

/* Error handler for concat
   @param object error
*/
function concatError( err ) {
  if (err) throw err
  console.log('done');
}
