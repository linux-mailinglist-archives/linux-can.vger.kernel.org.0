Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE2D4470BA
	for <lists+linux-can@lfdr.de>; Sat,  6 Nov 2021 22:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhKFV5i (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 6 Nov 2021 17:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhKFV5i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 6 Nov 2021 17:57:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29881C061570
        for <linux-can@vger.kernel.org>; Sat,  6 Nov 2021 14:54:56 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mjTeI-0000k2-I4
        for linux-can@vger.kernel.org; Sat, 06 Nov 2021 22:54:54 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 9F3696A5F5F
        for <linux-can@vger.kernel.org>; Sat,  6 Nov 2021 21:54:53 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1FF5B6A5F5A;
        Sat,  6 Nov 2021 21:54:51 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id dc5e4c7e;
        Sat, 6 Nov 2021 21:54:50 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: pull-request: can 2021-11-06
Date:   Sat,  6 Nov 2021 22:54:41 +0100
Message-Id: <20211106215449.57946-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Jakub, hello David,

this is a pull request of 8 patches for net/master.

The first 3 patches are by Zhang Changzhong and fix 3 standard
conformance problems in the j1939 CAN stack.

The next patch is by Vincent Mailhol and fixes a memory leak in the
leak error path of the etas_es58x CAN driver.

Stephane Grosjean contributes 2 patches for the peak_usb driver to fix
the bus error handling and update the order of printed information
regarding firmware version and available updates.

The last 2 patches are by me and fixes a packet starvation problem in
the bus off case and the error handling in the mcp251xfd_chip_start()
function.

regards,
Marc

---
The following changes since commit 70bf363d7adb3a428773bc905011d0ff923ba747:

  ipv6: remove useless assignment to newinet in tcp_v6_syn_recv_sock() (2021-11-05 19:49:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-5.16-20211106

for you to fetch changes up to 69c55f6e7669d46bb40e41f6e2b218428178368a:

  can: mcp251xfd: mcp251xfd_chip_start(): fix error handling for mcp251xfd_chip_rx_int_enable() (2021-11-06 21:25:25 +0100)

----------------------------------------------------------------
linux-can-fixes-for-5.16-20211106

----------------------------------------------------------------
Marc Kleine-Budde (2):
      can: mcp251xfd: mcp251xfd_irq(): add missing can_rx_offload_threaded_irq_finish() in case of bus off
      can: mcp251xfd: mcp251xfd_chip_start(): fix error handling for mcp251xfd_chip_rx_int_enable()

Stephane Grosjean (2):
      can: peak_usb: always ask for BERR reporting for PCAN-USB devices
      can: peak_usb: exchange the order of information messages

Vincent Mailhol (1):
      can: etas_es58x: es58x_rx_err_msg(): fix memory leak in error path

Zhang Changzhong (3):
      can: j1939: j1939_tp_cmd_recv(): ignore abort message in the BAM transport
      can: j1939: j1939_can_recv(): ignore messages with invalid source address
      can: j1939: j1939_tp_cmd_recv(): check the dst address of TP.CM_BAM

 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c |  6 ++++--
 drivers/net/can/usb/etas_es58x/es58x_core.c    |  6 ++----
 drivers/net/can/usb/peak_usb/pcan_usb.c        | 27 +++++++++++++-------------
 net/can/j1939/main.c                           |  7 +++++++
 net/can/j1939/transport.c                      | 11 +++++++++++
 5 files changed, 37 insertions(+), 20 deletions(-)


