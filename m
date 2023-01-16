Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F3E66CFE2
	for <lists+linux-can@lfdr.de>; Mon, 16 Jan 2023 21:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjAPULr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Jan 2023 15:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjAPULq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Jan 2023 15:11:46 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A74F23D95
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 12:11:45 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 4BB2E240068
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 21:11:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1673899902; bh=MOYxW8F5FlMKNvUCBjBb45vww86xIdp4bFNU6SCAdGE=;
        h=From:To:Cc:Subject:Date:From;
        b=pNbhDAQYi+vx+djCILL85aLV7w6fTq7ZKTYnc3Mxqk58+PyyjA9EmPBk2zyBLoh2W
         42zHjidH9JfzuT5hyfa5ymcJ2r9evdKvhC3HuH6e5hGXgq+M4vm11IGx/S9h/N/hQe
         JEkGqMJnK20wD8bG98+sOKam8atxnX/gAMgZmJMVtEt9ztjCKHj2PRtxBichVr0Qcn
         1JeKVtGcDCakJ0ibbVEi9H/mqYH3WMJTI9HGVfTazW2ttWWGDHWSqF4IfGzmdiCxbk
         ZoVilG9y0CdeE0mxsbRGPa+nZs+lij+OmK/CVbJ1IKkL/87tEK9lzWFUbKzAZvsS1R
         s8prYYb+xuUDQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Nwjpj432Zz9rxB;
        Mon, 16 Jan 2023 21:11:41 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Lukas Magel <lukas.magel@posteo.net>
Subject: [RESEND PATCH v3 0/8] can: peak_usb: Introduce configurable CAN channel ID
Date:   Mon, 16 Jan 2023 20:09:24 +0000
Message-Id: <20230116200932.157769-1-lukas.magel@posteo.net>
In-Reply-To: <20220801080446.36374-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
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
were modified. See the following threads for the original patches:

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

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
---
Hi Marc,

a happy late new year! I noticed that the patch order in my first v3
submission got messed up, so I'm sending it again. I hope that with the
v3 changes the patch series now finds the approval of you and the netdev
list.

Regards,
Lukas


