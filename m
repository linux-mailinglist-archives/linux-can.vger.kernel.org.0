Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D5E3A9894
	for <lists+linux-can@lfdr.de>; Wed, 16 Jun 2021 13:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhFPLEj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 07:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhFPLEF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 07:04:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BCCC061283
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 04:01:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ltTJ0-0007kK-2Z
        for linux-can@vger.kernel.org; Wed, 16 Jun 2021 13:01:58 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E241D63D298
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 11:01:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 75DF763D28C;
        Wed, 16 Jun 2021 11:01:54 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b4297ccf;
        Wed, 16 Jun 2021 11:01:53 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: pull-request: can 2021-06-16
Date:   Wed, 16 Jun 2021 13:01:48 +0200
Message-Id: <20210616110152.2456765-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
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

this is a pull request of 4 patches for net/master.

The first patch is by Oleksij Rempel and fixes a Use-after-Free found
by syzbot in the j1939 stack.

The next patch is by Tetsuo Handa and fixes hung task detected by
syzbot in the bcm, raw and isotp protocols.

Norbert Slusarek's patch fixes a infoleak in bcm's struct
bcm_msg_head.

Pavel Skripkin's patch fixes a memory leak in the mcba_usb driver.

regards,
Marc

---

The following changes since commit a4f0377db1254373513b992ff31a351a7111f0fd:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2021-06-15 15:26:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-5.13-20210616

for you to fetch changes up to 91c02557174be7f72e46ed7311e3bea1939840b0:

  can: mcba_usb: fix memory leak in mcba_usb (2021-06-16 12:52:18 +0200)

----------------------------------------------------------------
linux-can-fixes-for-5.13-20210616

----------------------------------------------------------------
Norbert Slusarek (1):
      can: bcm: fix infoleak in struct bcm_msg_head

Oleksij Rempel (1):
      can: j1939: fix Use-after-Free, hold skb ref while in use

Pavel Skripkin (1):
      can: mcba_usb: fix memory leak in mcba_usb

Tetsuo Handa (1):
      can: bcm/raw/isotp: use per module netdevice notifier

 drivers/net/can/usb/mcba_usb.c | 17 ++++++++++--
 net/can/bcm.c                  | 62 +++++++++++++++++++++++++++++++++---------
 net/can/isotp.c                | 61 ++++++++++++++++++++++++++++++++---------
 net/can/j1939/transport.c      | 54 ++++++++++++++++++++++++++----------
 net/can/raw.c                  | 62 ++++++++++++++++++++++++++++++++----------
 5 files changed, 200 insertions(+), 56 deletions(-)



