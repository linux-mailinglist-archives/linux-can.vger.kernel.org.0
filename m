Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA6E3431F3
	for <lists+linux-can@lfdr.de>; Sun, 21 Mar 2021 11:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCUKlV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 21 Mar 2021 06:41:21 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:31434 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229784AbhCUKlU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 21 Mar 2021 06:41:20 -0400
Received: from tomoyo.flets-east.jp ([153.202.107.157])
        by mwinf5d70 with ME
        id iyh52400H3PnFJp03yhG6b; Sun, 21 Mar 2021 11:41:19 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Mar 2021 11:41:19 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v14 0/4] Introducing ETAS ES58X CAN USB interfaces
Date:   Sun, 21 Mar 2021 19:40:59 +0900
Message-Id: <20210321104103.213308-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Here comes the 14th iteration of the patch. This new version addresses
the comments received from Jimmy and Marc (thanks again for the
review!).

** Changelog **

Changes in v14 (2021-03-21):
  - Rework the split into core support, es581_4, es58x_fd (cosmetic
    change) so that es581_4.h and es58x_fd.h headers can be added in
    one block.
  - Add a fourth patch to introduce a helper function
    es58x_netdev_queue_set_dql_min_limit() to set up dql minimum limit
    (in parallel, I will try to have this merged in the network device
    header)
  - Remove unused function es58x_add_skb_idx(): leftover from the old
    FIFO logic, should have been removed in v11.
  - Fix memory leak in es58x_get_product_info(): buffer was not freed
    in case of error in usb_sting().
  - s/loopback/echo and s/self reception/echo: in the driver the terms
    "loopback, self reception, and echo" were all used to designated
    the same thing. Renamed structures, variables and comments
    accordingly to make it more consistent.
  - Remove CAN_CTRLMODE_LOOPBACK. The driver never supported this
    feature. It was added due to a confusion with the echo skb.
  - Use the new can_free_echo_skb() which return the frame_len.
  - Do the statistics handling in es58x_rx_err_msg() even if kalloc()
    fails.
  - Replace array es58x_cmd_ret_desc[] by helper function
    es58x_cmd_ret_desc().
  - Other trivial changes (c.f. below link for details)
Reference: https://lore.kernel.org/linux-can/50850e5f-87c6-505e-4398-babce3facb97@pengutronix.de/T/#mbcace9c13b19a504cd28d81591f983b95eb66657

Changes in v13 (2021-03-19 by Marc Kleine-Budde):
  - split the driver into 3 patches, so that it can be send via
    mailing lists (core support, es581_4, es58x_fd)
  - Remove the dql.min_limit settings
  - typo and kernel doc fixes
Reference: https://lore.kernel.org/linux-can/50850e5f-87c6-505e-4398-babce3facb97@pengutronix.de/T/#t

Changes in v12 (2021-03-09):
  - Rework the queue stop/wake management so that spinlocks are not
    needed anymore.
  - es58x_start_xmit(): check for valid SKB using
    can_dropped_invalid_skb().
  - Implemented TDC according to latest patches in linux-can-next.
Reference: https://lore.kernel.org/linux-can/20210224002008.4158-1-mailhol.vincent@wanadoo.fr/T/#t

Changes in v11 (2021-01-23):
  - Remove all WARN_ON() calls: these were use during development,
    relevant tests are done not to trigger these.
  - es58x_start_xmit(): added net_ratelimit() condition to prevent
    spamming dmesg.
  - add a new es58x_xmit_more() function and simplify the code of
    es58x_start_xmit().
  - Removed functions {es581_4,es58x_fd}_print_conf() which were only
    there for debug.
  - Additional comment for es58x_fd_param.bitrate_max.
  - Make the device FIFO size a power of two and modify the echo_skb
    indexes logic to prevent the use of spinlocks.

Changes in v10 (2021-01-12):
  - Rebased on linux-can-next/testing and modified according to latest
    BQL patches.
Reference: https://lore.kernel.org/linux-can/20210111141930.693847-1-mkl@pengutronix.de/T/#m5f99d4da8e8934a75f9481ecc3137b59f3762413
  - Replaced __netdev_sent_queue() by netdev_sent_queue().

Changes in v9 (2021-01-09):
  - es58x_start_xmit(): do not use skb anymore after the call of
    can_put_echo_skb(). Rationale: can_put_echo_skb() calls
    skb_clone() and thus the original skb gets consumed (i.e. use
    after free issue).
  - es58x_start_xmit(): Add a "drop_skb" label to free the skb when
    errors occur.

Changes in v8 (2021-01-04):
  - The driver requires CRC16. Modified Kconfig accordingly.

Changes in v7 (2020-11-17):
  - Fix compilation issue if CONFIG_BQL is not set.
Reference: https://lkml.org/lkml/2020/11/15/163

Changes in v6 (2020-11-15):
  - Rebase the patch on the testing branch of linux-can-next.
  - Rename the helper functions according latest changes
    (e.g. can_cc_get_len() -> can_cc_dlc2len())
  - Fix comments of enum es58x_physical_layer and enum
    es58x_sync_edge.

Changes in v5 (2020-11-07):
  - Add support for DLC greater than 8.
  - All other patches from the previous series were either accepted or
    dismissed. As such, this is not a series any more but a single
    patch.

Changes in v4 (2020-10-17):
  - Remove struct es58x_abstracted_can_frame.
  - Fix formatting (spaces, comment style).
  - Transform macros into static inline functions when possible.
  - Fix the ctrlmode_supported flags in es581_4.c and removed
    misleading comments in enum es58x_samples_per_bit.
  - Rename enums according to the type.
  - Remove function es58x_can_put_echo_skb().
Reference: https://lkml.org/lkml/2020/10/10/53

Changes in v3 (2020-10-03):
  - Remove all the calls to likely() and unlikely().
Reference: https://lkml.org/lkml/2020/9/30/995

Changes in v2 (2020-09-30):
  - Fixed -W1 warnings (v1 was tested with GCC -WExtra but not with -W1).

v1 (2020-09-27):
  - First release

Vincent Mailhol (4):
  can: etas_es58x: add core support for ETAS ES58X CAN USB interfaces
  can: etas_es58x: add support for ETAS ES581.4 CAN USB interface
  can: etas_es58x: add support for the ETAS ES58X_FD CAN USB interfaces
  can: etas_es58x: add es58x_netdev_queue_set_dql_min_limit()

 drivers/net/can/usb/Kconfig                 |   10 +
 drivers/net/can/usb/Makefile                |    1 +
 drivers/net/can/usb/etas_es58x/Makefile     |    3 +
 drivers/net/can/usb/etas_es58x/es581_4.c    |  501 ++++
 drivers/net/can/usb/etas_es58x/es581_4.h    |  207 ++
 drivers/net/can/usb/etas_es58x/es58x_core.c | 2403 +++++++++++++++++++
 drivers/net/can/usb/etas_es58x/es58x_core.h |  696 ++++++
 drivers/net/can/usb/etas_es58x/es58x_fd.c   |  577 +++++
 drivers/net/can/usb/etas_es58x/es58x_fd.h   |  243 ++
 9 files changed, 4641 insertions(+)
 create mode 100644 drivers/net/can/usb/etas_es58x/Makefile
 create mode 100644 drivers/net/can/usb/etas_es58x/es581_4.c
 create mode 100644 drivers/net/can/usb/etas_es58x/es581_4.h
 create mode 100644 drivers/net/can/usb/etas_es58x/es58x_core.c
 create mode 100644 drivers/net/can/usb/etas_es58x/es58x_core.h
 create mode 100644 drivers/net/can/usb/etas_es58x/es58x_fd.c
 create mode 100644 drivers/net/can/usb/etas_es58x/es58x_fd.h

-- 
2.26.2

