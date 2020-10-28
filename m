Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84D29D579
	for <lists+linux-can@lfdr.de>; Wed, 28 Oct 2020 23:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgJ1WDC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Oct 2020 18:03:02 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:30941 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbgJ1WBE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Oct 2020 18:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603922462;
        s=strato-dkim-0002; d=hartkopp.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=CJzsQyPcDoek1dR02nYwpK9TBvwBGaUNlBDSmnhmfsQ=;
        b=WtN2/tp4NcbILtY6IpsmDOqJdt4lw31lqNHT58zwgjSanqPJ/a+X47rg1/XKyfajsS
        gSJSujoFChKWJMXlzjOAc4BHIHppM+TEPHCfzCGQCLleIlvHbmqhwBoqa8cVvJPfCDMG
        6jtMgZTI8WI04uok9moEvg/7Svkv9Eyr/CnuWOit10pxBWzzg6tqYglX6Z8cKgiTUJxW
        iir6CpnrEtAK4Td7ItN5QlUsnE8hQIM/btKLgkaLcVhStT8Z6K+432s1s/osnptqPY94
        bsWi29IPNzvI5DGBH2plOnFVIwxfksiYnd7/D9NiaEKcaRqBmVtPlRVBKxl651aUql6V
        gYGg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejudJy4jsSjttw=="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
        by smtp.strato.de (RZmta 47.2.3 DYNA|AUTH)
        with ESMTPSA id J01b14w9SB0w0RK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 28 Oct 2020 12:00:58 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     mailhol.vincent@wanadoo.fr, mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 0/4] Introduce optional DLC element for Classic CAN
Date:   Wed, 28 Oct 2020 12:00:29 +0100
Message-Id: <20201028110033.113702-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Introduce improved DLC handling for Classic CAN with introduces a new
element 'len8_dlc' to the struct can_frame and additionally rename
the 'can_dlc' element to 'len' as it represents a plain payload length.

Before implementing the CAN_CTRLMODE_CC_LEN8_DLC handling on driver level
this patch set cleans up and renames the relevant code.

No functional changes.

This patch set is based on mkl/linux-can.git (testing branch).

Oliver Hartkopp (4):
  can: add optional DLC element to Classical CAN frame structure
  can: rename get_can_dlc() macro with can_get_cc_len()
  can: remove obsolete get_canfd_dlc() macro
  can: rename can_dlc with len for all struct can_frame users

 Documentation/networking/can.rst              |  6 ++--
 drivers/net/can/at91_can.c                    | 14 ++++----
 drivers/net/can/c_can/c_can.c                 | 20 +++++------
 drivers/net/can/cc770/cc770.c                 | 14 ++++----
 drivers/net/can/dev.c                         | 10 +++---
 drivers/net/can/flexcan.c                     |  4 +--
 drivers/net/can/grcan.c                       | 10 +++---
 drivers/net/can/ifi_canfd/ifi_canfd.c         |  6 ++--
 drivers/net/can/janz-ican3.c                  | 20 +++++------
 drivers/net/can/kvaser_pciefd.c               |  4 +--
 drivers/net/can/m_can/m_can.c                 |  6 ++--
 drivers/net/can/mscan/mscan.c                 | 20 +++++------
 drivers/net/can/pch_can.c                     | 14 ++++----
 drivers/net/can/peak_canfd/peak_canfd.c       | 16 ++++-----
 drivers/net/can/rcar/rcar_can.c               | 14 ++++----
 drivers/net/can/rcar/rcar_canfd.c             |  8 ++---
 drivers/net/can/rx-offload.c                  |  2 +-
 drivers/net/can/sja1000/sja1000.c             | 10 +++---
 drivers/net/can/slcan.c                       | 32 ++++++++---------
 drivers/net/can/softing/softing_fw.c          |  2 +-
 drivers/net/can/softing/softing_main.c        | 14 ++++----
 drivers/net/can/spi/hi311x.c                  | 20 +++++------
 drivers/net/can/spi/mcp251x.c                 | 20 +++++------
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    |  4 +--
 drivers/net/can/sun4i_can.c                   | 10 +++---
 drivers/net/can/ti_hecc.c                     |  8 ++---
 drivers/net/can/usb/ems_usb.c                 | 16 ++++-----
 drivers/net/can/usb/esd_usb2.c                | 16 ++++-----
 drivers/net/can/usb/gs_usb.c                  | 14 ++++----
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  2 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 20 +++++------
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 22 ++++++------
 drivers/net/can/usb/mcba_usb.c                | 10 +++---
 drivers/net/can/usb/peak_usb/pcan_usb.c       | 14 ++++----
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c    | 14 ++++----
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c   | 14 ++++----
 drivers/net/can/usb/ucan.c                    | 20 +++++------
 drivers/net/can/usb/usb_8dev.c                | 14 ++++----
 drivers/net/can/xilinx_can.c                  | 12 +++----
 include/linux/can/dev.h                       |  9 +++--
 include/linux/can/dev/peak_canfd.h            |  2 +-
 include/uapi/linux/can.h                      | 36 ++++++++++++-------
 include/uapi/linux/can/netlink.h              |  1 +
 net/can/af_can.c                              |  2 +-
 net/can/gw.c                                  |  2 +-
 net/can/j1939/main.c                          |  4 +--
 46 files changed, 281 insertions(+), 271 deletions(-)

-- 
2.28.0

