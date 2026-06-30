Return-Path: <linux-can+bounces-7931-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LiO9F8fzQ2o6mAoAu9opvQ
	(envelope-from <linux-can+bounces-7931-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 18:50:15 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACACF6E69F0
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 18:50:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=ra4IZzyc;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7931-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7931-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59CF23159426
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 16:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340533DA7C2;
	Tue, 30 Jun 2026 16:44:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548063D6692;
	Tue, 30 Jun 2026 16:44:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837851; cv=none; b=tTBNPHuLG53dJJjjPFwSS/EZOAq3Ay8thAvbO4Iji1M0bze7dmIXpGXJJnWqVkB722ijSy+8lKHwPaE908HkMV4nfaN0/i2p/K3pTbAKgqV1XeWu7AnbBfEtxpMsdGp+hsYkLaiV4Cd+6mE7vxnaZAvbCDII6AMBAZR+H2Jg19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837851; c=relaxed/simple;
	bh=xPTKnjYhG/klSu1C/iRiS52JiMJTkVUQXtrZFmc9eZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4xPC9HWXfXzuy1828rVQghg2ntZvpugTqog3aKLYhHm1zFlSEESMsb5XCyeJZvdCytWxrRXRb9Tit/LtmKlnk8pqUmMBdPkzUNZh5/vS45Sa8c0RZ0K4jZWYYRJZPExNiBVyJixSxZMvlcdxiRtdAdN5ye5pjlqmH55yfpyD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ra4IZzyc; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=iQBy/o37l9sudMeWSCTCpjVQ/V1ougLIUohroSPHPK0=; b=ra4IZzycLMlAALjhjKyzC+Wy0q
	41zyiJleGla0koqeyiUVgLfeYR86pfv5TZyE/8orGe3kdgLl1NiYkWj2KAMUvHstoBhcA7mquLB33
	D/x935HbO+vobPy6KV4bNyNokvmpSWgiErM78FO2IwPrYRTucLaZxD+8NhAqPjyKI8QWdF33h73eL
	PwD0PEwVCFxVoTu2IfvZgeiTEPz51mynoc4frt8rNET0MOlWkqD2ZA4O9KgokITRk37MBqp48ASJ3
	Co7Fk23AyHDtntqMsy4M0aon264qT8X+1U6KXJIRFwSGaEtjEp83G6NhtSCTQEYEh61swonUVC6/e
	+4z5AsbQ==;
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
Subject: [PATCH 3/6] can: rockchip-canfd: enable erratum 6 on RK3588
Date: Tue, 30 Jun 2026 18:43:33 +0200
Message-ID: <20260630164336.3444550-4-heiko@sntech.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7931-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:kernel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:shawn.lin@rock-chips.com,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:quentin.schulz@cherry.de,m:zhangqing@rock-chips.com,m:heiko.stuebner@cherry.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sntech.de:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sntech.de:dkim,sntech.de:mid,sntech.de:from_mime,cherry.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACACF6E69F0

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Sending extended CAN frames from the RK3588's CAN controller, sometimes
sends standard frames, as explained in the erratum's description:

  can0  00001234   [4]  DE AD BE EF
  can0  00000001   [4]  DE AD BE EF
  can0  000007FF   [4]  DE AD BE EF
  can0  00000800   [4]  DE AD BE EF
  can0  1FFFFFFF   [4]  DE AD BE EF
  can0  12345678   [4]  DE AD BE EF
  can0       234   [4]  DE AD BE EF
  can0  00000001   [4]  DE AD BE EF

Enabling the erratum, introduces the correct behaviour in re-sending the
frame:

  can0  1FFFFFFF   [4]  DE AD BE EF
  can0  12345678   [4]  DE AD BE EF
  can0       234   [4]  DE AD BE EF
  can0  00001234   [4]  DE AD BE EF
  can0  00000001   [4]  DE AD BE EF

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 707f387e7cf4..105ca4d5cbef 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -53,6 +53,7 @@ static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
 static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3588 = {
 	.model = RKCANFD_MODEL_RK3588,
 	.quirks =  /* Possible more Errata */
+		RKCANFD_QUIRK_RK3568_ERRATUM_6,
 		RKCANFD_QUIRK_CANFD_BROKEN,
 };
 
-- 
2.47.3


