Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63805823F5
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiG0KRD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiG0KRD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:17:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25389220DA
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y15so15731210plp.10
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0DkwH/h+qfi3xWLSdQxRAUpNJenOQC7T4Up1HhOCdjE=;
        b=SIxPDfDlZ9Fv4nCpBbJvOfjNkTafHy5X98P55GcIcjfnOzdfivyGapzGKIXAFUz/zC
         X1SkPXLFuUPBomohh9ikrSAaOCA8Xz71RQLKC7uUhORGL5dlZbKRkAz9U/9Jp7YHOFAi
         o5Ts8ol460dPVDJOo6f/EWMQLaPsHiKmbJzqqZXmy/k6m0Vh4WvIlBRpt2qtIYhRSjZO
         X+Bi6O7hYeNa3yfk9+ySEoz7O2WXL+Vjn3PlLtJ+mlFTs3buiGaSNwqODcpc/uxtgVXD
         r5xihWdWACr3Da2LsrhtzKvBiSy/CYsch156ANeBGBeOMZfDWPL10uMZ9+uHa/MRLH1e
         +Qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0DkwH/h+qfi3xWLSdQxRAUpNJenOQC7T4Up1HhOCdjE=;
        b=podaSgI8t2VzV+H/A5wiW0CzcSpF8RLYVvX6d9XkH9S6pXXceO/y9SZFrtTVmP+bwt
         hIRQTNeSi5CPlxOW95w5P/YYWuJfy07ziaxjGUglF3qpW/JYE2fhyAYxEY0c0AziiU7c
         RpY8fYKvzyBH2PPgBj215ml0IV7Irrgt827e26mwqWjrbx9IvrEPLjQ0nANYzA5gtw+b
         7RWt+DJ4UlSDUvGVPRgWJCPIQDnnVoguI3QC+kK+viwi4CG+fEmvjQmPLc0cBcUBcNvj
         FwGVKi8GJu8v6wx5WER5j0dnienmNLSDJx8lopbLpPaV8t+QaL1OK1cb0xy8rFeANXQt
         ja1A==
X-Gm-Message-State: AJIora/Fj5IYK4DmlRd2lRrR+fTkdcfxHjG9gMWtthWHM2Mo+GlfnDY9
        8C1XTvBCK/jX66PuEVlw1gciifhDw8jfLw==
X-Google-Smtp-Source: AGRyM1u+zmPgO6cvX3UhbSkOxpD079BaGFtGfZsrDyPgNVbSsFmr7rxgp5rpvYJmVAjIfipKw/AieQ==
X-Received: by 2002:a17:902:8a86:b0:16d:324d:8a48 with SMTP id p6-20020a1709028a8600b0016d324d8a48mr18274213plo.22.1658917021224;
        Wed, 27 Jul 2022 03:17:01 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b005284e98304csm13260666pfq.205.2022.07.27.03.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:17:00 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 00/14] can: add ethtool support and reporting of timestamping capabilities
Date:   Wed, 27 Jul 2022 19:16:27 +0900
Message-Id: <20220727101641.198847-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series revolves around ethtool and timestamping. Its ultimate
goal is that the timestamping implementation within socketCAN meets
the specification of other network drivers in the kernel. This way,
tcpdump or other tools derived from libpcap can be used to do
timestamping on CAN devices.

* Example on a device with hardware timestamp support *

Before this series:
| # tcpdump -j adapter_unsynced -i can0
| tcpdump: WARNING: When trying to set timestamp type
| 'adapter_unsynced' on can0: That type of time stamp is not supported
| by that device

After applying this series, the warning disappears and tcpdump can be
used to get RX hardware timestamps.


This series is articulated in three major parts.

* Part 1: Add TX software timestamps and report the software
  timestamping capabilities through ethtool.

All the drivers using can_put_echo_skb() already support TX software
timestamps. However, the five drivers not using this function (namely
can327, janz-ican3, slcan, vcan and vxcan) lack such support. Patch 1
to 4 adds this support.  Finally, patch 5 advertises the timesamping
capabilities of all drivers which do not support hardware timestamps.


* Part 2: add TX hardware timestapms

This part is a single patch. In SocketCAN TX hardware is equal to the
RX hardware timestamps of the corresponding loopback frame. Reuse the
TX hardware timestamp to populate the RX hardware timestamp. While the
need of this feature can be debatable, we implement it here so that
generic timestamping tools which are agnostic of the specificity of
SocketCAN can still obtain the value. For example, tcpdump expects for
both TX and RX hardware timestamps to be supported in order to do:
| # tcpdump -j adapter_unsynced -i canX


* Part 3: report the hardware timestamping capabilities and implement
  the hardware timestamps ioctls.

The kernel documentation specifies in [1] that, for the drivers which
support hardware timestamping, SIOCSHWTSTAMP ioctl must be supported
and that SIOCGHWTSTAMP ioctl should be supported. Currently, none of
the CAN drivers do so. This is a gap.

Furthermore, even if not specified, the tools based on libpcap
(e.g. tcpdump) also expect ethtool_ops::get_ts_info to be implemented.

This last part first adds some generic implementation of
net_device_ops::ndo_eth_ioctl and ethtool_ops::get_ts_info which can
be used by the drivers with hardware timestamping capabilities.

It then uses those generic functions to add ioctl and reporting
functionalities to the drivers with hardware timestamping support
(namely: mcp251xfd, etas_es58x, kvaser_{pciefd,usb}, peak_{canfd,usb})


[1] Kernel doc: Timestamping, section 3.1 "Hardware Timestamping
Implementation: Device Drivers"
Link: https://docs.kernel.org/networking/timestamping.html#hardware-timestamping-implementation-device-drivers


* Testing *

I also developed a tool to test all the different timestamps. For
those who would also like to test it, please have a look at:
https://lore.kernel.org/linux-can/20220725134345.432367-1-mailhol.vincent@wanadoo.fr/T/


* Changelog *

v3 -> v4:

  * The peak drivers (both PCI and USB) do not support hardware TX
    timestamps (only RX). Implement specific ioctl and ethtool
    callback functions for this device.

v2 -> v3:

  * The c_can, flexcan, mcp251xfd and the slcan drivers already
    declared a struct ethtool_ops. Do not declare again the same
    structure and instead populate the .get_ts_info() field of the
    existing structures.

v1 -> v2:

  * First series had a patch to implement
    ethtool_ops::get_drvinfo. This proved to be useless. This patch
    was removed and all the clean-up patches made in preparation of
    that one were moved to a separate series:

    https://lore.kernel.org/linux-can/20220725153124.467061-1-mailhol.vincent@wanadoo.fr/T/#u

Vincent Mailhol (14):
  can: can327: add software tx timestamps
  can: janz-ican3: add software tx timestamp
  can: slcan: add software tx timestamps
  can: v(x)can: add software tx timestamps
  can: tree-wide: advertise software timestamping capabilities
  can: dev: add hardware TX timestamp
  can: dev: add generic function can_ethtool_op_get_ts_info_hwts()
  can: dev: add generic function can_eth_ioctl_hwts()
  can: mcp251xfd: advertise timestamping capabilities and add ioctl
    support
  can: etas_es58x: advertise timestamping capabilities and add ioctl
    support
  can: kvaser_pciefd: advertise timestamping capabilities and add ioctl
    support
  can: kvaser_usb: advertise timestamping capabilities and add ioctl
    support
  can: peak_canfd: advertise timestamping capabilities and add ioctl
    support
  can: peak_usb: advertise timestamping capabilities and add ioctl
    support

 drivers/net/can/at91_can.c                    |  6 +++
 drivers/net/can/c_can/c_can_ethtool.c         |  1 +
 drivers/net/can/can327.c                      |  7 +++
 drivers/net/can/cc770/cc770.c                 |  6 +++
 drivers/net/can/ctucanfd/ctucanfd_base.c      |  6 +++
 drivers/net/can/dev/dev.c                     | 50 +++++++++++++++++++
 drivers/net/can/dev/skb.c                     |  6 +++
 drivers/net/can/flexcan/flexcan-ethtool.c     |  1 +
 drivers/net/can/grcan.c                       |  6 +++
 drivers/net/can/ifi_canfd/ifi_canfd.c         |  6 +++
 drivers/net/can/janz-ican3.c                  |  8 +++
 drivers/net/can/kvaser_pciefd.c               |  7 +++
 drivers/net/can/m_can/m_can.c                 |  6 +++
 drivers/net/can/mscan/mscan.c                 |  1 +
 drivers/net/can/pch_can.c                     |  6 +++
 drivers/net/can/peak_canfd/peak_canfd.c       | 48 ++++++++++++++++++
 drivers/net/can/rcar/rcar_can.c               |  6 +++
 drivers/net/can/rcar/rcar_canfd.c             |  6 +++
 drivers/net/can/sja1000/sja1000.c             |  6 +++
 drivers/net/can/slcan/slcan-core.c            |  2 +
 drivers/net/can/slcan/slcan-ethtool.c         |  1 +
 drivers/net/can/softing/softing_main.c        |  6 +++
 drivers/net/can/spi/hi311x.c                  |  6 +++
 drivers/net/can/spi/mcp251x.c                 |  6 +++
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    |  1 +
 .../net/can/spi/mcp251xfd/mcp251xfd-ethtool.c |  1 +
 drivers/net/can/sun4i_can.c                   |  6 +++
 drivers/net/can/ti_hecc.c                     |  6 +++
 drivers/net/can/usb/ems_usb.c                 |  6 +++
 drivers/net/can/usb/esd_usb.c                 |  6 +++
 drivers/net/can/usb/etas_es58x/es58x_core.c   |  9 +++-
 drivers/net/can/usb/gs_usb.c                  |  2 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  1 +
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 27 +++++++++-
 drivers/net/can/usb/mcba_usb.c                |  6 +++
 drivers/net/can/usb/peak_usb/pcan_usb.c       |  1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  | 41 +++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h  |  1 +
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c    |  1 +
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c   |  1 +
 drivers/net/can/usb/ucan.c                    |  6 +++
 drivers/net/can/usb/usb_8dev.c                |  6 +++
 drivers/net/can/vcan.c                        |  8 +++
 drivers/net/can/vxcan.c                       |  8 +++
 drivers/net/can/xilinx_can.c                  |  6 +++
 include/linux/can/dev.h                       |  4 ++
 46 files changed, 361 insertions(+), 3 deletions(-)

-- 
2.35.1

