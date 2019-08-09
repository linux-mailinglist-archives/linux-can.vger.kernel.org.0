Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2545B87451
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 10:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405928AbfHIIga (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 04:36:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60833 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405925AbfHIIga (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 04:36:30 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NQ-00058z-IF; Fri, 09 Aug 2019 10:35:56 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NO-0004OD-D2; Fri, 09 Aug 2019 10:35:54 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: =?UTF-8?q?=5BPATCH=20v1=2000/21=5D=20last=20patch=20=E2=84=A2=20+2=20?=
Date:   Fri,  9 Aug 2019 10:35:32 +0200
Message-Id: <20190809083553.16687-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patches are mostly addressing issues related to opened CAN bus
+ interface down/unregister event.

Oleksij Rempel (21):
  j1939: transport: refactor j1939_tp_txtimer()
  j1939: transport: j1939_tp_txtimer(): set missing error value for
    simple session in error path
  j1939: make J1939_ERRQUEUE_SCHED/ACK optional again.
  j1939: remove session lock
  j1939: add comments for locks
  j1939: transport: refactor j1939_xtp_rx_cts_one()
  j1939: cancel all active sessions on net down
  j1939: no need to deactivate not active sessions
  j1939: socket: j1939_sk_queue_drop_all(): iterate forwards not
    backwards over the socket session-queue
  j1939: j1939_sk_errqueue: add some debug
  j1939: j1939_sk_queue_drop_all: set error reason
  j1939: add more debug info
  j1939: j1939_cancel_all_active_sessions: add option to cancel only one
    socket
  j1939: socket: cancel all socket related active sessions on
    j1939_sk_release()
  j1939: set proper error value for simple session timeout
  j1939: change default timeout for simple sessions
  j1939: j1939_sk_netdev_event: use priv directly
  j1939: j1939_netdev_notify: remove netspace left over code
  j1939: store priv in jsk
  j1939: initialize the struct j1939_sock
  j1939: transport: ignore -ENETDOWN error

 net/can/j1939/j1939-priv.h |  13 +--
 net/can/j1939/main.c       |  11 +--
 net/can/j1939/socket.c     | 109 ++++++++++++------------
 net/can/j1939/transport.c  | 165 +++++++++++++++++++------------------
 4 files changed, 150 insertions(+), 148 deletions(-)

-- 
2.20.1

