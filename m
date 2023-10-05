Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CE57BAAE1
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 21:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjJET61 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 15:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjJET6V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 15:58:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34259EA
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 12:58:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUB-0004dG-P2
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:15 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUB-00BLCv-9I
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:15 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id F098922FF75
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 19:58:14 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 024E322FF5F;
        Thu,  5 Oct 2023 19:58:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 28c759e5;
        Thu, 5 Oct 2023 19:58:13 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH net-next 0/37] pull-request: can-next 2023-10-05
Date:   Thu,  5 Oct 2023 21:57:35 +0200
Message-Id: <20231005195812.549776-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello netdev-team,

this is a pull request of 37 patches for net-next/master.

The first patch is by Miquel Raynal and fixes a comment in the sja1000
driver.

Vincent Mailhol contributes 2 patches that fix W=1 compiler warnings
in the etas_es58x driver.

Jiapeng Chong's patch removes an unneeded NULL pointer check before
dev_put() in the CAN raw protocol.

A patch by Justin Stittreplaces a strncpy() by strscpy() in the
peak_pci sja1000 driver.

The next 5 patches are by me and fix the can_restart() handler and
replace BUG_ON()s in the CAN dev helpers with proper error handling.

The last 27 patches are also by me and target the at91_can driver.
First a new helper function is introduced, the at91_can driver is
cleaned up and updated to use the rx-offload helper.

regards,
Marc

---

The following changes since commit 473267a4911f2469722c74ca58087d951072f72a:

  net: add sysctl to disable rfc4862 5.5.3e lifetime handling (2023-10-03 15:51:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.7-20231005

for you to fetch changes up to bf176313c62ec4f97daa893888aa4fde86749cb2:

  Merge patch series "can: at91: add can_state_get_by_berr_counter() helper, cleanup and convert to rx_offload" (2023-10-05 21:48:09 +0200)

----------------------------------------------------------------
linux-can-next-for-6.7-20231005

----------------------------------------------------------------
Jiapeng Chong (1):
      can: raw: Remove NULL check before dev_{put, hold}

Justin Stitt (1):
      can: peak_pci: replace deprecated strncpy with strscpy

Marc Kleine-Budde (35):
      Merge patch series "can: etas_es58x: clean-up of new GCC W=1 and old checkpatch warnings"
      can: dev: can_restart(): don't crash kernel if carrier is OK
      can: dev: can_restart(): fix race condition between controller restart and netif_carrier_on()
      can: dev: can_restart(): reverse logic to remove need for goto
      can: dev: can_restart(): move debug message and stats after successful restart
      can: dev: can_put_echo_skb(): don't crash kernel if can_priv::echo_skb is accessed out of bounds
      Merge patch series "can: dev: fix can_restart() and replace BUG_ON() by error handling"
      can: dev: add can_state_get_by_berr_counter() to return the CAN state based on the current error counters
      can: at91_can: use a consistent indention
      can: at91_can: at91_irq_tx(): remove one level of indention
      can: at91_can: BR register: convert to FIELD_PREP()
      can: at91_can: ECR register: convert to FIELD_GET()
      can: at91_can: MMR registers: convert to FIELD_PREP()
      can: at91_can: MID registers: convert access to FIELD_PREP(), FIELD_GET()
      can: at91_can: MSR Register: convert to FIELD_PREP()
      can: at91_can: MCR Register: convert to FIELD_PREP()
      can: at91_can: add more register definitions
      can: at91_can: at91_setup_mailboxes(): update comments
      can: at91_can: rename struct at91_priv::{tx_next,tx_echo} to {tx_head,tx_tail}
      can: at91_can: at91_set_bittiming(): demote register output to debug level
      can: at91_can: at91_chip_start(): don't disable IRQs twice
      can: at91_can: at91_open(): forward request_irq()'s return value in case or an error
      can: at91_can: add CAN transceiver support
      can: at91_can: at91_poll_err(): fold in at91_poll_err_frame()
      can: at91_can: at91_poll_err(): increase stats even if no quota left or OOM
      can: at91_can: at91_irq_err_frame(): call directly from IRQ handler
      can: at91_can: at91_irq_err_frame(): move next to at91_irq_err()
      can: at91_can: at91_irq_err(): rename to at91_irq_err_line()
      can: at91_can: at91_irq_err_line(): make use of can_state_get_by_berr_counter()
      can: at91_can: at91_irq_err_line(): take reg_sr into account for bus off
      can: at91_can: at91_irq_err_line(): make use of can_change_state() and can_bus_off()
      can: at91_can: at91_irq_err_line(): send error counters with state change
      can: at91_can: at91_alloc_can_err_skb() introduce new function
      can: at91_can: switch to rx-offload implementation
      Merge patch series "can: at91: add can_state_get_by_berr_counter() helper, cleanup and convert to rx_offload"

Miquel Raynal (1):
      can: sja1000: Fix comment

Vincent Mailhol (2):
      can: etas_es58x: rework the version check logic to silence -Wformat-truncation
      can: etas_es58x: add missing a blank line after declaration

 drivers/net/can/Kconfig                        |   1 +
 drivers/net/can/at91_can.c                     | 998 ++++++++++---------------
 drivers/net/can/dev/dev.c                      |  51 +-
 drivers/net/can/dev/skb.c                      |   6 +-
 drivers/net/can/sja1000/peak_pci.c             |   2 +-
 drivers/net/can/sja1000/sja1000.c              |   2 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c    |   1 +
 drivers/net/can/usb/etas_es58x/es58x_core.h    |   6 +-
 drivers/net/can/usb/etas_es58x/es58x_devlink.c |  57 +-
 include/linux/can/dev.h                        |   4 +
 net/can/raw.c                                  |   3 +-
 11 files changed, 497 insertions(+), 634 deletions(-)


