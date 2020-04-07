//
//  MP4ParserAtomDataTests.m
//  Tests
//
//  Created by Alexey Yakovenko on 4/7/20.
//  Copyright © 2020 Alexey Yakovenko. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "mp4patomdata.h"

@interface MP4ParserAtomDataTests : XCTestCase

@end

@implementation MP4ParserAtomDataTests

- (void)test_mvhdWriteRead_EqualOutput {
    mp4p_mvhd_t data = {
        .ch.version_flags = 0xaabbccdd,
        .creation_time = 0xddccbbaa,
        .modification_time = 0x11223344,
        .time_scale = 0x44332211,
        .duration = 0xeebbaadd,
        .preferred_rate = 0xddaabbee,
        .preferred_volume = 0x2345,
        .reserved = "10b_filler",
        .matrix_structure = "36 bytes filler1234567890abcdefghijk",
        .preview_time = 0x98765432,
        .preview_duration = 0x23456789,
        .poster_time = 0x56789abc,
        .selection_time = 0xcba98765,
        .selection_duration = 0xabcdef01,
        .current_time = 0x10fedcba,
        .next_track_id = 0x33337777,
    };


    size_t bufsize = mp4p_mvhd_atomdata_write(&data, NULL, 0);
    uint8_t *buffer = malloc (bufsize);
    size_t writtensize = mp4p_mvhd_atomdata_write(&data, buffer, bufsize);
    XCTAssertEqual (bufsize, writtensize);

    mp4p_mvhd_t dataread;
    int res = mp4p_mvhd_atomdata_read(&dataread, buffer, bufsize);
    XCTAssert(!res);

    XCTAssert(!memcmp (&dataread, &data, sizeof (data)));
}

- (void)test_tkhdWriteRead_EqualOutput {
    mp4p_tkhd_t data = {
        .ch.version_flags = 0xaabbccdd,
        .creation_time = 0xddccbbaa,
        .modification_time = 0x11223344,
        .track_id = 0x44332211,
        .reserved = "3bf",
        .duration = 0xeebbaadd,
        .reserved2 = "abcghj7",
        .layer = 0x2345,
        .alternate_group = 0x1199,
        .volume = 0x5678,
        .reserved3 = "f",
        .matrix_structure = "36 bytes filler1234567890abcdefghij",
        .track_width = 0x74651029,
        .track_height = 0x56473829,
    };

    size_t bufsize = mp4p_tkhd_atomdata_write(&data, NULL, 0);
    uint8_t *buffer = malloc (bufsize);
    size_t writtensize = mp4p_tkhd_atomdata_write(&data, buffer, bufsize);
    XCTAssertEqual (bufsize, writtensize);

    mp4p_tkhd_t dataread;
    int res = mp4p_tkhd_atomdata_read(&dataread, buffer, bufsize);
    XCTAssert(!res);

    XCTAssert(!memcmp (&dataread, &data, sizeof (data)));
}
@end
