Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF0D3AC5DC
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 10:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhFRIVu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Jun 2021 04:21:50 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:22439 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhFRIVm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 04:21:42 -0400
Received: from localhost.localdomain ([114.149.34.46])
        by mwinf5d28 with ME
        id JYKA2500J0zjR6y03YKXdl; Fri, 18 Jun 2021 10:19:33 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 18 Jun 2021 10:19:33 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 1/2] can: netlink: clear data_bittiming if fd is turned off
Date:   Fri, 18 Jun 2021 17:19:03 +0900
Message-Id: <20210618081904.141114-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210618081904.141114-1-mailhol.vincent@wanadoo.fr>
References: <20210618081904.141114-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When the FD is turned off through the netlink interface, the value
still remain in data_bittiming and are displayed despite of the
feature being disabled.

Example:

$ ip link set can0 type can bitrate 500000 dbitrate 2000000 fd on
$ ip --details link show can0
1:  can0: <NOARP,ECHO> mtu 72 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 10
    link/can  promiscuity 0 minmtu 0 maxmtu 0
    can <FD> state STOPPED restart-ms 0
	  bitrate 500000 sample-point 0.875
	  tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
	  ES582.1/ES584.1: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp-inc 1
	  dbitrate 2000000 dsample-point 0.750
	  dtq 12 dprop-seg 14 dphase-seg1 15 dphase-seg2 10 dsjw 1
	  ES582.1/ES584.1: dtseg1 2..32 dtseg2 1..16 dsjw 1..8 dbrp 1..32 dbrp-inc 1
	  clock 80000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535

$ ip link set can0 type can bitrate 500000 fd off
$ ip --details link show can0
1:  can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 10
    link/can  promiscuity 0 minmtu 0 maxmtu 0
    can state STOPPED restart-ms 0
	  bitrate 500000 sample-point 0.875
	  tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
	  ES582.1/ES584.1: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp-inc 1
	  dbitrate 2000000 dsample-point 0.750
	  dtq 12 dprop-seg 14 dphase-seg1 15 dphase-seg2 10 dsjw 1
	  ES582.1/ES584.1: dtseg1 2..32 dtseg2 1..16 dsjw 1..8 dbrp 1..32 dbrp-inc 1
	  clock 80000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535

Remark: once FD is turned off, it is not possible to just turn fd back
on and reuse the previously input data bittiming values:

$ ip link set can0 type can bitrate 500000 fd on
RTNETLINK answers: Operation not supported

This means that the user will need to overwrite data bittiming with
fresh values in order to turn fd on again.

Because old data bittiming values can not be reused, this patch just
clears priv->data_bittiming whenever FD is turned off. This way, the
data bittiming variables are not displayed anymore.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Hi Marc,

I suggest to rebase this patch before the netlink TDC series.
---
 drivers/net/can/dev/netlink.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index e8c38d0df626..b8d531e49540 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -201,10 +201,13 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		priv->ctrlmode |= maskedflags;
 
 		/* CAN_CTRLMODE_FD can only be set when driver supports FD */
-		if (priv->ctrlmode & CAN_CTRLMODE_FD)
+		if (priv->ctrlmode & CAN_CTRLMODE_FD) {
 			dev->mtu = CANFD_MTU;
-		else
+		} else {
 			dev->mtu = CAN_MTU;
+			memset(&priv->data_bittiming, 0,
+			       sizeof(priv->data_bittiming));
+		}
 	}
 
 	if (data[IFLA_CAN_RESTART_MS]) {
-- 
2.31.1

