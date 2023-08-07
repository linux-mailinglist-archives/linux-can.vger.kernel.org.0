Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67940771BB2
	for <lists+linux-can@lfdr.de>; Mon,  7 Aug 2023 09:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjHGHm3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Aug 2023 03:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjHGHm2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Aug 2023 03:42:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF1010FD
        for <linux-can@vger.kernel.org>; Mon,  7 Aug 2023 00:42:27 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qSusj-00036D-NF
        for linux-can@vger.kernel.org; Mon, 07 Aug 2023 09:42:25 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id DC9572058F0
        for <linux-can@vger.kernel.org>; Mon,  7 Aug 2023 07:42:24 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 020112058E8;
        Mon,  7 Aug 2023 07:42:23 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 50d2e1c7;
        Mon, 7 Aug 2023 07:42:23 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH net-next 0/1] pull-request: can-next 2023-08-07
Date:   Mon,  7 Aug 2023 09:42:21 +0200
Message-Id: <20230807074222.1576119-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello netdev-team,

this is a pull request of 1 patch for net-next/master.

The patch is from me and reverts the addition of the CAN controller
nodes in the allwinner d1 SoC.

regards,
Marc

---

The following changes since commit c35e927cbe09d38b2d72183bb215901183927c68:

  net: omit ndo_hwtstamp_get() call when possible in dev_set_hwtstamp_phylib() (2023-08-06 13:25:10 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.6-20230807

for you to fetch changes up to 84059a0ef5c6bea71b4f8f87de61d6218c4ddc9c:

  Revert "riscv: dts: allwinner: d1: Add CAN controller nodes" (2023-08-07 09:37:31 +0200)

----------------------------------------------------------------
linux-can-next-for-6.6-20230807

----------------------------------------------------------------
Marc Kleine-Budde (1):
      Revert "riscv: dts: allwinner: d1: Add CAN controller nodes"

 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 30 -----------------------
 1 file changed, 30 deletions(-)


