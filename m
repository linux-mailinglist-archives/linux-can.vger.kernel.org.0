Return-Path: <linux-can+bounces-5414-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 054B7C60467
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 12:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4A6735D832
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 11:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02AB298CC7;
	Sat, 15 Nov 2025 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="g83YfmVz";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="9H8v1bKy"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97628CF42
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763207649; cv=pass; b=nViKg7iPfZD+yYBz6S8Y60aKbkkqkckWfnv75esrVI4R31d3qYE3uXrRQq7Q53VmD28Kny7ib4noxkF+LNOolh1Uv4+mQyq5Dx+1jXC9RJUX+sHZenHQv0hDECmnl4zH3gDbcFsJj/EZp6m9GzusM7fahd0LCKKr2al6uEFy1IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763207649; c=relaxed/simple;
	bh=7dei3xyhgze5CNDEQDCrXxmv07hkVkBWFxgAGS7dqAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3kT/tKXKCW1ViesYbHSWeIFAvRnTvSUSfgJuFiRZTi02Kgby5FL/Z1LWroV/Ljih7MbRfwEZzqIHBwsP9msCFzsqoXacTUnsdlsfe51wbNXfnsuErGmiY4meHeXqXfqefxZmV+8suSTATDi+wPEfMdNu/ClWdTuClXNuY3V2gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=g83YfmVz; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=9H8v1bKy; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763207465; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KoHOyzYhjp/DUUEc63LXlRcn16AYqRNUFZEGa36mVAmZiJT/RoLogDN5ZpQ68IKkYY
    cJFU0lZxJITwgvUsh0yAXY//jJ1daNIK6Zgmymy4bkemegqOmYNEbBka0NJC9jR7tR6M
    sbU7Byo6cZCok1vNq4HW+qinu9QFUprPw6Cdvh3o4M8UTjKeVurzOhTla/t5l5x0p88x
    +/gWujWtwFhkPhhByFLyiizKTZQE0fwRcaXMBZI8h18fAb5aGRxD+YFiE9ZeU4ByOuLa
    eX0eNBBqYWZ/Gtc4epraN05TmYq3JSBHYH1pz4nGokB7+sqUsKXBasRJKR/aA3yEVnkb
    n+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207465;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=/sCHFmv0UPJlsCmbFKmk9k8g8iBRMR6sdrLsFxtQp9U=;
    b=NEsmpH2eiDTW7RC8ENQfpb1CnbLj6Q9Vd//pFwKXuOdusuDlBWbuuWJd9KpP8H1adW
    IKfhX2IgARBuwvK1nOa6T30Q6rXs3q6Z7WtDFc3/Pf62vggZ5x0q3YMMeeMnLIFujwuZ
    S3YtinzCN9AXR42O+EK47iD25BGQi94RYACBHSwAzAwMnu22NyySpY99Ocy/lsjkRWST
    g2VpAvrA1xnRmRcS/dtJTb1EjcIqAN6sZj1lRPjh90K2K/dH6QbFtzvg8iYWkhgxVRbH
    +wwBiDpkzl2vVQLHoWGd7xsLbHUfw3ZV3nW0wFvtZVXUAAv/Z/tcwcjvQyj/3G6iZXNG
    GHSQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207465;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=/sCHFmv0UPJlsCmbFKmk9k8g8iBRMR6sdrLsFxtQp9U=;
    b=g83YfmVzojxKIZAtXvrRBtd5n6dPl3gUATW4R8LW0UdqINRj6IzgJzItsE34cStt5v
    actM0sZdPjkEoTWRlP6dDxvjBLKvaVycTqradvQKQo9bq1JzrVuRmntTnF4A6IXy9aRK
    7dK++AoKXKUuVP/IZGGhHymd9+U9iCuZx0dpStPqdqPXfbB0WWju0pxCpqQuoPBvsp3M
    6qx2Dmw/6dI1oD+a0gcusKri+WI6mP1NrGx9sxlY2zH1231HAl6ebgxTI9D/FMZ1sRSu
    uWmjn4XB7LW+eZTg40Xyo7pgZpMqb4iMrsNoH4b4oKsiR6GK9NcG0dTvuIgPYqv8gRgS
    TNHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763207465;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=/sCHFmv0UPJlsCmbFKmk9k8g8iBRMR6sdrLsFxtQp9U=;
    b=9H8v1bKyCv8TUw+1kkuJ4LwA22+jFPdSmt05NF1Qm+Z0f1LwGgm3BSWbBDNOhcxTFP
    WHFWFR/sy0dwFCns33Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFBp5dZl
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 12:51:05 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl 06/10] can: dev: can_dev_dropped_skb: drop CC/FD frames in CANXL-only mode
Date: Sat, 15 Nov 2025 12:50:49 +0100
Message-ID: <20251115115053.72673-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115115053.72673-1-socketcan@hartkopp.net>
References: <20251115115053.72673-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The error-signalling is a mandatory functionality for CAN CC and CAN FD to
report CAN frame format violations by sending an error-frame signal.
CAN XL has an improved error detection [1] which does not need to destroy
the sent frame with error-signalling. Therefore the CANXL-only mode
disables the error-signalling in the CAN XL controller. The CANXL-only mode
additionally offers a CAN XL transceiver mode switching (TMS).

The 'mixed-mode' allows CAN segments with CAN XL and CAN FD controllers
where the latter are CAN XL frame format tolerant. This mixed-mode
utilizes the error-signalling for sending CC/FD/XL frames.

Configured with CAN_CTRLMODE_FD and CAN_CTRLMODE_XL this leads to:

FD=1 XL=1 -> CC/FD/XL mixed-mode (error-signalling on)
FD=0 XL=1 -> CANXL-only mode (error-signalling off, optional TMS)

This helper function can_dev_in_xl_only_mode() determines the required
value to disable error signalling in the CAN XL controller.

[1] https://can-cia.org/fileadmin/cia/documents/proceedings/2020_mutter.pdf

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/dev.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index f15879bd818d..52c8be5c160e 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -133,10 +133,23 @@ int can_restart_now(struct net_device *dev);
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
@@ -151,10 +164,16 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
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


