Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD87703EC1
	for <lists+linux-can@lfdr.de>; Mon, 15 May 2023 22:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244704AbjEOUrc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 May 2023 16:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242892AbjEOUra (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 May 2023 16:47:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D257EDA
        for <linux-can@vger.kernel.org>; Mon, 15 May 2023 13:47:29 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pyf6N-0004jm-9W
        for linux-can@vger.kernel.org; Mon, 15 May 2023 22:47:27 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id CAEA61C5C18
        for <linux-can@vger.kernel.org>; Mon, 15 May 2023 20:47:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C6B9F1C5C02;
        Mon, 15 May 2023 20:47:24 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9f6c67fa;
        Mon, 15 May 2023 20:47:24 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH net 0/9] pull-request: can 2023-05-15
Date:   Mon, 15 May 2023 22:47:13 +0200
Message-Id: <20230515204722.1000957-1-mkl@pengutronix.de>
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

this is a pull request of 9 patches for net/master.

The first 2 patches are by Oliver Hartkopp and allow the
MSG_CMSG_COMPAT flag for isotp and j1939.

The next patch is by Oliver Hartkopp, too and adds missing CAN XL
support in can_put_echo_skb().

Geert Uytterhoeven's patch let's the bxcan driver depend on
ARCH_STM32.

The last 5 patches are from Dario Binacchi and also affect the bxcan
driver. The bxcan driver hit mainline with v6.4-rc1 and was originally
written for IP cores containing 2 CAN interfaces with shared
resources. Dario's series updates the DT bindings and driver to
support IP cores with a single CAN interface instance as well as
adding the bxcan to the stm32f746's device tree.

regards,
Marc

---

The following changes since commit df0acdc59b094cdaef19b1c8d83c9721082bab7b:

  net: phylink: fix ksettings_set() ethtool call (2023-05-15 10:31:23 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.4-20230515

for you to fetch changes up to c08e24013aba49a593424715ffc04c928c84b9c9:

  Merge patch series "can: bxcan: add support for single peripheral configuration" (2023-05-15 22:26:39 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.4-20230515

----------------------------------------------------------------
Dario Binacchi (5):
      dt-bindings: net: can: add "st,can-secondary" property
      ARM: dts: stm32f429: put can2 in secondary mode
      ARM: dts: stm32: add pin map for CAN controller on stm32f7
      can: bxcan: add support for single peripheral configuration
      ARM: dts: stm32: add CAN support on stm32f746

Geert Uytterhoeven (1):
      can: CAN_BXCAN should depend on ARCH_STM32

Marc Kleine-Budde (1):
      Merge patch series "can: bxcan: add support for single peripheral configuration"

Oliver Hartkopp (3):
      can: isotp: recvmsg(): allow MSG_CMSG_COMPAT flag
      can: j1939: recvmsg(): allow MSG_CMSG_COMPAT flag
      can: dev: fix missing CAN XL support in can_put_echo_skb()

 .../bindings/net/can/st,stm32-bxcan.yaml           | 19 +++--
 arch/arm/boot/dts/stm32f429.dtsi                   |  1 +
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi             | 82 ++++++++++++++++++++++
 arch/arm/boot/dts/stm32f746.dtsi                   | 47 +++++++++++++
 drivers/net/can/Kconfig                            |  2 +-
 drivers/net/can/bxcan.c                            | 34 ++++++---
 drivers/net/can/dev/skb.c                          |  3 +-
 net/can/isotp.c                                    |  2 +-
 net/can/j1939/socket.c                             |  2 +-
 9 files changed, 173 insertions(+), 19 deletions(-)


