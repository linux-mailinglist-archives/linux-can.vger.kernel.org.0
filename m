Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DD5721EA7
	for <lists+linux-can@lfdr.de>; Mon,  5 Jun 2023 09:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjFEHBL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 5 Jun 2023 03:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjFEHBF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Jun 2023 03:01:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51530100
        for <linux-can@vger.kernel.org>; Mon,  5 Jun 2023 00:00:52 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1q64Cw-0007mg-Nl
        for linux-can@vger.kernel.org; Mon, 05 Jun 2023 09:00:50 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5BAC61D20DC
        for <linux-can@vger.kernel.org>; Mon,  5 Jun 2023 06:59:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 62BBC1D20C6;
        Mon,  5 Jun 2023 06:59:54 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c99a8122;
        Mon, 5 Jun 2023 06:59:53 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH net 0/3] pull-request: can 2023-06-05
Date:   Mon,  5 Jun 2023 08:59:49 +0200
Message-Id: <20230605065952.1074928-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

this is a pull request of 3 patches for net/master.

All 3 patches target the j1939 stack.

The 1st patch is by Oleksij Rempel and fixes the error queue handling
for (E)TP sessions that run into timeouts.

The last 2 patches are by Fedor Pchelkin and fix a potential
use-after-free in j1939_netdev_start() if j1939_can_rx_register()
fails.

regards,
Marc

---

The following changes since commit 8cde87b007dad2e461015ff70352af56ceb02c75:

  net: sched: wrap tc_skip_wrapper with CONFIG_RETPOLINE (2023-06-04 15:49:06 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.4-20230605

for you to fetch changes up to 628f725d3b090fadcc3735aaf4332e778335188e:

  Merge patch series "can: j1939: avoid possible use-after-free when j1939_can_rx_register fails" (2023-06-05 08:27:23 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.4-20230605

----------------------------------------------------------------
Fedor Pchelkin (2):
      can: j1939: change j1939_netdev_lock type to mutex
      can: j1939: avoid possible use-after-free when j1939_can_rx_register fails

Marc Kleine-Budde (1):
      Merge patch series "can: j1939: avoid possible use-after-free when j1939_can_rx_register fails"

Oleksij Rempel (1):
      can: j1939: j1939_sk_send_loop_abort(): improved error queue handling in J1939 Socket

 net/can/j1939/main.c   | 24 +++++++++++++-----------
 net/can/j1939/socket.c |  5 +++++
 2 files changed, 18 insertions(+), 11 deletions(-)


