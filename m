Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AE5531A11
	for <lists+linux-can@lfdr.de>; Mon, 23 May 2022 22:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiEWUIR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 23 May 2022 16:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiEWUIR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 23 May 2022 16:08:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B1995DFB
        for <linux-can@vger.kernel.org>; Mon, 23 May 2022 13:08:15 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ntELd-0002e8-Rd
        for linux-can@vger.kernel.org; Mon, 23 May 2022 22:08:13 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 525C084898
        for <linux-can@vger.kernel.org>; Mon, 23 May 2022 20:08:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E7EF984893;
        Mon, 23 May 2022 20:08:12 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 96f58adf;
        Mon, 23 May 2022 20:08:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH net-next 0/n] pull-request: can-next 2022-05-23
Date:   Mon, 23 May 2022 22:08:06 +0200
Message-Id: <20220523200809.1708614-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Jakub, hello David,

this is a pull request of 3 patches for net-next/master.

The first patch is by Julia Lawall and fixes a typo in the peak_usb
driver.

Jakub Kicinski contributes a patch for the kvaser_usb driver to
silence a GCC 12 -Warray-bounds warning.

The last patch is by me, target the ctucanfd platform driver and adds
a missing dependency to HAS_IOMEM.

regards,
Marc

---

The following changes since commit fe7324b932222574a0721b80e72c6c5fe57960d1:

  net: dsa: OF-ware slave_mii_bus (2022-05-23 12:27:53 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-5.19-20220523

for you to fetch changes up to 8f445a3ec3fd36feb90c5b2ef8d21e2492819cdc:

  can: ctucanfd: platform: add missing dependency to HAS_IOMEM (2022-05-23 22:00:06 +0200)

----------------------------------------------------------------
linux-can-next-for-5.19-20220523

----------------------------------------------------------------
Jakub Kicinski (1):
      can: kvaser_usb: silence a GCC 12 -Warray-bounds warning

Julia Lawall (1):
      can: peak_usb: fix typo in comment

Marc Kleine-Budde (1):
      can: ctucanfd: platform: add missing dependency to HAS_IOMEM

 drivers/net/can/ctucanfd/Kconfig        | 2 +-
 drivers/net/can/usb/kvaser_usb/Makefile | 5 +++++
 drivers/net/can/usb/peak_usb/pcan_usb.c | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)


