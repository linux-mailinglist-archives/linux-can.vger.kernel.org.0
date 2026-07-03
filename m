Return-Path: <linux-can+bounces-7986-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R/IBGo9vR2r/YAAAu9opvQ
	(envelope-from <linux-can+bounces-7986-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 10:15:11 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 004DB6FFF5C
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 10:15:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=CJkK6acF;
	dmarc=pass (policy=quarantine) header.from=qq.com;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7986-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7986-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDD4C304DCEC
	for <lists+linux-can@lfdr.de>; Fri,  3 Jul 2026 08:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98732374A0F;
	Fri,  3 Jul 2026 08:01:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6D372B4F;
	Fri,  3 Jul 2026 08:01:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065712; cv=none; b=qK+KkpYebu9oAT4cN01eGktvoFrQAKOr0vQbrcRFQ3ZGPaSyBOcrSLHoA+jC2WXfoJ65dek7HFL0oabFBGSW+WR9MOV5JjuppYKP5va4gjPY4y7uLTMx/YICN6mGotmMuCEJUc6g4P0Flw8DL8EKKOzfH6YMihJcfWbt8PIeKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065712; c=relaxed/simple;
	bh=DX+szNrz7DTLcMXoXNU6DNJcfUI4KfQcHuk1pG+QKxw=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=TQ8FAS8GJiACCwVS+IoeSJctM9m+izR1nGRJ/lZDqG1f3PAZo8LWOSCgT3Vy00uTRx9+YccEcKTF2YAW8Cob060bxdX0ojIZiW7i6TmSLU0oNihncqoG0+LZlYWp9lAR1k6/l4L37FADid1skoOUy5TiDgM6NFsYWclF9uWSBBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CJkK6acF; arc=none smtp.client-ip=43.163.128.50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783065708; bh=L3LDk1ob8lSeDF4p3l0ihZVgutygUEgJnbVoCOXhudc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CJkK6acFoXnX1g4vVLV7fnFp+2GXjTG7P2Qg+s//tKFrB9bFtpPCQvJgflRsZWYg4
	 SlzQ48vo6w0DSEhkonQ/8L89kdZjXg/0cQ35/rC+xn9c0QPJbKF2QzsVQGw7R6qCOG
	 TRoHFSFCUU8/OXsVAEECkPu6jlPITRwJlMeJFeng=
Received: from ubuntu2204.localdomain ([218.4.149.66])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 6622C6D; Fri, 03 Jul 2026 16:01:38 +0800
X-QQ-mid: xmsmtpt1783065705t0731270v
Message-ID: <tencent_F79E849B11AF805A4401BF9F263B1A469907@qq.com>
X-QQ-XMAILINFO: OVgMLYsdica2Wz0L0+6ObtYbjk6wIdyR5Wos+YJH6r63OA5+Uza/FQzt2opDAe
	 ntbf42XNICyNsU+n+lax6FnTNI1u3IjGgcywXwXNzrQOO8FffjvjYuzzTV87BjI7L578uRguwFlk
	 JTai/U0UFg6v/PuJpy0XNhHJziBKNISsy0Y/QOvceKUQuwJKaMM/9b5m3bwdAG9Jt6khp0tmNmnN
	 nlBdCW2Jl58dajDsGG/0UzYD5/3cbTCRZ+QoO4aZc6ypSryk7X1taaJISqN8lZ3ICsuDi9k3A5Mw
	 KG5GxbvS/UjsmJ4FxHMPTcG/6419XHUdHyzq3EjaSANXRnxt58GwBe10PgMJ8KFEdtN4otNirq7S
	 Ko6ftKajQQUxcTCkVFyOLI9pUCN76AriLXlFvMyTi1OACj6FhS7f/Pth18xhcdRvDWtQ01tGED8Y
	 YIYm8NhOywA9ALphT3cAabS+R19ETEXcyPE2CXM+2eiZ+SXUwiR+aaV4EobW1K+qUXjxObmKE/Ux
	 GCyy/Dm5rMz05jrae6jCUui2bwFFlhvBa3z6a2U3yL1yq+KF8gC/A4gx4dKCtY3v5wWWfdSGzwPG
	 4mDFoQcZtTak5LQIZtxFkRg1yZ+Dvbrs7ZO9y4Z+HVhIWZFvTHTYai0SG/09j5Ob6RWnQr5fiJBX
	 K+RYyEidMSbcr/n78Bjc6AAg7sqgklwjQpnAXU6BxiNadlgmBlMdcwraHnS3Mpz0WZz/nVpZwXXq
	 yIQRx0Isk+gHsVEzvvgWpDwnUx57peNhxSBETomveJfoZddCXUbOGgAKo/DtZh4vBukIRFsxt4bF
	 f4nbOeUbHy2Vliwg0YMB0wzBa/v1q+uJXQ6GK4oUoRTrBS5OI1/6AfkXp75EzCPDpzsXtUCR+WK4
	 it2EDTqDPdMjydh6WPfJkhzFUy+wUb8q+TBYaGrLGqsFIqPj2AtdpMrotDC6B589XORsaFzExunw
	 2kFG/sULQNm4dAy3ROQsgEfZ/PjDnXFnBccultOl5GiR4ABDIbUzyWHmEpGyuVW+XRBUI+5QUJCU
	 XjoBZ4w29KR432sMUcUMRMYwxmLKqB/eVfyMQavvJ4siOL+glVObEypRj0RY22aoeIE4wEoA0pTw
	 vvuHdoygroDWN6xribPtRHD7BOQJR+vPd/tyc9tbCOwF2CNC/Vlzmrrx2miygPmFtlsKvk4Y5KXt
	 XjzTrQmoSklY9ixjbeDsLDlADu
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Cunhao Lu <1579567540@qq.com>
Date: Fri, 03 Jul 2026 16:01:29 +0800
Subject: [PATCH v4 4/4] arm64: dts: rockchip: Enable CAN controller on
 RK3588-Tiger-Haikou
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260703-master-v4-4-47d40bbf5fda@qq.com>
References: <20260703-master-v4-0-47d40bbf5fda@qq.com>
In-Reply-To: <20260703-master-v4-0-47d40bbf5fda@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Cunhao Lu <1579567540@qq.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:kernel@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:1579567540@qq.com,m:heiko.stuebner@cherry.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_FROM(0.00)[bounces-7986-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,qq.com,cherry.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qq.com:from_mime,qq.com:email,qq.com:mid,qq.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cherry.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 004DB6FFF5C

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


