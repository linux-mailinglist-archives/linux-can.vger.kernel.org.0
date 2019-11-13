Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE172FADC5
	for <lists+linux-can@lfdr.de>; Wed, 13 Nov 2019 10:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfKMJz7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Nov 2019 04:55:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59367 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfKMJz7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Nov 2019 04:55:59 -0500
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iUpNT-0006Nh-Gm; Wed, 13 Nov 2019 10:55:55 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: pull-request: can 2019-11-13
Date:   Wed, 13 Nov 2019 10:55:41 +0100
Message-Id: <20191113095550.26527-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello David,

this is a pull request of 9 patches for net/master, hopefully for the v5.4
release cycle.

All nine patches are by Oleksij Rempel and fix locking and use-after-free bugs
in the j1939 stack found by the syzkaller syzbot.

regards,
Marc

---

The following changes since commit 5aa4277d4368c099223bbcd3a9086f3351a12ce9:

  dpaa2-eth: free already allocated channels on probe defer (2019-11-12 19:49:27 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-5.4-20191113

for you to fetch changes up to 4a15d574e68afffbe8d7265e015cda2ac2a248ec:

  can: j1939: warn if resources are still linked on destroy (2019-11-13 10:42:34 +0100)

----------------------------------------------------------------
linux-can-fixes-for-5.4-20191113

----------------------------------------------------------------
Oleksij Rempel (9):
      can: af_can: export can_sock_destruct()
      can: j1939: move j1939_priv_put() into sk_destruct callback
      can: j1939: main: j1939_ndev_to_priv(): avoid crash if can_ml_priv is NULL
      can: j1939: socket: rework socket locking for j1939_sk_release() and j1939_sk_sendmsg()
      can: j1939: transport: make sure the aborted session will be deactivated only once
      can: j1939: make sure socket is held as long as session exists
      can: j1939: transport: j1939_cancel_active_session(): use hrtimer_try_to_cancel() instead of hrtimer_cancel()
      can: j1939: j1939_can_recv(): add priv refcounting
      can: j1939: warn if resources are still linked on destroy

 include/linux/can/core.h  |  1 +
 net/can/af_can.c          |  3 +-
 net/can/j1939/main.c      |  9 +++++
 net/can/j1939/socket.c    | 94 +++++++++++++++++++++++++++++++++++++----------
 net/can/j1939/transport.c | 36 +++++++++++++-----
 5 files changed, 113 insertions(+), 30 deletions(-)


