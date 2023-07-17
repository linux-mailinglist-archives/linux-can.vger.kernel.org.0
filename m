Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165D6756B49
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 20:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjGQSJq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 14:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQSJp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 14:09:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA75299
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 11:09:44 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLSfH-00085A-Do
        for linux-can@vger.kernel.org; Mon, 17 Jul 2023 20:09:43 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 154F81F3952
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 18:09:42 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 119B41F3941;
        Mon, 17 Jul 2023 18:09:41 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 793fb659;
        Mon, 17 Jul 2023 18:09:40 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH net 0/5] pull-request: can 2023-07-17
Date:   Mon, 17 Jul 2023 20:09:33 +0200
Message-Id: <20230717180938.230816-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
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

Hello netdev-team,

this is a pull request of 5 patches for net/master.

The 1st patch is by Ziyang Xuan and fixes a possible memory leak in
the receiver handling in the CAN RAW protocol.

YueHaibing contributes a use after free in bcm_proc_show() of the
Broad Cast Manager (BCM) CAN protocol.

The next 2 patches are by me and fix a possible null pointer
dereference in the RX path of the gs_usb driver with activated
hardware timestamps and the candlelight firmware.

The last patch is by Fedor Ross, Marek Vasut and me and targets the
mcp251xfd driver. The polling timeout of __mcp251xfd_chip_set_mode()
is increased to fix bus joining on busy CAN buses and very low bit
rate.

regards,
Marc

---

The following changes since commit 0dd1805fe498e0cf64f68e451a8baff7e64494ec:

  Merge branch 'net-fix-kernel-doc-problems-in-include-net' (2023-07-14 20:39:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.5-20230717

for you to fetch changes up to 9efa1a5407e81265ea502cab83be4de503decc49:

  can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll timeout (2023-07-17 19:54:51 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.5-20230717

----------------------------------------------------------------
Fedor Ross (1):
      can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll timeout

Marc Kleine-Budde (3):
      can: gs_usb: gs_can_open(): improve error handling
      can: gs_usb: fix time stamp counter initialization
      Merge patch series "can: gs_usb: fix time stamp counter initialization"

YueHaibing (1):
      can: bcm: Fix UAF in bcm_proc_show()

Ziyang Xuan (1):
      can: raw: fix receiver memory leak

 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c |  10 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h      |   1 +
 drivers/net/can/usb/gs_usb.c                   | 130 ++++++++++++++-----------
 net/can/bcm.c                                  |  12 +--
 net/can/raw.c                                  |  57 +++++------
 5 files changed, 113 insertions(+), 97 deletions(-)


