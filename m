Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4818B58D4F3
	for <lists+linux-can@lfdr.de>; Tue,  9 Aug 2022 09:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiHIHyv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Aug 2022 03:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbiHIHys (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Aug 2022 03:54:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143982127D
        for <linux-can@vger.kernel.org>; Tue,  9 Aug 2022 00:54:47 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oLK4c-0000UA-7r
        for linux-can@vger.kernel.org; Tue, 09 Aug 2022 09:54:46 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 82ABBC5561
        for <linux-can@vger.kernel.org>; Tue,  9 Aug 2022 07:53:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 3513AC555C;
        Tue,  9 Aug 2022 07:53:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0515bd6d;
        Tue, 9 Aug 2022 07:53:19 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH net 0/4] pull-request: can 2022-08-09
Date:   Tue,  9 Aug 2022 09:53:13 +0200
Message-Id: <20220809075317.1549323-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Jakub, hello David,

this is a pull request of 4 patches for net/master.

Fedor Pchelkin contributes 2 fixes for the j1939 CAN protcol.

A patch by me for the ems_usb driver fixes an unaligned-access
warning.

Sebastian Würl's patch for the mcp251x driver fixes a race condition
in the receive interrupt.

regards,
Marc

---

The following changes since commit b8c3bf0ed2edf2deaedba5f0bf0bb54c76dee71d:

  Merge tag 'for-net-2022-08-08' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth (2022-08-08 20:59:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.0-20220809

for you to fetch changes up to 72599394ad46226ca17a405fa0472078c3160c62:

  can: mcp251x: Fix race condition on receive interrupt (2022-08-09 09:05:06 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.0-20220809

----------------------------------------------------------------
Fedor Pchelkin (2):
      can: j1939: j1939_sk_queue_activate_next_locked(): replace WARN_ON_ONCE with netdev_warn_once()
      can: j1939: j1939_session_destroy(): fix memory leak of skbs

Marc Kleine-Budde (1):
      can: ems_usb: fix clang's -Wunaligned-access warning

Sebastian Würl (1):
      can: mcp251x: Fix race condition on receive interrupt

 drivers/net/can/spi/mcp251x.c | 18 +++++++++++++++---
 drivers/net/can/usb/ems_usb.c |  2 +-
 net/can/j1939/socket.c        |  5 ++++-
 net/can/j1939/transport.c     |  8 +++++++-
 4 files changed, 27 insertions(+), 6 deletions(-)


