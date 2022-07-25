Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2166757FFD8
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiGYNcd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiGYNca (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:32:30 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D7FDF7E
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:29 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 23so10352558pgc.8
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8tBa5/RREmEbRKAj+QtnFWFWoV07faU3iFWt7tdjkk=;
        b=YiUhhoM7GObm77a0ISmrx5HPkdoe4DKhVvIo8T4NJZdbve8ZI4Xb02Iekw5VJMGLD4
         sUerdkJ+khhiFkrDA21O8F7b+NPKyIhwzZPkawWXxWwx0kClcXRrC3ztOubXcNpy32Pe
         GbKlycUiCPHUSsYeuTaK47JdVryg1TBZ9jSZcaXg76W08o31VRcuJaEkALuGHfmC3gN1
         9KwGhPkrAMHAJi3kHkmzSeOU3w4W0pPRUV+c3LkfWojDZYTqeI3ghI0i/xrIhunQMfmT
         +S5344jDEkVIcs4AyZqzOsFL52fgQnqghp1flFk8oKiVKp9YdLltmeANgENKwN6uUw8Y
         SrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=V8tBa5/RREmEbRKAj+QtnFWFWoV07faU3iFWt7tdjkk=;
        b=hY2np67knTW4HaZ2V9WsDYsB3thVpdTIOE8JcE5QsdWGnE+h2gl3O7ht+pccapZfz0
         kIUlYcDXICNr28YjqoqHUcdfZOBzDkA+L4draILuuXL9Zp610nKu42UX6Z7Stwq4U9n2
         0B3mEJ0Is9hktkQhtX7GnbJXgdaid5avYamvhsqGZzUHCOvCLUZU7dUIdTZXq8qaUhVC
         RLva3yv3w1N6SD0I4KxiEdY0EOztznKwit6R5pIf3K/R6VIFU+ht75FwaSZim+BY5+Vi
         23ngHzlNXPwcNK7/szDhso0flv6zS3c23zPa/JOWbnUqs4SfqNT68AjpQaHOgOVdMk+p
         PyYA==
X-Gm-Message-State: AJIora/Lww22o0+2ZLGJET9t+SfvLNUYvWLQubvxkm9cvRK4KJBnHRyM
        3CR0pvQ+0HNk6YCsz7Fp4vd2femtiu3/EA==
X-Google-Smtp-Source: AGRyM1sGY48qCjTtKOB1jTuscNPoch7ohggINOVwobqBhQ9a2Q9Sszt/Fvu84l6Ue4GwhD/d2Q3AQQ==
X-Received: by 2002:a05:6a00:841:b0:52b:15d2:e50f with SMTP id q1-20020a056a00084100b0052b15d2e50fmr12759771pfk.47.1658755948277;
        Mon, 25 Jul 2022 06:32:28 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:27 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 00/24] can: add ethtool support and reporting of timestamping capabilities
Date:   Mon, 25 Jul 2022 22:31:44 +0900
Message-Id: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

*Example on a device with hardware timestamp support *

Before this series:
| # tcpdump -j adapter_unsynced -i can0
| tcpdump: WARNING: When trying to set timestamp type
| 'adapter_unsynced' on can0: That type of time stamp is not supported
| by that device

After applying this series, the warning disappears and tcpdump can be
used to get RX hardware timestamps.


This series is articulated in five major parts.

* Part 1: Report driver information through ethtool

This first part implements ethtool_ops::get_drvinfo() for all
drivers. The actual change is made in the 10th patch. The patches 1 to
8 get rid of any hardcoded string and instead relies on either
KBUILD_MODNAME or DRV_NAME macros to get the device name. Patch 9
removes the DRV_VERSION macro so that ethtool can instead rely on the
kernel version.


* Part 2: Add TX software timestamps and report the software
  timestamping capabilities through ethtool.

All the drivers using can_put_echo_skb() already support TX software
timestamps. However, the five drivers not using this function (namely
can327, janz-ican3, slcan, vcan and vxcan) lack such support. Patch 11
to 14 adds this support.  Finally, patch 15 advertises the timesamping
capabilities of all drivers not support hardware timestamps.

* Part 3: add TX hardware timestapms

This part is a single patch. In SocetCAN TX hardware is equal to the
RX hardware timestamps of the corresponding loopback frame. Reuse the
TX hardware timestamp to populate the RX hardware timestamp. While the
need of this feature can be debatable, we implement it here so that
generic timestamping tools which are agnostic of the specificity of
SocketCAN can still obtain the value. For example, tcpdump expects for
both TX and RX hardware timestamps to be supported in order to do:
| # tcpdump -j adapter_unsynced -i canX

* Part 4: report the hardware timestamping capabilities and implement
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

Vincent Mailhol (24):
  can: can327: use KBUILD_MODNAME instead of hard coded name
  can: ems_ubs: use KBUILD_MODNAME instead of hard coded name
  can: slcan: add DRV_NAME and define pr_fmt to replace hardcoded names
  can: softing: add DRV_NAME to replace hardcoded names
  can: esd_usb: use KBUILD_MODNAME instead of hard coded name
  can: gs_ubs: use KBUILD_MODNAME instead of hard coded name
  can: softing: add DRV_NAME to replace hardcoded names
  can: ubs_8dev: use KBUILD_MODNAME instead of hard coded name
  can: etas_es58x: remove DRV_VERSION
  can: tree-wide: implement ethtool_ops::get_drvinfo()
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

 drivers/net/can/at91_can.c                    | 13 +++++
 drivers/net/can/c_can/c_can_main.c            | 13 +++++
 drivers/net/can/can327.c                      | 18 ++++++-
 drivers/net/can/cc770/cc770.c                 | 13 +++++
 drivers/net/can/ctucanfd/ctucanfd_base.c      | 13 +++++
 drivers/net/can/dev/dev.c                     | 50 +++++++++++++++++++
 drivers/net/can/dev/skb.c                     |  6 +++
 drivers/net/can/flexcan/flexcan-core.c        | 13 +++++
 drivers/net/can/grcan.c                       | 13 +++++
 drivers/net/can/ifi_canfd/ifi_canfd.c         | 13 +++++
 drivers/net/can/janz-ican3.c                  | 15 ++++++
 drivers/net/can/kvaser_pciefd.c               | 14 ++++++
 drivers/net/can/m_can/m_can.c                 | 13 +++++
 drivers/net/can/mscan/mscan.c                 |  1 +
 drivers/net/can/pch_can.c                     | 13 +++++
 drivers/net/can/peak_canfd/peak_canfd.c       | 14 ++++++
 drivers/net/can/rcar/rcar_can.c               | 13 +++++
 drivers/net/can/rcar/rcar_canfd.c             | 13 +++++
 drivers/net/can/sja1000/sja1000.c             | 13 +++++
 drivers/net/can/slcan/slcan-core.c            | 30 ++++++++---
 drivers/net/can/softing/softing_main.c        | 18 ++++++-
 drivers/net/can/spi/hi311x.c                  | 13 +++++
 drivers/net/can/spi/mcp251x.c                 | 13 +++++
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 14 ++++++
 drivers/net/can/sun4i_can.c                   | 13 +++++
 drivers/net/can/ti_hecc.c                     | 13 +++++
 drivers/net/can/usb/ems_usb.c                 | 17 ++++++-
 drivers/net/can/usb/esd_usb.c                 | 15 +++++-
 drivers/net/can/usb/etas_es58x/es58x_core.c   | 23 ++++++---
 drivers/net/can/usb/gs_usb.c                  | 15 ++++--
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  1 +
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 39 +++++++++++++--
 drivers/net/can/usb/mcba_usb.c                | 13 +++++
 drivers/net/can/usb/peak_usb/pcan_usb.c       |  3 ++
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  | 18 ++++++-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h  |  6 +++
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c    |  3 ++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c   |  3 ++
 drivers/net/can/usb/ucan.c                    | 13 +++++
 drivers/net/can/usb/usb_8dev.c                | 17 ++++++-
 drivers/net/can/vcan.c                        | 15 ++++++
 drivers/net/can/vxcan.c                       | 15 ++++++
 drivers/net/can/xilinx_can.c                  | 13 +++++
 include/linux/can/dev.h                       |  4 ++
 44 files changed, 592 insertions(+), 29 deletions(-)

-- 
2.35.1

