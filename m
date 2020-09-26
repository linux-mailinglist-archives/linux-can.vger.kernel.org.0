Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5BF279B85
	for <lists+linux-can@lfdr.de>; Sat, 26 Sep 2020 19:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIZRqA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 26 Sep 2020 13:46:00 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:38236 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZRqA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 26 Sep 2020 13:46:00 -0400
Received: from tomoyo.flets-east.jp ([153.230.197.127])
        by mwinf5d89 with ME
        id Yhlm230082lQRaH03hlv3f; Sat, 26 Sep 2020 19:45:58 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Sep 2020 19:45:58 +0200
X-ME-IP: 153.230.197.127
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 0/6] can: add support for ETAS ES58X CAN USB
Date:   Sun, 27 Sep 2020 02:45:30 +0900
Message-Id: <20200926174542.278166-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The purpose of this patch series is to introduce a new CAN USB
driver to support ETAS USB interfaces (ES58X series).

During development, issues in drivers/net/can/dev.c where discovered,
the fix for those issues are included in this patch series.

We also propose to add two helper functions in include/linux/can/dev.h
which we think can benefit other drivers: get_can_len() and
can_bit_time().

The driver indirectly relies on https://lkml.org/lkml/2020/9/26/251
([PATCH] can: raw: add missing error queue support) for the call to
skb_tx_timestamp() to work but can still compile without it.

*Side notes*: scripts/checkpatch.pl returns 4 'checks' findings in
[PATCH 5/6]. All those findings are of type: "Macro argument reuse 'x'
possible side-effects?".  Those arguments reuse are actually made by
calling either __stringify() or sizeof_field() which are both
pre-processor constant. Furthermore, those macro are never called with
arguments sensible to side-effects. So no actual side effect would
occur.

Thank you for your comments.

Vincent Mailhol (6):
  can: dev: can_get_echo_skb(): prevent call to kfree_skb() in hard IRQ
    context
  can: dev: add a helper function to get the correct length of Classical
    frames
  can: dev: __can_get_echo_skb(): fix the return length
  can: dev: add a helper function to calculate the duration of one bit
  can: usb: etas_es58X: add support for ETAS ES58X CAN USB interfaces
  USB: cdc-acm: blacklist ETAS ES58X device

 drivers/net/can/dev.c                       |   26 +-
 drivers/net/can/usb/Kconfig                 |    9 +
 drivers/net/can/usb/Makefile                |    1 +
 drivers/net/can/usb/etas_es58x/Makefile     |    4 +
 drivers/net/can/usb/etas_es58x/es581_4.c    |  560 ++++
 drivers/net/can/usb/etas_es58x/es581_4.h    |  237 ++
 drivers/net/can/usb/etas_es58x/es58x_core.c | 2725 +++++++++++++++++++
 drivers/net/can/usb/etas_es58x/es58x_core.h |  700 +++++
 drivers/net/can/usb/etas_es58x/es58x_fd.c   |  650 +++++
 drivers/net/can/usb/etas_es58x/es58x_fd.h   |  243 ++
 drivers/usb/class/cdc-acm.c                 |   11 +
 include/linux/can/dev.h                     |   38 +
 12 files changed, 5190 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/can/usb/etas_es58x/Makefile
 create mode 100644 drivers/net/can/usb/etas_es58x/es581_4.c
 create mode 100644 drivers/net/can/usb/etas_es58x/es581_4.h
 create mode 100644 drivers/net/can/usb/etas_es58x/es58x_core.c
 create mode 100644 drivers/net/can/usb/etas_es58x/es58x_core.h
 create mode 100644 drivers/net/can/usb/etas_es58x/es58x_fd.c
 create mode 100644 drivers/net/can/usb/etas_es58x/es58x_fd.h

-- 
2.26.2

