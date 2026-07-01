Return-Path: <linux-can+bounces-7937-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6hKhExK8RGpGzwoAu9opvQ
	(envelope-from <linux-can+bounces-7937-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 09:04:50 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F01306EA75C
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 09:04:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=TwSAMjvn;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7937-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7937-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D66F3305CACF
	for <lists+linux-can@lfdr.de>; Wed,  1 Jul 2026 07:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784783B3C18;
	Wed,  1 Jul 2026 07:03:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008E35AC07;
	Wed,  1 Jul 2026 07:03:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889409; cv=none; b=rjmAMA34bRFkeTeuD8/wUdGiOaJ1tDuIjnnIdLAl4cEwuUe6h7iS1gTfMFP5/lxOdw41BMHrF5lV5K7VI7fyM/B3ap8J9+W5rKBQl1omWw9tsnbuaRrWEGvgNnJjFoRZ1+AQ+gO9Yz/MPSNv8z6aM80EXBjwOSFIlGQeSwWNBEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889409; c=relaxed/simple;
	bh=I5Mpkpq0oBzgIvL8nHnYhPvyxTuXl3mmF+CqdHZuCVI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iQxLQFBcgPBWaM9kzIhvqo+2MHmiUYEMu6xkP+4I0lXcmzI4O/zhbMKSYd3JvFvG/qexyEsvVf0JGAaD2Mx/CXJnRUzGE580FjhgpmyJtR7huXGwtcBp9uvJDURVivPommzMTLyoUew/PbvnotvRldCidUpQS+sPKNQuZi0Bd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TwSAMjvn; arc=none smtp.client-ip=162.62.57.210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782889403; bh=FShFSBar2e4LM7uO/40Qd7kb3xOrWO4j2ojR50S1ZIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TwSAMjvnt1TKjQNG7LUI6Q2iioD8JRO/x5/LvQgWUKWuk/70aQILookHAMO+iTKd6
	 PsXXfei9UsG+Fzua1cUuHdwtuPMLzFZjV1mFzbJMcNJ+zWRwp8TEw5Tk2UWevZ6ieH
	 yiJqSt+2iPsVAlsauliKHMHIRZm80ae/UIoQ1SZg=
Received: from localhost.localdomain ([2409:8d20:2a:1b57:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 71832C3; Wed, 01 Jul 2026 15:01:49 +0800
X-QQ-mid: xmsmtpt1782889312ts72e70l2
Message-ID: <tencent_83A61C9A79199D04CC118A8026C435BFB907@qq.com>
X-QQ-XMAILINFO: NwdNTztrVPAhWG/Ary8iIcgmz746y/a+3zoJp7nCqTD9tf1OdnigiabLGRksUa
	 CoALf6Q8iPt2i3x4D0ul9kBYkgnnfA4MvQbBfj3hfBaxx6JzIJpgNc5fniq30N0q4YD1hNSrITNZ
	 FLqpkTGWL7WpfiqDWlUryCU4t8zhIl2Pz925IVRjJxb6QEWe286xYkmSfAzN/ecJTbLqPXj471jM
	 cXoHfegvO2xhMw+Ir8cFUO/ASvkzKyTpPAKHn0nzxQNY1UcgsMcXGM+spgICj83emfpGzpKTDxNQ
	 rSEuOL/LNQLhz/XFboJbhF22F9dbxFZYE0tbhDT4kCIfOfmyWpcyMW35eY+kFxQEE6hbADIFCT7M
	 sK3MX6uYHMlctw2lPJoxCCDPBzNMEcVeR08BkmqqtpaZnHDpYvKjGLwz4IlR7abAsSdUq0Z0B3j9
	 tq5GSUmlzR10wShQkTYQ6MfupHVn6jDzGDcbcurkanr01wqGJ2CQZ+EAdt16JJiOZHH+n6qPgrD4
	 SPR5/wWqPhwFE4tI6nW9EoNVnZkS2gNFgD6lSb8jYwnxvKuLP5b1Y9gvAIhNDUBuVvVXSkp5/fq7
	 KBPrqrwfvCond3ugQDzmaHiyHfBHWGhULIyou6hBIW+S7UgLlYHXn9pvc3zNw3q4BoMq6S3OLrrB
	 apOwlZdDrtax8wiovZkbO3V6lF/6Q6lb9tPnFU4NiBRjuCctKgjRKU7rmwyQg4KrSKTAu1hIv/MV
	 urfICn9+0c4xmX/3l/bHht8ShzUZwALgNbcBBUpZRvfTnvHXUgDpu/63Cd5EJqfmatcjSudrKE/s
	 rbilbHK1r89PpCBro3c843TDmg/lrPtaoujs5fsddNf6C4YOXO/6EaDP3rWvB/bEUO2hKLDyuxWV
	 0EOJgm04RNs7DJksG0mpHYRkxxhQ4Dltp5lnevkPCqUgfySLxrWoSBGkTIGVGw+3DoF/Duh0KVqI
	 2BDc1ZVHxL6dm48aV6hYMdtb6B/Y8HQUVVLm7UzY4XzaEggZmGSXd09N0JTn3T5fHZ/Xj4nGK331
	 p3TgsIvw7WZFpKl11VJrYAXwsd5gG60B2pRTr1uy8gkvG8IDTmf+gNhtlcistjxJqJ30+u2aMAFs
	 loBDSSniwbc1ryTFsIgpF2sOaCYtOKweSwYm7T56sREcVbiZhEgOtYNnBnyEz3eL+gori5
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: 1579567540@qq.com
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	kernel@pengutronix.de,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	luch00 <1579567540@qq.com>
Subject: [PATCH 1/3] dt-bindings: can: rockchip: add rk3588v2 CAN-FD compatible
Date: Wed,  1 Jul 2026 15:01:26 +0800
X-OQ-MSGID: <20260701070128.2096267-2-1579567540@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701070128.2096267-1-1579567540@qq.com>
References: <20260701070128.2096267-1-1579567540@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7937-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:kernel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:1579567540@qq.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[qq.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,sntech.de,vger.kernel.org,lists.infradead.org,qq.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,qq.com:dkim,qq.com:email,qq.com:mid,qq.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F01306EA75C

From: luch00 <1579567540@qq.com>

The RK3588 CAN-FD controller uses the same DT properties as the
existing Rockchip CAN-FD blocks, so extend the current schema with a
SoC-specific rockchip,rk3588v2-canfd compatible instead of creating a
new binding file.

Keep RK3588v2 as its own compatible rather than an rk3568v2 fallback.
Driver support uses separate match data and the RX FIFO count field
layout differs from rk3568v2, so a dedicated compatible is the safer
description.

Signed-off-by: luch00 <1579567540@qq.com>
---
 .../devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
index a077c0330..aa31ec78e 100644
--- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - const: rockchip,rk3568v2-canfd
+      - const: rockchip,rk3588v2-canfd
       - items:
           - const: rockchip,rk3568v3-canfd
           - const: rockchip,rk3568v2-canfd
-- 
2.34.1


