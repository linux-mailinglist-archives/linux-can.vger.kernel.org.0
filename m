Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B90707AF5
	for <lists+linux-can@lfdr.de>; Thu, 18 May 2023 09:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjERHdS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 May 2023 03:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjERHdN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 May 2023 03:33:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6006126AA
        for <linux-can@vger.kernel.org>; Thu, 18 May 2023 00:32:49 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pzY7x-0000zl-O7
        for linux-can@vger.kernel.org; Thu, 18 May 2023 09:32:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 93B9B1C7A0F
        for <linux-can@vger.kernel.org>; Thu, 18 May 2023 07:32:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 859FC1C79F8;
        Thu, 18 May 2023 07:32:43 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bdffd252;
        Thu, 18 May 2023 07:32:42 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH net 0/7] pull-request: can 2023-05-18
Date:   Thu, 18 May 2023 09:32:34 +0200
Message-Id: <20230518073241.1110453-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
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

Hello netdev-team,

this is a pull request of 7 patches for net/master.

The first 6 patches are by Jimmy Assarsson and fix several bugs in the
kvaser_pciefd driver.

The latest patch is from me and reverts a change in stm32f746.dtsi
that causes build errors due to a missing dependent patch.

regards,
Marc

---

The following changes since commit 6ad85ed0ebf7ece0f376950a6b3b3c6048093d35:

  Merge tag 'ipsec-2023-05-16' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec (2023-05-16 20:52:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.4-20230518

for you to fetch changes up to 36a6418bb125944838b91a33eddca4064a5eb610:

  Revert "ARM: dts: stm32: add CAN support on stm32f746" (2023-05-17 20:20:12 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.4-20230518

----------------------------------------------------------------
Jimmy Assarsson (6):
      can: kvaser_pciefd: Set CAN_STATE_STOPPED in kvaser_pciefd_stop()
      can: kvaser_pciefd: Clear listen-only bit if not explicitly requested
      can: kvaser_pciefd: Call request_irq() before enabling interrupts
      can: kvaser_pciefd: Empty SRB buffer in probe
      can: kvaser_pciefd: Do not send EFLUSH command on TFD interrupt
      can: kvaser_pciefd: Disable interrupts in probe error path

Marc Kleine-Budde (2):
      Merge patch series "can: kvaser_pciefd: Bug fixes"
      Revert "ARM: dts: stm32: add CAN support on stm32f746"

 arch/arm/boot/dts/stm32f746.dtsi | 47 ------------------------------------
 drivers/net/can/kvaser_pciefd.c  | 51 +++++++++++++++++++++++-----------------
 2 files changed, 29 insertions(+), 69 deletions(-)


