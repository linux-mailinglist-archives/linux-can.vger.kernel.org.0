Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B842797F
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfEWJlw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48673 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730298AbfEWJlu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:50 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEI-0001Ft-Pp; Thu, 23 May 2019 11:41:42 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-00043L-7i; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 00/17] introduce socket session queue support
Date:   Thu, 23 May 2019 11:41:22 +0200
Message-Id: <20190523094139.15517-1-o.rempel@pengutronix.de>
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

This patch series is a preparation and actual session queue support.
From now, we are able to use full available wmem of the socket and
queue all requests if it is needed. The stack will process
all queued requests in the FIFO order and notify user space application
about error or completion over the errqueue interface. 

As usual, reviews and tests are welcome.

Oleksij Rempel (17):
  j1939: store session type in to session and start to use it
  j1939: transport: do not send packets from j1939_tp_send
  j1939: transport: seed retry timeout for (E)TP sessions
  j1939: pack simple messages in to a session
  j1939: socket: use min_t where possible
  j1939: transport: fix broken refcounting on j1939_xtp_rx_rts_current
    error
  j1939: move struct j1939_sock to the header file
  j1939: transport: return proper error on skb underrun.
  j1939: split j1939_tp_send
  j1939: transport: cancel session on j1939_tp_txnext error
  j1939: transport: abort not started session if requested
  j1939: add session state
  j1939: transport: better protect j1939_session_insert with lock
  j1939: implement session queue
  j1939: rename j1939_sk_send_multi to j1939_sk_send_loop
  j1939: rename tp_sessionq to active_session_list
  j1939: rename jsk_fifo to sk_session_queue_entry

 net/can/j1939/j1939-priv.h |  78 +++++++-
 net/can/j1939/main.c       |   2 +
 net/can/j1939/socket.c     | 238 +++++++++++++----------
 net/can/j1939/transport.c  | 384 ++++++++++++++++++-------------------
 4 files changed, 388 insertions(+), 314 deletions(-)

-- 
2.20.1

