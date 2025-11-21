Return-Path: <linux-can+bounces-5577-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7784EC7B895
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 703AC4E7220
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A61302CD8;
	Fri, 21 Nov 2025 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="GAGUmeb9";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="r0XYlIHx"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F521578D
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753744; cv=pass; b=BndOw3cWHsOEm00LZcU0uueZjpwJa/bfnKI1/ZJyOgqZPzQZPJlxbjPOvveeQ90qZqR1nXifUrjE4yr/0fwQVdwB8h246YOKhnd+AsIHudCkeWqWtVFXK3KZEjQA3asfRjF6V70+11So85utF6asD+cQltxhBmG7OfRZRl2CcSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753744; c=relaxed/simple;
	bh=s+lADGieyXp5NWDUjGmEQumpNZetzYKO0b2m4eFKE7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGokFDr/td6HiHVIxQE57tQnLVM8uJafOEpXpNgLKBmn2H9FcWzekyi8Jq1Zlr8fzrywclJtouCzDIk0bsAxaDF4zhTu5f/ofdLkPKE9yjHLUXJZMBfQS5vJzWgKvc6PA4uc5g9KenMhd9s9s24eqNF4lzKAIqzKtYUrDpLiwb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GAGUmeb9; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=r0XYlIHx; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753727; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=otXETECajbZA40BNOTGtrj6J41qggAYjAZZ+TCIqtwm8F1OBZGSdt/3OmvisuFP3cx
    46tLbYDjSE4qFKPmo/XVRJWlkyiJBCu3iOZ23nAeJYy3WA4VPXb3X/I/PboTAUC2WoW1
    OfS1Uo3rQE1xouNYHt9QorV5O4yax7HLz5s/tQ2bn5mfmwvR3VMBY1dKFQjhy+9K/N4X
    kN/BH1XLGoOulIOUVVlvW/p+pNKrDJ3pt9/o/9D/aS/Wyhd3Bf9+h0gnA7Za4vuiaoA2
    PK9gyQh9DU+QHq0oW/ZM0mhBOXT2dT6OLqa/M07jNQJafUFAw1jC9Ihl/xEYeuBdIsPW
    0ydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753727;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vn4gsB8kwb7mn6S98lacK3xTSI77EQiiURCmYom8g/E=;
    b=SRd9ky7XFaJ0FJ+Fu1tDs9FI4WFCfSl/YLfAZoewbmfk5e6HK1ZHDfdIzVhxa/yWoY
    B5wK3PhM692MBGvoh5KPHq+NQsJ0ABXR4WGOF+S/ns7/1hWoN7b/CiyBmOlGoIEWsMM4
    SzjfZS8QaW6iT9fgVCG+zigTrltvHX5uNpRVIF7YCeAx0VNKGYTcEvHI3lJB1Y/ywpeY
    nLzgte+7kguIUUTqwBb6jTiO4NfcYxjskrPhWuIDaL3yEOWcm/ah+1F3A2hyOj1M4CLc
    goy1tsEuYLQCmILIxduoJhSW4FRRhu5VHUARFFvwehvMNeYNx2bb7b3bK0/V3FPekhPX
    XRPw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753727;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vn4gsB8kwb7mn6S98lacK3xTSI77EQiiURCmYom8g/E=;
    b=GAGUmeb9RLov8k3fPCa6K0PYDEUjOhVEJHLV8QkjzVP0mqZRUqe5Ddq/TI61WI20fJ
    dYUYOMApyPwfdRJRK/DYVNHDb8va2TTys5f0YdAOE7qtWsjMheCh3y2JkD+Uv99J1UKU
    YdLXx/9ZYmhx5hmDTA5q2EwCdiilXZYKiZAsfSvNq3wc1RF61AmDeYKmiTkjz3fu4Hl/
    munpPeE7dX0aFZAidrvJjoJB1Aziv9uGGJp8zzm+F7FyBO+iifyHuYtwIygfactwNX+P
    R5tdLXtLRSaeAuPWaTohFdVVCW529CAUPZaQOxBE/qsTQf3+Yoz8oo4Ckene09ILmvv8
    wz7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753727;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vn4gsB8kwb7mn6S98lacK3xTSI77EQiiURCmYom8g/E=;
    b=r0XYlIHxgJbA6+HVDb5sV22XhqSxGXTv+KLL2iecikOIj3OVcHUiqlMx9cyg2AiH26
    /wJiYykUVf9wbi7MmZDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZQEn3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:26 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v5 02/17] can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
Date: Fri, 21 Nov 2025 20:34:58 +0100
Message-ID: <20251121193513.2097-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121193513.2097-1-socketcan@hartkopp.net>
References: <20251121193513.2097-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Vincent Mailhol <mailhol@kernel.org>

When CONFIG_CAN_CALC_BITTIMING is disabled, the can_calc_bittiming()
functions can not be used and the user needs to provide all the
bittiming parameters.

Currently, can_calc_bittiming() prints an error message to the kernel
log. Instead use NL_SET_ERR_MSG() to make it return the error message
through the netlink interface so that the user can directly see it.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/bittiming.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index d30816dd93c7..3926c78b2222 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -139,11 +139,11 @@ void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 #else /* !CONFIG_CAN_CALC_BITTIMING */
 static inline int
 can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		   const struct can_bittiming_const *btc, struct netlink_ext_ack *extack)
 {
-	netdev_err(dev, "bit-timing calculation not available\n");
+	NL_SET_ERR_MSG(extack, "bit-timing calculation not available\n");
 	return -EINVAL;
 }
 
 static inline void
 can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
-- 
2.47.3


