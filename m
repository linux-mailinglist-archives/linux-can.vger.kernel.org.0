Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B0575FA50
	for <lists+linux-can@lfdr.de>; Mon, 24 Jul 2023 17:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGXPBu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 24 Jul 2023 11:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjGXPBs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Jul 2023 11:01:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1083110DC
        for <linux-can@vger.kernel.org>; Mon, 24 Jul 2023 08:01:46 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qNx4D-0004qW-Dr
        for linux-can@vger.kernel.org; Mon, 24 Jul 2023 17:01:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 721E81F8A41
        for <linux-can@vger.kernel.org>; Mon, 24 Jul 2023 15:01:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8B3CE1F8A36;
        Mon, 24 Jul 2023 15:01:43 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id eacadee7;
        Mon, 24 Jul 2023 15:01:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH net 0/2] pull-request: can 2023-07-24
Date:   Mon, 24 Jul 2023 17:01:39 +0200
Message-Id: <20230724150141.766047-1-mkl@pengutronix.de>
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

this is a pull request of 2 patches for net/master.

The first patch is by me and adds a missing set of CAN state to
CAN_STATE_STOPPED on close in the gs_usb driver.

The last patch is by Eric Dumazet and fixes a lockdep issue in the CAN
raw protocol.

regards,
Marc

---

The following changes since commit 9f9d4c1a2e82174a4e799ec405284a2b0de32b6a:

  net: ethernet: mtk_eth_soc: always mtk_get_ib1_pkt_type (2023-07-19 21:15:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.5-20230724

for you to fetch changes up to 11c9027c983e9e4b408ee5613b6504d24ebd85be:

  can: raw: fix lockdep issue in raw_release() (2023-07-20 13:46:29 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.5-20230724

----------------------------------------------------------------
Eric Dumazet (1):
      can: raw: fix lockdep issue in raw_release()

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_close(): add missing set of CAN state to CAN_STATE_STOPPED

 drivers/net/can/usb/gs_usb.c | 2 ++
 net/can/raw.c                | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)


