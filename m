Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AFA4EB023
	for <lists+linux-can@lfdr.de>; Tue, 29 Mar 2022 17:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbiC2PYH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Mar 2022 11:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiC2PYG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Mar 2022 11:24:06 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB6B205BD7
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 08:22:21 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id 5-20020a92c645000000b002c99d83806dso4258879ill.13
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 08:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rJF02FUqA+BGhfpQq15X1gdE3Vmrsf58Y4lCUEm8TvI=;
        b=R47xhKAmCZfoPH85hVK60PrABx5BddgIuMoOzJksZ6GnjR2UKZ/4P/osB8TYywkXVP
         nrg1/SLP6CEqZ1e6ga1KFhLXbxkbxenm68ZTDP1kH55//RZHTYg7RO9toEgsnddesZ6Q
         JM1t/kzmudKpPMf7faRIDcENo0M0twqtBit2uoQMGrntkeNSBUqis1L4XNQDvPfqPyt4
         FO8es/A55I1i/POtcaO3+MjTnrlznI+qTwiF0lNWeIHbhENzgGI2O//q7OuoyIdIKvHd
         kJmN0NiHAGATNFOFwG3JjWRYyCILMyXLW8vsncjJWztMFE+fuRbLm+rlbHY54tVstQRh
         eKyA==
X-Gm-Message-State: AOAM533PMAsM5OrrWToTGpdaHsmFH8cDRYwRsi7lP9BUq237znd18aDK
        ntD9jQQoIZnSisnEfwd0yl+XBD5Ia1JBrWDPtNLVrLCApZF4
X-Google-Smtp-Source: ABdhPJwEhecZIWBhxu8UENb5AeqD1ufIoK+sgyDfNUmc7z61COVL6a53khHIMSakMoWjBb+RJewOyFGLdk2Xc4iTXNnNiCEpnWLN
MIME-Version: 1.0
X-Received: by 2002:a02:5b85:0:b0:319:ff85:ff5 with SMTP id
 g127-20020a025b85000000b00319ff850ff5mr17038951jab.250.1648567340853; Tue, 29
 Mar 2022 08:22:20 -0700 (PDT)
Date:   Tue, 29 Mar 2022 08:22:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd6ee505db5cfec6@google.com>
Subject: [syzbot] memory leak in gs_usb_probe
From:   syzbot <syzbot+4d0ae90a195b269f102d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, mkl@pengutronix.de,
        netdev@vger.kernel.org, pabeni@redhat.com, pfink@christ-es.de,
        syzkaller-bugs@googlegroups.com, wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    52deda9551a0 Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b472dd700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ca2a67ddb20027f
dashboard link: https://syzkaller.appspot.com/bug?extid=4d0ae90a195b269f102d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e96e1d700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f8b513700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d0ae90a195b269f102d@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810e4fc300 (size 96):
  comm "kworker/1:1", pid 25, jiffies 4294948102 (age 15.080s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff843fcc08>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff843fcc08>] gs_make_candev drivers/net/can/usb/gs_usb.c:1065 [inline]
    [<ffffffff843fcc08>] gs_usb_probe.cold+0x69e/0x8b8 drivers/net/can/usb/gs_usb.c:1191
    [<ffffffff82d0a687>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<ffffffff82712d87>] call_driver_probe drivers/base/dd.c:517 [inline]
    [<ffffffff82712d87>] really_probe.part.0+0xe7/0x380 drivers/base/dd.c:596
    [<ffffffff8271312c>] really_probe drivers/base/dd.c:558 [inline]
    [<ffffffff8271312c>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:755
    [<ffffffff8271322a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:785
    [<ffffffff82713a96>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:902
    [<ffffffff8270fcf7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82713612>] __device_attach+0x122/0x260 drivers/base/dd.c:973
    [<ffffffff82711966>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8270dd4b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3405
    [<ffffffff82d07ac2>] usb_set_configuration+0x8f2/0xb80 drivers/usb/core/message.c:2170
    [<ffffffff82d181ac>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d09d5c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82712d87>] call_driver_probe drivers/base/dd.c:517 [inline]
    [<ffffffff82712d87>] really_probe.part.0+0xe7/0x380 drivers/base/dd.c:596
    [<ffffffff8271312c>] really_probe drivers/base/dd.c:558 [inline]
    [<ffffffff8271312c>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:755
    [<ffffffff8271322a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:785

BUG: memory leak
unreferenced object 0xffff88810e4fc280 (size 96):
  comm "kworker/1:1", pid 25, jiffies 4294948819 (age 7.910s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff843fcc08>] kmalloc include/linux/slab.h:581 [inline]
    [<ffffffff843fcc08>] gs_make_candev drivers/net/can/usb/gs_usb.c:1065 [inline]
    [<ffffffff843fcc08>] gs_usb_probe.cold+0x69e/0x8b8 drivers/net/can/usb/gs_usb.c:1191
    [<ffffffff82d0a687>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<ffffffff82712d87>] call_driver_probe drivers/base/dd.c:517 [inline]
    [<ffffffff82712d87>] really_probe.part.0+0xe7/0x380 drivers/base/dd.c:596
    [<ffffffff8271312c>] really_probe drivers/base/dd.c:558 [inline]
    [<ffffffff8271312c>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:755
    [<ffffffff8271322a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:785
    [<ffffffff82713a96>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:902
    [<ffffffff8270fcf7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff82713612>] __device_attach+0x122/0x260 drivers/base/dd.c:973
    [<ffffffff82711966>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8270dd4b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3405
    [<ffffffff82d07ac2>] usb_set_configuration+0x8f2/0xb80 drivers/usb/core/message.c:2170
    [<ffffffff82d181ac>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d09d5c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff82712d87>] call_driver_probe drivers/base/dd.c:517 [inline]
    [<ffffffff82712d87>] really_probe.part.0+0xe7/0x380 drivers/base/dd.c:596
    [<ffffffff8271312c>] really_probe drivers/base/dd.c:558 [inline]
    [<ffffffff8271312c>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:755
    [<ffffffff8271322a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:785



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
