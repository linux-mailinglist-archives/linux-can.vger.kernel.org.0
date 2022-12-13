Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB2C64B0B7
	for <lists+linux-can@lfdr.de>; Tue, 13 Dec 2022 09:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiLMIES (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Dec 2022 03:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiLMIER (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Dec 2022 03:04:17 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCE565BA
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 00:04:15 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 047A3240028
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 09:04:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1670918654; bh=l1E6c+CjQaku+aZwkCOuVELnsuMHey1ytecaFQLg3O8=;
        h=From:To:Subject:Date:From;
        b=TvPYo7cDXfftfArf0qbJduW/f++8tf6cpCmMrKf1k95AEVEdVw9QyXkx2wci+ufw7
         +V/bk6Q7B/Lk3loiRceDqvCAl2ao1V9AjWfs9PVMc/UwXxaT6Fn76scfe5akn5Od0f
         BuIBtFw5hzLa6ljoiI20lodVWMjrcnyjwtf0IvWs1mSoA0tJjSKEx0r9l/9OJYwOVr
         pL3BdlE5FPlzF17E3iuQvX1YTk3m6EeeLM4iy7bBZqNCK2uo6b9nSZ1lQzqmchywdx
         NONbXi4uUgX7UUz2ABskvVX5E5aRnILVHrKQrNh6iffXxW6xX5wztPPUwH3/haD2sR
         sMVB6shQ70vcQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NWWH141h0z6tmV
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 09:04:13 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Subject: [PATCH v3 0/7] can: peak_usb: Introduce configurable CAN channel ID
Date:   Tue, 13 Dec 2022 08:03:02 +0000
Message-Id: <20221213080309.9013-1-lukas.magel@posteo.net>
In-Reply-To: <20220801080446.36374-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
Reply-To: Lukas Magel <lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series of patches introduces the CAN channel ID for the PEAK USB
CAN interfaces. The id can be read/written via ethtool and is exposed as
a read-only attribute via sysfs. This allows users to set the id via
ethtool and write udev rules to match against the sysfs attribute.

Part of the patches were originally introduced by Stéphane Grosjean and
were modified slightly. See the following threads for the original patches:

* https://lore.kernel.org/linux-can/20220128150157.1222850-1-s.grosjean@peak-system.com/T/#mad8014c9f1c89a50d5944a50ae0a585edec79eab
* https://lore.kernel.org/linux-can/20211117150132.37056-1-s.grosjean@peak-system.com/T/#mbf1d7db8433734a1fe08868d79f9927a04fe7ffe

v3:
* Fix the issues raised on netdev
* Rename user device ID to CAN channel ID to make the 1-to-N mapping
  between USB device and exposed CAN channels more obvious

v2:
* Fix type of devid_le in ethtool peak_usb_(get|set)_eeprom
* Fix signed-off tags

Stéphane Grosjean (5):
  can: peak_usb: rename device_id to CAN channel ID
  can: peak_usb: add callback to read CAN channel ID of
  can: peak_usb: allow flashing of the CAN channel ID
  can: peak_usb: replace unregister_netdev() with
  can: peak_usb: add ethtool interface to

Lukas Magel (3):
  can: peak_usb: export PCAN CAN channel ID as sysfs
  can: peak_usb: align CAN channel ID format in log with
  can: peak_usb: Reorder include directives

.../ABI/testing/sysfs-class-net-peak_usb        |  19 +++
 drivers/net/can/usb/peak_usb/pcan_usb.c         |  45 +++++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.c    | 122 +++++++++++++++++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.h    |  12 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c      |  68 +++++++++--
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c     |  30 ++++-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h     |   1 +
 7 files changed, 266 insertions(+), 31 deletions(-)



