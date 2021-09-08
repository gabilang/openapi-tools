/*
 *  Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */
package io.ballerina.openapi.generators.openapi;

import io.ballerina.openapi.converter.OpenApiConverterException;
import org.testng.annotations.Test;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * This test class for the resolve reference in the other module in ballerina package.
 */
public class ModuleReferenceTests {
    private static final Path RES_DIR = Paths.get(
            "src/test/resources/ballerina-to-openapi/ballerina-project/service").toAbsolutePath();

    @Test(description = "Response with separate modules")
    public void testResponse01() throws OpenApiConverterException, IOException {
        Path ballerinaFilePath = RES_DIR.resolve("snowpeak.bal");
        new TestUtils().compareWithGeneratedFile(ballerinaFilePath, "snowpeak.yaml");
    }
}