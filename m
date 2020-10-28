Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDC329D2F6
	for <lists+linux-can@lfdr.de>; Wed, 28 Oct 2020 22:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgJ1VkD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Oct 2020 17:40:03 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:32465 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbgJ1VkD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Oct 2020 17:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603921200;
        s=strato-dkim-0002; d=hartkopp.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=ZLPjWqg3EcNj9i3Km96ns/LpKpyb/bhDpiL0DGi61kI=;
        b=d7PZjOWxwIz5CLUqm4fs4GP223+AMvCWEJ9LCxQCTnKYqrRWcBKe9wpqp9LEtBae8C
        UIxBudqpvgpDx3OFipWCHSuEnOHqDmgJtU6KIFg6s51lmJffki4qy5rpnYpsUmWMV0yT
        W15nG+fepOdgsEbAoRA/376cSlTCphb7oAiQS6duaiMlydtB96V47qWj/vBRAgXWxO2T
        /CjGDFeIc2jCmaj6YjlZ4dmG2z2x4tdbHbuiT7zA8UcvuKywUJMRCfVt+xMvjiRuxuW0
        GDN7Nej9vPGJcTMcCwiiLLSNe0u/FUu2ILImeX/+pJk9VwRaKNwf9NovY5mA+bziijg6
        Pq6g==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9dyKNLCWJaRrQ0pDCeGtVbNHMQ98lI/DcPKMT"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 47.2.3 AUTH)
        with ESMTPSA id J01b14w9SI9u1qP
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 28 Oct 2020 19:09:56 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     mkl@pengutronix.de, mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 0/4] Introduce optional DLC element for Classic CAN
Date:   Wed, 28 Oct 2020 19:09:36 +0100
Message-Id: <20201028180940.2071-1-socketcan@hartkopp.net>
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

Changes in v2:
  - rephrase commit message of patch 4 about can_dlc replacement

Oliver Hartkopp (4):
  can: add optional DLC element to Classical CAN frame structure
  can: rename get_can_dlc() macro with can_get_cc_len()
  can: remove obsolete get_canfd_dlc() macro
  can: replace can_dlc as variable/element for payload length

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

