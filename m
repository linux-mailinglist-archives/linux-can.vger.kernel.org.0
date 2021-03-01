Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870F2327D0B
	for <lists+linux-can@lfdr.de>; Mon,  1 Mar 2021 12:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhCALVz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Mar 2021 06:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhCALVt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Mar 2021 06:21:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691C4C061756
        for <linux-can@vger.kernel.org>; Mon,  1 Mar 2021 03:21:09 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lGgbs-0002wR-2H
        for linux-can@vger.kernel.org; Mon, 01 Mar 2021 12:21:08 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D4F925EB10A
        for <linux-can@vger.kernel.org>; Mon,  1 Mar 2021 11:21:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1F3075EB0F6;
        Mon,  1 Mar 2021 11:21:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3beac7e6;
        Mon, 1 Mar 2021 11:21:02 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: pull-request: can 2021-03-01
Date:   Mon,  1 Mar 2021 12:20:54 +0100
Message-Id: <20210301112100.197939-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
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

this is a pull request of 6 patches for net/master.

The first 3 patches are by Joakim Zhang for the flexcan driver and fix
the probing and starting of the chip.

The next patch is by me, for the mcp251xfd driver and reverts the BQL
support. BQL support got mainline with rc1 and assumes that CAN frames
are always echoed, which is not the case. A proper fix requires
changes more changes and will be rolled out via linux-can-next later.

Oleksij Rempel's patch fixes the socket ref counting if socket was
closed before setting skb ownership.

Torin Cooper-Bennun's patch for the tcan4x5x driver fixes a race
condition, where the chip is first attached the bus and then the MRAM
is initialized, which may result in lost data.

regards,
Marc

---

The following changes since commit 447621e373bd1b22300445639b43c39f399e4c73:

  Merge branch 'net-hns3-fixes-fot-net' (2021-02-28 12:04:02 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-5.12-20210301

for you to fetch changes up to 2712625200ed69c642b9abc3a403830c4643364c:

  can: tcan4x5x: tcan4x5x_init(): fix initialization - clear MRAM before entering Normal Mode (2021-03-01 11:45:15 +0100)

----------------------------------------------------------------
linux-can-fixes-for-5.12-20210301

----------------------------------------------------------------
Joakim Zhang (3):
      can: flexcan: assert FRZ bit in flexcan_chip_freeze()
      can: flexcan: enable RX FIFO after FRZ/HALT valid
      can: flexcan: invoke flexcan_chip_freeze() to enter freeze mode

Marc Kleine-Budde (1):
      can: mcp251xfd: revert "can: mcp251xfd: add BQL support"

Oleksij Rempel (1):
      can: skb: can_skb_set_owner(): fix ref counting if socket was closed before setting skb ownership

Torin Cooper-Bennun (1):
      can: tcan4x5x: tcan4x5x_init(): fix initialization - clear MRAM before entering Normal Mode

 drivers/net/can/flexcan.c                      | 24 +++++++++++++++---------
 drivers/net/can/m_can/tcan4x5x-core.c          |  6 +++---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 21 ++++-----------------
 include/linux/can/skb.h                        |  8 ++++++--
 4 files changed, 28 insertions(+), 31 deletions(-)



