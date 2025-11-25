Return-Path: <linux-can+bounces-5641-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BC9C84FE4
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 13:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 021F74E89F3
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140930CDAA;
	Tue, 25 Nov 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="TX1W3OjA";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="uoiTKJA6"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA218DB1E
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074364; cv=pass; b=ZDkp9nN3mlrObsLJ7L8DNE3ZwaYUk/hk0MJaHXj7w1EkpS7QG8Yen/tgFQyYI+0OBq72Ee5Ks/n+oT3s8APvwq4KMet1Ky+TFl6/x2X7bdU9GKSd8+2sY4zbw1yFegHqX1q6gaZoppJGJ91Nr/84va9SQOJoMfEXap1LibHb1wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074364; c=relaxed/simple;
	bh=odmNXRSVHCJpaxQaUGaHTVRhSe1XmlYN1erWE0FO0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEX/SQEFwXUCvf93fjxFffmscIG6HrEyV8msAP7m3dlBlq4HNEU2sqqX/Dksw4DLm3ixiKZYFIM46klYastTZkjt17tu2OgmfYmUwvI58oypuMfNMpbgfC+VkDf93hpDJqDgCNBVxCre1eJdRuR2OUiqj8RXy8aZ/VEXvUL4Pxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=TX1W3OjA; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=uoiTKJA6; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764074354; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PfOnv+15KGIKLa4FLUmzUqrgGlzzMjwVyDGRh91g6wf8IzGZ+Z2tybrbCnsZmqmcmA
    4U7NdNAj/rK6gyCrrB3yfF8Jtu0qC89meAtJzoKL6sz1K/dPmF/tTDokLOJt19bmf/b6
    kMq/DNfFpe5P1yZwqrwnYI2rUWuTFn290N7BfAqBVnNsPrBsd3uTvusG9zwz29u9P8sj
    xgau3HhrtHt0J5VJCAxmZ/BKoMqAgExny1EqtnHDwCxyqE65/yxTpUTmkmyx9JnWI/+x
    3DWI/jmdr1GoM/bXEMjFDjFstVopUI9y8nlEEZThzsXHo4vBnjd56BHaMNTFLB07ZKw+
    wIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074354;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R2HBjICR4zHJ6NbAEBWhWf91SklrpfIglkI8e4mDEwg=;
    b=VH+A2gvccr5Wk3ItOmmgHSrqFkQfMIqdc3j+cK0a3y8H2Y5qrqhn54KyFESk2OuY6x
    sY17X5YwA/2cjWEQZ3DqCFRQ7hWITTmNwlLzZpVhy4KgLLWg+EUrr3LwFGHj+72zZPF2
    0St+rBJwFMfFIgG3HcrMSOQK+kENYxzeDGgs+cXIMQR1NTmuZcy+1M8xTx8rZTeAixcM
    6Em2PWwQgx65p0u99XELTwl6Hq15VWi8QmmGl+Zs6WO1DSZGf30rPJJS/UT/FmcL1t9D
    uVdOOA/YPik1t+WrJN0n7lxVptbAncu8vMsrBTLfmT/faEsycuIlQB7xYN12vCkngvD9
    sZOQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074354;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R2HBjICR4zHJ6NbAEBWhWf91SklrpfIglkI8e4mDEwg=;
    b=TX1W3OjAqhi+c4VaWHso4aVTEs9py1E4N4VFyuLv+x0qG+DbA/pNa29TIRsOLgtfaa
    qN4eHCgrt+e9b5huqQ7EECD5XAbJfP4fM7OrQW2SH/9hsKTQkx3lw4P9v92+/xvWNXMc
    QA/lwj8pPIJQKutOrBCpzo6ljjnwVT78dr7J6HNyYPvur4HU2dTJU0iu78OnQ68q9ybV
    wQTgtMSZdThZ223mkRgz/0YPOuiYBZjIctRYZJMyHNsP9nUiL7qXEQC8O9FjTXBDsNcA
    8shtEIOhu8fWl3Q0ZfHU7cH+x6PSUyaIY7z8o4y66n725fVh5VDj4qg2QLchALVLE1zN
    PYNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764074354;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=R2HBjICR4zHJ6NbAEBWhWf91SklrpfIglkI8e4mDEwg=;
    b=uoiTKJA6jMIC1sT8gDB53vpYJA0tS1sxtawjSavKb/FkbDxI1juocm3lQeVrO3FqA6
    hDnyYKIgEb7rEM2HWYBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461APCdET8R
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Nov 2025 13:39:14 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v7 07/17] can: dev: can_dev_dropped_skb: drop CC/FD frames in CANXL-only mode
Date: Tue, 25 Nov 2025 13:38:49 +0100
Message-ID: <20251125123859.3924-8-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251125123859.3924-1-socketcan@hartkopp.net>
References: <20251125123859.3924-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The error-signalling (ES) is a mandatory functionality for CAN CC and
CAN FD to report CAN frame format violations by sending an error-frame
signal on the bus.

A so-called 'mixed-mode' is intended to have (XL-tolerant) CAN FD nodes
and CAN XL nodes on one CAN segment, where the FD-controllers can talk
CC/FD and the XL-controllers can talk CC/FD/XL. This mixed-mode
utilizes the error-signalling for sending CC/FD/XL frames.

The CANXL-only mode disables the error-signalling in the CAN XL
controller. This mode does not allow CC/FD frames to be sent but
additionally offers a CAN XL transceiver mode switching (TMS).

Configured with CAN_CTRLMODE_FD and CAN_CTRLMODE_XL this leads to:

FD=0 XL=0 CC-only mode         (ES=1)
FD=1 XL=0 FD/CC mixed-mode     (ES=1)
FD=1 XL=1 XL/FD/CC mixed-mode  (ES=1)
FD=0 XL=1 XL-only mode         (ES=0, TMS optional)

The helper function can_dev_in_xl_only_mode() determines the required
value to disable error signalling in the CAN XL controller.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/dev.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 945c16743702..13b25b0dceeb 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -129,10 +129,23 @@ int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
 
 const char *can_get_state_str(const enum can_state state);
 const char *can_get_ctrlmode_str(u32 ctrlmode);
 
+static inline bool can_dev_in_xl_only_mode(struct can_priv *priv)
+{
+	const u32 mixed_mode = CAN_CTRLMODE_FD | CAN_CTRLMODE_XL;
+
+	/* When CAN XL is enabled but FD is disabled we are running in
+	 * the so-called 'CANXL-only mode' where the error signalling is
+	 * disabled. This helper function determines the required value
+	 * to disable error signalling in the CAN XL controller.
+	 * The so-called CC/FD/XL 'mixed mode' requires error signalling.
+	 */
+	return ((priv->ctrlmode & mixed_mode) == CAN_CTRLMODE_XL);
+}
+
 /* drop skb if it does not contain a valid CAN frame for sending */
 static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *skb)
 {
 	struct can_priv *priv = netdev_priv(dev);
 	u32 silent_mode = priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
@@ -147,10 +160,16 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
 		netdev_info_once(dev, "CAN FD is disabled, dropping skb\n");
 		goto invalid_skb;
 	}
 
+	if (can_dev_in_xl_only_mode(priv) && !can_is_canxl_skb(skb)) {
+		netdev_info_once(dev,
+				 "Error signaling is disabled, dropping skb\n");
+		goto invalid_skb;
+	}
+
 	return can_dropped_invalid_skb(dev, skb);
 
 invalid_skb:
 	kfree_skb(skb);
 	dev->stats.tx_dropped++;
-- 
2.47.3


