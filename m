Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2E72FCDE4
	for <lists+linux-can@lfdr.de>; Wed, 20 Jan 2021 11:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbhATKHh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Jan 2021 05:07:37 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:24552 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbhATJMN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Jan 2021 04:12:13 -0500
Received: from tomoyo.flets-east.jp ([153.202.107.157])
        by mwinf5d39 with ME
        id Jx9m2400M3PnFJp03xA3Rd; Wed, 20 Jan 2021 10:10:09 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 20 Jan 2021 10:10:09 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Loris Fauster <loris.fauster@ttcontrol.com>,
        Alejandro Concepcion Rodriguez <alejandro@acoro.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 0/3] Fix several use after free bugs
Date:   Wed, 20 Jan 2021 18:09:27 +0900
Message-Id: <20210120090930.137581-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series fix three bugs which all have the same root cause.

When calling netif_rx(skb) and its variants, the skb will eventually
get consumed (or freed) and thus it is unsafe to dereference it after
the call returns.

This remark especially applies to any variable with aliases the skb
memory which is the case of the can(fd)_frame.

The pattern is as this:
    skb = alloc_can_skb(dev, &cf);
    /* Do stuff */
    netif_rx(skb);
    stats->rx_bytes += cf->len;

Increasing the stats should be done *before* the call to netif_rx()
while the skb is still safe to use.


Changes since v1:
  - fix a silly typo in patch 2/3 (variable len was declared twice...)


Vincent Mailhol (3):
  can: dev: can_restart: fix use after free bug
  can: vxcan: vxcan_xmit: fix use after free bug
  can: peak_usb: fix use after free bugs

 drivers/net/can/dev/dev.c                  | 4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 8 ++++----
 drivers/net/can/vxcan.c                    | 6 ++++--
 3 files changed, 10 insertions(+), 8 deletions(-)


base-commit: 1105592cb8fdfcc96f2c9c693ff4106bac5fac7c
-- 
2.26.2

