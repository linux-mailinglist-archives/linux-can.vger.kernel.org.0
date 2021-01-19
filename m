Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBAD2FBC63
	for <lists+linux-can@lfdr.de>; Tue, 19 Jan 2021 17:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbhASQ1q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jan 2021 11:27:46 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:33977 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729360AbhASQ13 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jan 2021 11:27:29 -0500
Received: from tomoyo.flets-east.jp ([153.202.107.157])
        by mwinf5d12 with ME
        id JgRY2400F3PnFJp03gRbnx; Tue, 19 Jan 2021 17:25:45 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Jan 2021 17:25:45 +0100
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
Subject: [PATCH 0/3] Fix several use after free bugs.
Date:   Wed, 20 Jan 2021 01:25:09 +0900
Message-Id: <20210119162512.5236-1-mailhol.vincent@wanadoo.fr>
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

Vincent Mailhol (3):
  can: dev: can_restart: fix use after free bug
  can: vxcan: vxcan_xmit: fix use after free bug
  can: peak_usb: fix use after free bugs

 drivers/net/can/dev/dev.c                  | 4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 8 ++++----
 drivers/net/can/vxcan.c                    | 6 ++++--
 3 files changed, 10 insertions(+), 8 deletions(-)


base-commit: 1105592cb8fdfcc96f2c9c693ff4106bac5fac7c
prerequisite-patch-id: d9d54d9159b70a5ef179d19d5add20caffbae638
-- 
2.26.2

