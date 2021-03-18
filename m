Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006AA3402C0
	for <lists+linux-can@lfdr.de>; Thu, 18 Mar 2021 11:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhCRKJM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Mar 2021 06:09:12 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:22126 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhCRKIt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Mar 2021 06:08:49 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Mar 2021 06:08:49 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1616061768; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HrpjKmCKzJ/9hJ6rt5Y2wXrnfU0WsHHSm0HqwwZjLFhdV7x6+UvEOw/MKPKu1FoWoC
    B4ar8iKpI2J/KVREv0AxpH7kRy1lfR/pBclFWlnvhIrTWhAAglMR/ogMcAWrASnZnTZU
    b6sRX8aQFmaRyCc3hXSPSHlc8nk+Iutx6dTDXp8bBknInXR/yPxJz6in/49dVGjKPc8K
    /jLP7ip8cu6G9V9+rk0UZcZKmeRadojT/jgoxjB21cGWcf/k3lnAKh11H245A7fOp82W
    tFtQXKnvRS5n4z2WYXUVGkShtF6v2A1QxjkkK+o9k3F9rFV70GNMbhDT217NA08gIaMP
    SAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616061768;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=iV6VyBFQCBkWM4l0J73JeGLoz1Nwuc0A5kwLehJf1xc=;
    b=ZpL6Jj8YXgJJTvMAejg0sArR1TZU6EOj3uBl/oMAMO5WeXnCsqmhGCHg7tBAtJ+Mhx
    HRa/uNNSarJU773vdvjwIRXkEZKDRU0CvwCvytguxJ/RxjUf+4i17aXjabDbv+ads4q5
    k90ODKJemuN/qSYwS5mkB3MILCPZfvXaA9Uv4HdLqrNfq0oqBOtdV5wBQSaG7/E7u4K4
    qlzCdwg0dJx4Skl/+KnihQzlf/KnjJVHdtRwJIDHZxXjtHrwG+uw1juauVqbQoQ3m/tG
    oWhRmrt1Nk8TmAvEY59kCEJjpcc9nhsprSP/MXySrThF3PlvVeJaoQk2Pn7/cE2f1Reo
    d2mQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616061768;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=iV6VyBFQCBkWM4l0J73JeGLoz1Nwuc0A5kwLehJf1xc=;
    b=p2KXM1nfR8fOX7kjKSyqLli/jluCKkLwH9bANdGMkgYHaEe1o/qMQmsVs3b+Vm5N6y
    GgHIER7ehlX5GVPmwFhBSmrPNpl47RSyA+iTE+faAjQvHa327qXL5QwFJDIbiE5tbSOC
    e0Kdgbz8MGsX7gfS81nfgZZYcM6FjjeZjFFAP/NRkeVI8dmMY4c/hSSVmtSFzAyZ+ihj
    cKRYNVkhrjIxsed6nTanL1AfDDuxn1/SrnLqDcbVDwMlCwcmq9BaBnFDVtH6tAfVNJhz
    VAOkxPk+iI4MgEesy7nDFK9MYr4jgupaqswTgxc2l15HYg9Ufod/Rnws8ux5BK7rC8e7
    cQEw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVLzM8tyWW"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.21.0 DYNA|AUTH)
    with ESMTPSA id R01debx2IA2m1nq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 18 Mar 2021 11:02:48 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: isotp: tx-path: zero initialize outgoing CAN frames
Date:   Thu, 18 Mar 2021 11:02:33 +0100
Message-Id: <20210318100233.1693-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Commit d4eb538e1f48 ("can: isotp: TX-path: ensure that CAN frame flags are
initialized") ensured the TX flags to be properly set for outgoing CAN frames.

In fact the root cause of the issue results from a missing initialization of
outgoing CAN frames created by isotp. This is no problem on the CAN bus as the
CAN driver only picks the correctly defined content from the struct
can(fd)_frame. But when the outgoing frames are monitored (e.g. with candump)
we potentially leak some bytes in the unused content of struct can(fd)_frame.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 430976485d95..3eeb80b28ea8 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -195,10 +195,11 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
 	ncf = (struct canfd_frame *)nskb->data;
 	skb_put(nskb, so->ll.mtu);
+	memset(ncf, 0, so->ll.mtu);
 
 	/* create & send flow control reply */
 	ncf->can_id = so->txid;
 
 	if (so->opt.flags & CAN_ISOTP_TX_PADDING) {
@@ -778,10 +779,11 @@ static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
 		can_skb_prv(skb)->ifindex = dev->ifindex;
 		can_skb_prv(skb)->skbcnt = 0;
 
 		cf = (struct canfd_frame *)skb->data;
 		skb_put(skb, so->ll.mtu);
+		memset(cf, 0, so->ll.mtu);
 
 		/* create consecutive frame */
 		isotp_fill_dataframe(cf, so, ae, 0);
 
 		/* place consecutive frame N_PCI in appropriate index */
@@ -894,10 +896,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	so->tx.len = size;
 	so->tx.idx = 0;
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put(skb, so->ll.mtu);
+	memset(cf, 0, so->ll.mtu);
 
 	/* check for single frame transmission depending on TX_DL */
 	if (size <= so->tx.ll_dl - SF_PCI_SZ4 - ae - off) {
 		/* The message size generally fits into a SingleFrame - good.
 		 *
-- 
2.30.1

