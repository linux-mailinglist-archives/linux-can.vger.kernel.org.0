Return-Path: <linux-can+bounces-5426-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C35C60898
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 17:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AFB3A5B0B
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD6A2FFDD5;
	Sat, 15 Nov 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CJVvqZ/d";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OHKKriy3"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B214D2FF140
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224679; cv=pass; b=L7DbgR/7aCVjOtXn7n8QsKdaZDM5P6hYvXVIYaGCHyObBEJdXxMVljr7tsG3vmukyOykafIMVjbMPW7fEmbLb1GrM7GjO8pSNZb0wMUHA09HxMivdUjBGdyGwQOhrj20Qwm8Jq3cEUDuV6XVjobwnIBGlziP2hPXeyqzHpb8lQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224679; c=relaxed/simple;
	bh=7dei3xyhgze5CNDEQDCrXxmv07hkVkBWFxgAGS7dqAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+Ml4H/GzbKNE4LUmaczyzmlzFfL+0WmtNq2R7BiZ3/NDIARbx0StK2RVN4JCPSjQvU8v6vxchu50ZLhPFZlmPqUfkpwSZfk0a+uGPMCj/v+ZsrZ4Ufz8CHvMiazG3dGAnrtevkmXWWhjSQHpVO765eYOaiPrrsFsicceVUxepY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CJVvqZ/d; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OHKKriy3; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763224674; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=o/zOGLsZHVsZw8Q5rO6y2Qai66D63LoArNsvZ5pv4EK9hn/pvIXD1zCOtoZQQs5mzg
    5dcEGpBk+IMPeAwlKzl2B0d612mebj80eU/fzNZf08jBUEXvLa+fG4f4OqQMm+OcVGe4
    LqoOuZpW4ljKyrhDmpVu8Rhfp+7AmZACLbtMYfJiPYoWiIB2EHn8nGytF/Hu14kj75iJ
    8749nvAc0+qy4DwZB9aCkXASMvYVgRAOoA51K2n9f1eFbPMjun/QlsyEwETEbYFM2zW7
    /lzCjGPtUBebWM3NKmjt4gCsEVpzy2k7ReSnPBHHNjNAQmCyKRUL7SGFsJaFY+Tzj2cK
    G/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224674;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=/sCHFmv0UPJlsCmbFKmk9k8g8iBRMR6sdrLsFxtQp9U=;
    b=tl6AjuWwVkBY1EBeS54au9l/JDhmDmNNaEjbtCk+BL/Amck2JumF4iAE2RCXnwADx1
    lBXnVl/gJDPiRaeWkOChJEWl7eYafuB9BiYkF6qNdZXY7cgrK3xEO3Qw5XTQS6lPaTuP
    h8bfmALRwuzmeVv5uKDFnxyesoR+TDJxzlxRVaNcpWbp2YRZ40Xg2l+Juygb57fe4yD/
    jQia3Y1nRf9UfkVN/s1YqONzv9Ao9T7iqWe9OB31MPUUIhguTvgYzRwsuobT4y3goq6X
    h626OilQ81pYPL7Q3aIPGC+Kb9knnWOHcpr5ZpRYAVhnrl/K5tiDFikZOdIPKYui/KWY
    wJWw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224674;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=/sCHFmv0UPJlsCmbFKmk9k8g8iBRMR6sdrLsFxtQp9U=;
    b=CJVvqZ/diC4q4KCAGeAO455t3TWSz4uNhSktUKFJVTKG16yVDumqFobO9HHV0ylr+C
    1mBEMEFga6/sFUnYmEGlALj57jvWfkXz55NSmmL55k7JXaJEZqtPcQMs+NOBOALfk7nr
    Q+jhT8Qy4cCY7AlteXViuKtydFYlA9lrYeaV8O8hvKCPW8BAv8FVdw+WdIihHlNXZ2+7
    FHCJSV7wDpz4X93pmMeQQpaS3MGfvM5MMYGAQnvNRajuwxMFtSIKwt30S5eusTHunqFh
    ATBBfwVHOwef4sqmdHAIKb9jI18mfu+Zd3WP3VqODubOodbFlmEUd05qurcTr62MDCC2
    QMyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763224674;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=/sCHFmv0UPJlsCmbFKmk9k8g8iBRMR6sdrLsFxtQp9U=;
    b=OHKKriy3O71pOSVevZJrJhzkIpgBJicOFzeb2MuzrlTiXIiMEk43Ge/scZKh6GFB3i
    2CJwveQhEY89J3SKdbDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFGbseQp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 17:37:54 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v2 06/15] can: dev: can_dev_dropped_skb: drop CC/FD frames in CANXL-only mode
Date: Sat, 15 Nov 2025 17:37:31 +0100
Message-ID: <20251115163740.7875-7-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115163740.7875-1-socketcan@hartkopp.net>
References: <20251115163740.7875-1-socketcan@hartkopp.net>
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


