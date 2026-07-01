Return-Path: <linux-can+bounces-7934-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PnbUIGi7RGr8zgoAu9opvQ
	(envelope-from <linux-can+bounces-7934-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 09:02:00 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF396EA6A9
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 09:02:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=FxeBYoB6;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7934-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7934-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B40E3017476
	for <lists+linux-can@lfdr.de>; Wed,  1 Jul 2026 07:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3DB3B1EFC;
	Wed,  1 Jul 2026 07:01:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F132AAC5;
	Wed,  1 Jul 2026 07:01:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889318; cv=none; b=S8HlCgpmDG+e0/ad3lBPHy2soufWFoKzusqL1okdrBwzXO29EAq14TX4CilhSGHcaA8Foi2810kP+XRUQBZah2FLNSGQPfeacU20WDgerIHoZT2zihMgSv9Xi12HbcV+KGiUhiE+xqiBHBofscFBGfT+22DAC9DNEqBY0smJDxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889318; c=relaxed/simple;
	bh=sjN+zSOrb+uCyCmWhfBsuqL1TU667U7SFjPwKN7eBtU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=bFVuTp43ZRgMNSaaX751RHJZjook33sOzmAupjqPc1l5Hf4cV+bGd0QgH8KuNV2WmNapvIannFLGdtrXDyrPaqXGEqGYD7BoEhTjuDBOiWDilSkmrJAmeoMxyYXUVdWx5Wg5it+5le3XIkL0nANg+HHNbwJ8wIx4b+j9/9LGtZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FxeBYoB6; arc=none smtp.client-ip=203.205.221.245
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782889313; bh=QR9RBoB1Xmuk4gv9Ndt2VcbKJ9ZdwkH84K6Kq+4ROVI=;
	h=From:To:Cc:Subject:Date;
	b=FxeBYoB6puju4Hin+GuVVFvY0evwWhdzBR3P/8SBqH/gxVmwmgcia7CXogCppqSi9
	 4KjUue0uxR+TXGl7ZFGShRAX2lKJQG4RRSnKYrHkiISO7b3tY4+3a0DhJEm5DXCaio
	 aW4PMbsRBhBUqfq9/ojnUAuJxybx60Mp/esYVKxQ=
Received: from localhost.localdomain ([2409:8d20:2a:1b57:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 71832C3; Wed, 01 Jul 2026 15:01:49 +0800
X-QQ-mid: xmsmtpt1782889309t62leqei9
Message-ID: <tencent_1A4614039A100DFD8A9AE2692865FE126009@qq.com>
X-QQ-XMAILINFO: MQAOa38Yz/8/h5mNRBixUf9sGBvjbDPTpGQYlPe1/W7Je2YVdByg9DNAmYCwnu
	 z1/Zxh4RpOppC3m6mSnmBWZc5sgV5oqdxMUxPWGscfEQ9nWr3S4nvGUI/24nXv0hzAJ/531B9K36
	 roUixxW5N3vrXCTqW9TW9rJcH2kHkw8gGJBS03gtvLir0ls9hs0J/mL4GJaaAw92TqLYW1OYXX3Y
	 IG3DMEhfjE/vikZrt6sxYSDKQVZ1I2aVKsgKZgePGAdhdUWP9/7A4UgiiEA4k8dJWKPmuRx3Ce+J
	 V+1vH4tlPCcVMuJ1uuXOC75eMduywjiZ9nYvu6hXorjieuM+5p7jrhkEP7bIW62yx4jX30ROQkbG
	 RlNqz9OFSbpaiVenuZEVaumQwB+L0SjhIiu7Mi+4Q8IRh4LHg0w/sSv+rADFVQi5Xp3ZG6My0gJE
	 1TSd14IW/YQgnDqtwweogZWZNssn1LSzHofdhC6ZqRz3Y/9foxitDdJNxayK5yRe4pRxPfhA/lAE
	 +rg70fBZcBIIlKX76DfekzDNZVN+wyQV56t3JrfRuoQQGjynJqmCnhlguDScea/eqmEzW7ki0n40
	 OBdGTsZCAmVHIahs9pP5Yegx9xs54xY/oPF4YTzhTdYgc8s8uoYfTAWHtUpXqZKzvUMGFfwjCjLv
	 NCI3RrU4obRgkZGqp57FVB6Vbp6UbmQpR7KQCVntf5PQgvEhA0DW5RTyfcMdv5BPAhhT59fR81oJ
	 snOCZPlvw1dF38VRZ1/YyJBgBXMpC+pta5I3yBtYpuYeJjH+WWBv1juRNAGsb7AXVV7W1BnJ20zh
	 Ws2GbDnx+dUzu+8My8RkkH9cZEdM/jXsmhUofoqO16AUf0xXLCZCr2isoJTfLALYeR5aWYyGqjU0
	 xRC7J9FRtapIgEAwfY+XzyPYVZPzc5NSCYEBGO2TM0Z3siwt+s3hrVFwAydsQsd598WeclGD0E2h
	 VVj5D3OEa4AKo+PUXD27ZM6daxN0kzD+iqb6+pO4BRCy9TQ2RF14VKZUh1bxSlP9lzdxG/W2xUkm
	 AuPA31ZcCycKTHttoYgvyoB+Abtsj66Z+zOpDm7KO/5Oiiy/7cxIlB9pClCEG+QDML8aUpeEaPht
	 HGMt4b
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
Subject: [PATCH 0/3] can: rockchip: add RK3588 CAN-FD support
Date: Wed,  1 Jul 2026 15:01:25 +0800
X-OQ-MSGID: <20260701070128.2096267-1-1579567540@qq.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7934-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qq.com:dkim,qq.com:email,qq.com:mid,qq.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CF396EA6A9

From: luch00 <1579567540@qq.com>

Add initial support for the RK3588v2 CAN-FD controller.

RK3588 integrates three CAN-FD controllers that are closely related to
the existing Rockchip CAN-FD IP already supported in the kernel, but
they cannot reuse the rk3568v2 description unchanged.

This series therefore:

- extends the existing Rockchip CAN-FD binding with the
  rockchip,rk3588v2-canfd compatible
- adds a dedicated RK3588v2 match entry and devtype in the driver
- describes the three CAN-FD controller nodes in rk3588-base.dtsi

The dedicated driver data is needed because RK3588v2 encodes
RX_FIFO_CNT in bits 7:5 instead of 6:4. Runtime validation on RK3588v2
also showed that its observed errata profile differs from rk3568v2 and
rk3568v3, so using a fallback compatible would be misleading.

Tested on an embedfire,rk3588-lubancat-5io board with can0/can1
directly connected. Runtime testing used a 198 MHz CAN clock, nominal
bitrate 500 kbit/s, data bitrate 1 Mbit/s, and included stress and
error-path coverage for the existing Rockchip errata handling.

luch00 (3):
  dt-bindings: can: rockchip: add rk3588v2 CAN-FD compatible
  can: rockchip: add RK3588 CAN-FD support
  arm64: dts: rockchip: add CAN-FD nodes for RK3588

 .../net/can/rockchip,rk3568v2-canfd.yaml      |  1 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 39 +++++++++++++++++++
 .../net/can/rockchip/rockchip_canfd-core.c    | 14 +++++++
 drivers/net/can/rockchip/rockchip_canfd-rx.c  |  5 ++-
 drivers/net/can/rockchip/rockchip_canfd.h     | 12 +++++-
 5 files changed, 69 insertions(+), 2 deletions(-)

-- 
2.34.1


