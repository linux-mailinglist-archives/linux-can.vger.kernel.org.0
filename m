Return-Path: <linux-can+bounces-7927-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id soSWD1/zQ2obmAoAu9opvQ
	(envelope-from <linux-can+bounces-7927-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 18:48:31 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2906E69A4
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 18:48:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=Py9ZKJST;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7927-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7927-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 156FE311E0EC
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 16:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8947C3D6CD7;
	Tue, 30 Jun 2026 16:44:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3283D669A;
	Tue, 30 Jun 2026 16:44:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837849; cv=none; b=jD+IrTnkCzP/pFrPb4+vq9kejqZWyHzzJeX7JMCjxHkljDM0eNxNRk0gcKKVxihzZLDa+0djvGuVdtexpv7WLRoBhR/tTZn/YbDXR/j1V5MM+4afTL6QWlwMEr6H6xr8bbVdC/SQorZzBiozHBP7Gtk6P2xsdXxkGpoFXgU5p68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837849; c=relaxed/simple;
	bh=TUL1+g4A7kmyO+fIiG3kRf5secXWBOg+HDORnAnp41U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwyhrvt5Vv+FGqfM8bWZkz05LDabpYHJsDOYQzSwnQ+rw5qi7vWwlghK/WxtIo6b/v1stcDaZNveagg+/F6PGduAiNjURQeCZOvHAczcGAg1Wzous8JwBP8DY5E18rGvj5J1UKvjrFTJGxPgyzvuz0PdhZDChY2CLKNv3hgvBE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Py9ZKJST; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=0edmQyMBBF2hDdlkMaDXaRUizb6MbyZ6wLi7kRGWNho=; b=Py9ZKJSTYGWf14Y3hLq1HyDniJ
	eECGhrovt+szZmIU73s0cN7R7wEmF7A8Mw6oHb4/1kAfyNEZwfmh2VRkDSEf+yNcSAN0SSOf0EB/M
	FubDPVLZRBoRSpmkx+LdiP9BLF+yKSiIus3vRAZi+QDfo9Pltq21ZzklaYpJLuedFyi2PK98bvZrx
	pJ2irClMv7l3WxIQe8UAmHSjMNU7oI2ORD2nWsRVKHNTlLXei75fAFvbYC9QfYWgM2KjN3gTstVTg
	7a6dAXt04JhSeqeAtD/1Gm3AO8JuBIP9D0mYpPH9/ERET0CqwUnMFEsJHwYOP19uJcefSJdYpZe7V
	mq1LMRng==;
From: Heiko Stuebner <heiko@sntech.de>
To: mkl@pengutronix.de,
	mailhol@kernel.org
Cc: kernel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	shawn.lin@rock-chips.com,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	zhangqing@rock-chips.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 4/6] can: rockchip-canfd: enable erratum 5 on RK3588
Date: Tue, 30 Jun 2026 18:43:34 +0200
Message-ID: <20260630164336.3444550-5-heiko@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630164336.3444550-1-heiko@sntech.de>
References: <20260630164336.3444550-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:kernel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:shawn.lin@rock-chips.com,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:quentin.schulz@cherry.de,m:zhangqing@rock-chips.com,m:heiko.stuebner@cherry.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7927-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[sntech.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D2906E69A4

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Lowering the clock-frequency as described in the erratum, also
leads to empty RX-fifos immediately, indicating that the
erratum is also present on the RK3588 variant.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 105ca4d5cbef..f3c8b54a9f02 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -53,7 +53,7 @@ static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
 static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3588 = {
 	.model = RKCANFD_MODEL_RK3588,
 	.quirks =  /* Possible more Errata */
-		RKCANFD_QUIRK_RK3568_ERRATUM_6,
+		RKCANFD_QUIRK_RK3568_ERRATUM_5 | RKCANFD_QUIRK_RK3568_ERRATUM_6,
 		RKCANFD_QUIRK_CANFD_BROKEN,
 };
 
-- 
2.47.3


