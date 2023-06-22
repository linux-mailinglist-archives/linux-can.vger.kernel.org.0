Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62CC739C30
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 11:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjFVJKx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 05:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjFVJKa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 05:10:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02AB5FE1
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 02:01:26 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qCGBx-0001gL-DC
        for linux-can@vger.kernel.org; Thu, 22 Jun 2023 11:01:25 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A5CD31DF61E
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 09:01:24 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id BDEFE1DF616;
        Thu, 22 Jun 2023 09:01:23 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4bcab1b3;
        Thu, 22 Jun 2023 09:01:23 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH net 0/n] pull-request: can 2023-06-22
Date:   Thu, 22 Jun 2023 11:01:21 +0200
Message-Id: <20230622090122.574506-1-mkl@pengutronix.de>
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

this is a pull request of 1 patch for net/master.

Oliver Hartkopp's patch fixes the return value in the error path of
isotp_sendmsg() in the CAN ISOTP protocol.

regards,
Marc

---

The following changes since commit 7f4e09700bdc13ce9aafa279bc999051e9bcda35:

  wifi: mac80211: report all unusable beacon frames (2023-06-21 22:55:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.4-20230622

for you to fetch changes up to e38910c0072b541a91954682c8b074a93e57c09b:

  can: isotp: isotp_sendmsg(): fix return error fix on TX path (2023-06-22 10:45:09 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.4-20230622

----------------------------------------------------------------
Oliver Hartkopp (1):
      can: isotp: isotp_sendmsg(): fix return error fix on TX path

 net/can/isotp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


