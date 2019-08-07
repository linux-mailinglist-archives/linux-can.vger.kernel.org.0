Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4355B848FA
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2019 11:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfHGJzs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Aug 2019 05:55:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36497 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbfHGJzs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Aug 2019 05:55:48 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hvIfY-0005F3-HO; Wed, 07 Aug 2019 11:55:44 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hvIfX-0001hb-3d; Wed, 07 Aug 2019 11:55:43 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: =?UTF-8?q?=5BPATCH=20v1=200/5=5D=20last=20patch=20=E2=84=A2=20+1?=
Date:   Wed,  7 Aug 2019 11:55:36 +0200
Message-Id: <20190807095541.2544-1-o.rempel@pengutronix.de>
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

Some more last patches: Fixes and cleanups.

Oleksij Rempel (5):
  j1939: transport: refactor j1939_tp_txtimer()
  j1939: make J1939_ERRQUEUE_SCHED/ACK optional again.
  j1939: add comments for locks
  j1939: remove session lock
  j1939: transport: refactor j1939_xtp_rx_cts_one()

 net/can/j1939/j1939-priv.h |   6 +-
 net/can/j1939/socket.c     |   7 ++-
 net/can/j1939/transport.c  | 120 ++++++++++++++++---------------------
 3 files changed, 62 insertions(+), 71 deletions(-)

-- 
2.20.1

