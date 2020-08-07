Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC30623EBCD
	for <lists+linux-can@lfdr.de>; Fri,  7 Aug 2020 13:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgHGLAv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Aug 2020 07:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgHGLAK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Aug 2020 07:00:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B0C061756
        for <linux-can@vger.kernel.org>; Fri,  7 Aug 2020 03:52:08 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1k3zym-0004n9-8h; Fri, 07 Aug 2020 12:52:04 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1k3zyk-0007Fv-0m; Fri, 07 Aug 2020 12:52:02 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        David Jander <david@protonic.nl>
Subject: [PATCH v1 0/5] j1939 fixes 
Date:   Fri,  7 Aug 2020 12:51:55 +0200
Message-Id: <20200807105200.26441-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch set include different fixes reported by google syzkaller or
other users.

Oleksij Rempel (5):
  can: j1939: transport: j1939_simple_recv(): ignore local J1939
    messages send not by J1939 stack
  can: j1939: transport: j1939_session_tx_dat(): fix use-after-free read
    in j1939_tp_txtimer()
  can: j1939: socket: j1939_sk_bind(): make sure ml_priv is allocated
  can: j1939: transport: add j1939_session_skb_find_by_offset() function
  can: j1939: transport: j1939_xtp_rx_dat_one(): compare own packets to
    detect corruptions

 net/can/j1939/socket.c    |  9 +++++++
 net/can/j1939/transport.c | 56 +++++++++++++++++++++++++++++++++------
 2 files changed, 57 insertions(+), 8 deletions(-)

-- 
2.28.0

