Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783BB7B9FD4
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 16:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjJEOaM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 10:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjJEO2c (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 10:28:32 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE85221D1F
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 02:46:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoKwP-0002uo-Fe
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 11:46:45 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoKwP-00BEc8-0M
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 11:46:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B712122F946
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 09:46:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id B79B722F933;
        Thu,  5 Oct 2023 09:46:43 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5f4e7e12;
        Thu, 5 Oct 2023 09:46:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH net 0/7] pull-request: can 2023-10-05
Date:   Thu,  5 Oct 2023 11:46:32 +0200
Message-Id: <20231005094639.387019-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello netdev-team,

this is a pull request of 7 patches for net/master.

The first patch is by Oleksij Rempel and fixes a UAF in the CAN J1939
protocol.

Lukas Magel's patch for the CAN ISO-TP protocol fixes the TX state
detection and wait behavior.

John Watts contributes a patch to only show the sun4i_can Kconfig
option on ARCH_SUNXI.

A patch by Miquel Raynal fixes the soft-reset workaround for Renesas
SoCs in the sja1000 driver.

Markus Schneider-Pargmann's patch for the tcan4x5x m_can glue driver
fixes the id2 register for the tcan4553.

2 patches by Haibo Chen fix the flexcan stop mode for the imx93 SoC.

regards,
Marc

---

The following changes since commit d0f95894fda7d4f895b29c1097f92d7fee278cb2:

  netlink: annotate data-races around sk->sk_err (2023-10-04 17:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.6-20231005

for you to fetch changes up to 9cf31160064431b035cd2f4cc4fb984c4f18ac8e:

  Merge patch series "arm64: dts: imx93: add the Flex-CAN stop mode by GPR" (2023-10-05 11:41:03 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.6-20231005

----------------------------------------------------------------
Haibo Chen (2):
      arm64: dts: imx93: add the Flex-CAN stop mode by GPR
      can: flexcan: remove the auto stop mode for IMX93

John Watts (1):
      can: sun4i_can: Only show Kconfig if ARCH_SUNXI is set

Lukas Magel (1):
      can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior

Marc Kleine-Budde (1):
      Merge patch series "arm64: dts: imx93: add the Flex-CAN stop mode by GPR"

Markus Schneider-Pargmann (1):
      can: tcan4x5x: Fix id2_register for tcan4553

Miquel Raynal (1):
      can: sja1000: Always restart the Tx queue after an overrun

Oleksij Rempel (1):
      can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)

 arch/arm64/boot/dts/freescale/imx93.dtsi |  4 ++-
 drivers/net/can/Kconfig                  |  2 +-
 drivers/net/can/flexcan/flexcan-core.c   | 46 +++++++++-----------------------
 drivers/net/can/flexcan/flexcan.h        |  2 --
 drivers/net/can/m_can/tcan4x5x-core.c    |  2 +-
 drivers/net/can/sja1000/sja1000.c        |  8 +++++-
 net/can/isotp.c                          | 19 ++++++-------
 net/can/j1939/socket.c                   | 19 ++++++++++---
 8 files changed, 48 insertions(+), 54 deletions(-)


