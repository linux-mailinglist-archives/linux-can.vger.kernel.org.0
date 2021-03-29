Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D110234CC10
	for <lists+linux-can@lfdr.de>; Mon, 29 Mar 2021 11:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhC2Iz2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 Mar 2021 04:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbhC2IyB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Mar 2021 04:54:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEA7C061574
        for <linux-can@vger.kernel.org>; Mon, 29 Mar 2021 01:54:01 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lQneq-0003V0-05
        for linux-can@vger.kernel.org; Mon, 29 Mar 2021 10:54:00 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 67485602990
        for <linux-can@vger.kernel.org>; Mon, 29 Mar 2021 08:53:58 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 70FE4602988;
        Mon, 29 Mar 2021 08:53:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id aa04ce39;
        Mon, 29 Mar 2021 08:53:56 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: pull-request: can 2021-03-29
Date:   Mon, 29 Mar 2021 10:53:52 +0200
Message-Id: <20210329085355.921447-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Jakub, hello David,

this is a pull request of 3 patches for net/master.

The two patch are by Oliver Hartkopp. He fixes length check in the
proto_ops::getname callback for the CAN RAW, BCM and ISOTP protocols,
which were broken by the introduction of the J1939 protocol.

The last patch is by me and fixes the a BUILD_BUG_ON() check which
triggers on ARCH=arm with CONFIG_AEABI unset.

regards,
Marc

---

The following changes since commit 1b479fb801602b22512f53c19b1f93a4fc5d5d9d:

  drivers/net/wan/hdlc_fr: Fix a double free in pvc_xmit (2021-03-28 18:08:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-5.12-20210329

for you to fetch changes up to f5076c6ba02e8e24c61c40bbf48078929bc0fc79:

  can: uapi: can.h: mark union inside struct can_frame packed (2021-03-29 09:51:49 +0200)

----------------------------------------------------------------
linux-can-fixes-for-5.12-20210329

----------------------------------------------------------------
Marc Kleine-Budde (1):
      can: uapi: can.h: mark union inside struct can_frame packed

Oliver Hartkopp (2):
      can: bcm/raw: fix msg_namelen values depending on CAN_REQUIRED_SIZE
      can: isotp: fix msg_namelen values depending on CAN_REQUIRED_SIZE

 include/uapi/linux/can.h |  2 +-
 net/can/bcm.c            | 10 ++++++----
 net/can/isotp.c          | 11 +++++++----
 net/can/raw.c            | 14 ++++++++------
 4 files changed, 22 insertions(+), 15 deletions(-)



