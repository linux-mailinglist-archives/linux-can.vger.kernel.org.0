Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA77458E7BF
	for <lists+linux-can@lfdr.de>; Wed, 10 Aug 2022 09:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiHJHTm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 Aug 2022 03:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiHJHPm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 Aug 2022 03:15:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187E8193
        for <linux-can@vger.kernel.org>; Wed, 10 Aug 2022 00:15:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oLfwI-00042N-Nc; Wed, 10 Aug 2022 09:15:38 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EF7DAC659E;
        Wed, 10 Aug 2022 07:15:37 +0000 (UTC)
Date:   Wed, 10 Aug 2022 09:15:31 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH net 0/4] pull-request: can 2022-08-10
Message-ID: <20220810071531.276vcbfcqxgdun4e@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

this is a pull request of 4 patches for net/master, with the
whitespace issue fixed.

Fedor Pchelkin contributes 2 fixes for the j1939 CAN protocol.

A patch by me for the ems_usb driver fixes an unaligned access
warning.

Sebastian Würl's patch for the mcp251x driver fixes a race condition
in the receive interrupt.

regards,
Marc

---

The following changes since commit b8c3bf0ed2edf2deaedba5f0bf0bb54c76dee71d:

  Merge tag 'for-net-2022-08-08' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth (2022-08-08 20:59:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.0-20220810

for you to fetch changes up to d80d60b0db6ff3dd2e29247cc2a5166d7e9ae37e:

  can: mcp251x: Fix race condition on receive interrupt (2022-08-09 21:40:22 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.0-20220810

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



