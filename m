Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D57CE3CC0F
	for <lists+linux-can@lfdr.de>; Tue, 11 Jun 2019 14:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbfFKMsV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jun 2019 08:48:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45337 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387596AbfFKMsV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2019 08:48:21 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCH-0006Ee-N4; Tue, 11 Jun 2019 14:48:17 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCG-0005OL-Dl; Tue, 11 Jun 2019 14:48:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 00/16] rx path work 
Date:   Tue, 11 Jun 2019 14:47:58 +0200
Message-Id: <20190611124814.19908-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
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

This patches targeting RX path of J1939 stack.
Most important changes in this patch set are:
- implement early (E)TP rx filter. With this change we should be
  able to abort early if socket is using some advanced filter ant
  won't be able to receive transfer.
- ignore bogus or unknown (E)TP control packets.

As, usual, reviews and testing are welcome.

Oleksij Rempel (16):
  j1939: transport: rename pending to active
  j1939: transport: limit amount of tx retries
  j1939: transport: use rxtimer to force session abort
  j1939: socket: simplify j1939_sk_queue_activate_next_locked
  j1939: transport: handle skb_clone() error in j1939_tp_txtimer()
  j1939: transport: remove j1939_fix_cb()
  j1939: implement early (E)TP rx filter
  j1939: transport: use j1939_tp_im_transmitter() where possible
  j1939: don't store msg_flags on the TX path
  j1939: transport: use addr instead of skbc in j1939_session_match()
  j1939: transport: do not abort session with different PGN
  j1939: transport: rework error handling on commands with wrong PGN
  j1939: transport: rename RTS current to active
  j1939: transport: use j1939_tp_im_receiver() to
    !j1939_tp_im_transmitter()
  j1939: transport: don't care about (E)TP commands less then 8 byte
  j1939: transport: ignore unknown commands.

 net/can/j1939/j1939-priv.h |   9 +-
 net/can/j1939/socket.c     |  96 +++++++----
 net/can/j1939/transport.c  | 319 +++++++++++++++++++------------------
 3 files changed, 236 insertions(+), 188 deletions(-)

-- 
2.20.1

