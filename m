Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007E283200
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2019 14:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHFM6s (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Aug 2019 08:58:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58475 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbfHFM6r (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Aug 2019 08:58:47 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1huz37-0002wE-7f; Tue, 06 Aug 2019 14:58:45 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1huz36-0003qp-Hk; Tue, 06 Aug 2019 14:58:44 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: =?UTF-8?q?=5BPATCH=20v1=200/6=5D=20last=20patch=20=E2=84=A2?=
Date:   Tue,  6 Aug 2019 14:58:34 +0200
Message-Id: <20190806125840.5634-1-o.rempel@pengutronix.de>
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

This patch set is hopefully "last change ™" needed before upstreaming.
This will brake user space UAPI, so you will need to update your tools
to work with it.

Oleksij Rempel (6):
  j1939: remove CAN_J1939_DEBUG option
  j1939: j1939_can_recv: add sanity test on skb_clone
  j1939: remove SO_J1939_RECV_OWN support
  j1939: notify user space if simple package was transmitted by HW
  j1939: transport: remove SKBTX_ANY_TSTAMP from simple skb
  j1939: transport: j1939_xtp_rx_dat_one: add sanity check for
    j1939_session_skb_find()

 Documentation/networking/j1939.rst |  6 --
 include/uapi/linux/can/j1939.h     |  5 +-
 net/can/j1939/Kconfig              |  6 --
 net/can/j1939/Makefile             |  2 -
 net/can/j1939/j1939-priv.h         | 11 +---
 net/can/j1939/main.c               | 13 ++++-
 net/can/j1939/socket.c             | 32 +++++------
 net/can/j1939/transport.c          | 89 +++++++++++++++++++++++++++---
 8 files changed, 111 insertions(+), 53 deletions(-)

-- 
2.20.1

