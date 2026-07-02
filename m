Return-Path: <linux-can+bounces-7961-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jPXUAutxRmrAVAsAu9opvQ
	(envelope-from <linux-can+bounces-7961-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 16:12:59 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A566F8BF0
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 16:12:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=WnlaCRsT;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7961-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7961-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 371B0312899E
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 14:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06B14C6EE7;
	Thu,  2 Jul 2026 14:07:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81B4C0427
	for <linux-can@vger.kernel.org>; Thu,  2 Jul 2026 14:07:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001267; cv=none; b=e7+JO4gi8UFvh+qTyicYkHDrOrv71qJsNlrxv3xmclY494Z/arCavJ9QCSarugXMhgX5zYSGatJmhvGLCCc49685nKNOpFrULJ8wJYduUZty1JxDqAMUOpn1ld/g2X0QSZj62bvbxTFikyjiPj4b3pfmnWt1X54Sx3rVamJ90qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001267; c=relaxed/simple;
	bh=MB0UDXwheg/VtXIVTGSxcMrH62Y4FeM7cEwJksuXps4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=R66aNJRuQA/ePZggZBVT56U2D9mbYWHDwmoV11cIQmP4CclnFdpRUG+3VaH4ajij0U5fzm5uLlZYcJzstp4YVMMzVZFIdVpS/11YGIHCWxQ4UwyBJDAoCTk2T46K3W4ZbTp5eaaN3YuwRWGj2PZVBifOPjF/EQgBQojEXL61Bjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WnlaCRsT; arc=none smtp.client-ip=162.62.57.87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783001259; bh=6t1hC3eW9batZoaqk8umbCCtXrmckaWWWgiTm6RruGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WnlaCRsTnZwTM4ard9rXOhxM+iXJP+09yuvEuy99HAoNffoz5ZdrBqPxBSsLDRugj
	 44fWbfbo6mS/tEyX7nAl5e4O4yFR+MjHRxXOMv2sGBIcS9WzrdGfnnhebDSx4OW/k/
	 21AQ33La5SutovjLmfeIpKddIVslnbdiXrnVfYVE=
Received: from localhost.localdomain ([218.4.149.66])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 1D09A800; Thu, 02 Jul 2026 22:07:16 +0800
X-QQ-mid: xmsmtpt1783001255ts0wqymql
Message-ID: <tencent_608FA189898644C636C1638421000111CA05@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJA6P4cVAkZA6mhVs8Q0iqgWX+nQnPJ/ZjZfbxCFsXZl2h3pWTpk
	 n+ScJAP7agI1XKZ/S1bdU17Iod0lGQcqZO96mRtc1z4MlCvD9k26AdZW8QDzikYjFyOPS3Vpt/GN
	 DMeYE0VHRZiWnHzUuKYPzijlNVJmFCbezoQukB/7Rc1fJABVxbOFKNBXEFY+6ZmcjWuwevFFuElt
	 8AjjHSt/P0mQmQ7qAKdmS/NMF3zMkikCqz11CugLfV0esXifU/4QPglgwJ0zgs01F3ovUnO05IO8
	 QSokE5qXDlTVPkfREJfVDlUVE5E+Jv51kpbrnOpwQHFWK3ugCTzMm0KJXjDUwAeNOHebXCie9JbG
	 Tdc2k+rETXBXq5y5Q8xA7gGgwWG9laMoZLvq5ZYZTWdptQtLRiCEy3lLmXVu3d+fVmE9XiBF9V6D
	 KlXfCkZDL+AMGAgJD7G5/FurQhOo76pof4Dskli7REc3s7lkaecbH767EEk+JZ2ebP5NpSuciaio
	 mQU4w5izdyyXK5ghMRrKJW4Ifd5U4X/ar+xyrtCrTkNHyoDqTKGemZUog1aUW1s/Ep8imsmOlq6N
	 psSFL6w9oSC84ltzn+XrmTpIBRpyYmx9wVXV4RKcq+MxYOYpsPdZxk6E+hq7TVXrxe7A0ATBdCda
	 WoxYZAbfldL6L9tnY6FBv4PdCrZD4LbzceuSavSHzP/FW3BmXpDhAIBPguNHzj14Bxz8e9jRbkzu
	 9JGhk2BAN7WXOaV2kdaU40vg+kIv5cUkQdUex2ZJ+lopAX7LSRWDCmlAeJsI1JeiQtM9AVtLhlx3
	 1tcSqagMPM8mCb9Yzp3tuX5OJrKjAez/IYrV/wQd8f207XNHR3JhioVApNYjY5GI24n+mmA4z8ol
	 Z4uYAJiCt/+wysqidt6hECFV90UNXW7yXLaLr1i/EO5PK5M54gPPPjnv+5PDy2UObA1KB/870/RU
	 V76C2Il+uSOEH7yFNJtoMSDoUbI5z4AxClfV7kfn5v7Ry21QifAEN3lJfr7AG4OqwAFyxOj543ps
	 mm8a8H06c7l5yq+PDx
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: 1579567540@qq.com
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can <linux-can@vger.kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	kernel <kernel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Eric Biggers <ebiggers@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Yixun Lan <dlan@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-rockchip <linux-rockchip@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Cunhao Lu <1579567540@qq.com>
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Enable CAN controller on RK3588-Tiger-Haikou
Date: Thu,  2 Jul 2026 22:06:54 +0800
X-OQ-MSGID: <20260702140654.2961561-5-1579567540@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702140654.2961561-1-1579567540@qq.com>
References: <20260702140654.2961561-1-1579567540@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-7961-lists,linux-can=lfdr.de];
	FORGED_SENDER(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:kernel@pengutronix.de,m:conor+dt@kernel.org,m:heiko@sntech.de,m:dmitry.torokhov@gmail.com,m:shengjiu.wang@nxp.com,m:pengpeng@iscas.ac.cn,m:rmk+kernel@armlinux.org.uk,m:ebiggers@kernel.org,m:mario.limonciello@amd.com,m:kmehltretter@gmail.com,m:dlan@kernel.org,m:sboyd@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:heiko.stuebner@cherry.de,m:1579567540@qq.com,m:krzk@kernel.org,m:conor@kernel.org,m:dmitrytorokhov@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qq.com:+];
	FREEMAIL_FROM(0.00)[qq.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,sntech.de,gmail.com,nxp.com,iscas.ac.cn,armlinux.org.uk,amd.com,vger.kernel.org,lists.infradead.org,cherry.de,qq.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cherry.de:email,qq.com:dkim,qq.com:email,qq.com:mid,qq.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61A566F8BF0

From: Heiko Stuebner <heiko.stuebner@cherry.de>

CAN0 is piped through the Q7-connector to the CAN-Header on the Haikou
base-board, so enable support for it there.

At least on RK3588-Tiger, the CAN clocks default to 99MHz, limiting
usable CAN bitrates without skew. Errata documentation mentions
300MHz as the default frequency on RK3568, so replicate this here
to allow more bitrates.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
index 873fbeb8daa1..6273e695b039 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
@@ -155,6 +155,12 @@ vddd_audio_1v6: regulator-vddd-audio-1v6 {
 	};
 };
 
+&can0 {
+	assigned-clocks = <&cru CLK_CAN0>;
+	assigned-clock-rates = <300000000>;
+	status = "okay";
+};
+
 &combphy2_psu {
 	status = "okay";
 };
-- 
2.34.1


