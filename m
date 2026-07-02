Return-Path: <linux-can+bounces-7958-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KKuWEyVxRmqdVAsAu9opvQ
	(envelope-from <linux-can+bounces-7958-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 16:09:41 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF5C6F8B7A
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 16:09:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=wVvJgs6P;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7958-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7958-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF25F307D7EB
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758794C6EE7;
	Thu,  2 Jul 2026 14:07:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FAB4ADD9D
	for <linux-can@vger.kernel.org>; Thu,  2 Jul 2026 14:07:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001249; cv=none; b=n7Dya3uvARN416o6ta84JpYQ2JsbQBWQmzWZt0U5YNXs3e0sM9ktgYfNNf7e7cVNQn25JuNv/mXc6nDoFq9dL7RR1sS4rXYfgspmBots8rjmXIRbeljxYm0UFBj6C2wgKrkJZXtp7tyyhjhyl0A4FbhdBFs+D8qOulr33sjriqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001249; c=relaxed/simple;
	bh=OZpymQHp32k8XyuUHmZpqssFrS+HWFNNhOffeFK995g=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=jev6CThNUgGDUXdQl2sjAnOclbjsKd4Rtu+pigRR0t33omxEnC+onke3Cl+0TA5FOa6/MXttLS9c9fccCM4ykG93WUxDGXLqTmgZDpih5zf9rCIm8pY+m8GL8jBwDOJecbcP3r9F5Yqe5bn1ami/DHf+7Ypo4Jieh7Xe3O1L7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wVvJgs6P; arc=none smtp.client-ip=162.62.57.210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783001241; bh=/7XOl3w91hOUbQxmzIR2m5YIz3vbahuHJqb9BRaXCj0=;
	h=From:To:Cc:Subject:Date;
	b=wVvJgs6PeVibewGukVv6ROeFdxW964IpTzNl5KXqKOfnkCN6/TJPXIxjY9s07zLU1
	 tvsjPYCQtqWnSwlZq+IwMCidFZxX3p0ZDy+xPAx5NoTs/qcmFmcbP24SV13pnOmblT
	 R7YX+AGKcCYk0oYZbkAuQEyns3bQ6GqFB2prxyWU=
Received: from localhost.localdomain ([218.4.149.66])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 1D09A800; Thu, 02 Jul 2026 22:07:16 +0800
X-QQ-mid: xmsmtpt1783001236tk28nalud
Message-ID: <tencent_87CB2824608F3C06B4229EF99D3609D00C0A@qq.com>
X-QQ-XMAILINFO: N8W06kCOZCa5FMwEcpxJJHVidSk1vAQDcjFuBk+i1xLcvE7AwoAWrF++TN0smv
	 Gr3j9IxC0UQ391iXGpPWSkN4JYX0zKhJO7OQb6bQWhKxrqDrXHM0EPB+KiAKzx0IwzBvAEF/K9R2
	 2NurbZc1zi470K+bSeczhW3BZeTcOgNAOqoVE3ldSeTSdVQtIS+PuLOQrFMHewM+URGU2AGJcEMk
	 6+EujMyIJ5o9rGNzCr8nL64pe56ysvOTjXGzVTdDQydXwM1W2Sbfk9fAAThmjHOPaYYkpkBwSFBd
	 y8xQIOp0D6tzECChyMK/6lAy14Emj5fnkGuv1EAAjIZuX+BqnaDOZqs6zKvlmHwE0HTDshnu9Xdb
	 1swkq53h7WCdr+4heDN259cyT/vBnn0xlAh0knCBNcaa9H6EGqwTAEHNGG23e1M/PYx85b+S5Pzm
	 ttUUK5QLqMBLkB1XaxWvVXTidpuyHghtXzlO2bRBEf2VeJIvc0HfvKk/JyPxtK9+sOor+W6d+2U8
	 MOQiKXpg214JPFWbAye8ZDLmr33Lk9T8wl/vQm/20dvx1+0hTjLeFodh4yTO7BTDiUp568Q+SHS3
	 JldRy6StxtbG8FUrZ/I8s/nAeDRrKCnZOkYWA9kTgpQ/aMLNNLWZTyu5Wo26tYnXiZQNEeDVJoPf
	 UM6hkzYc10IF9VvCjJEpxoFR/6QmJBv6omPiXZWZ23ar77vVd3GCZBRPN1DY07CCnQL6qCKIwUgT
	 1bHf3Vg9H6XGtjYZr1IXnIxcjNtb/vQIw0jpM0O7nAkdRmnQNXhLXvNiny/j5Qb+w/ACbHIthTAw
	 GHOgRKZgwyTBm31xB2An0HeDWQO6ZhUqzBX1qOrrY+PVUEBTOvRjsIHyHg1sH7+kBN9QbNsnhdWp
	 K4F0u9N7c8R8BL1zlYGyY5qmq2VVwgP7QF7R5+SB6EtFy3YsJpMNs8xEhH2R6D/wFcafogzmAKrP
	 eQ4ZEm6ioTvpMjzTSTbuBn1RB52DIoiWxtrjrANPFav4yhV9/7jZKWEcTgIHhhIzmRKvZonrTBj2
	 L3jkVvRzq0zCd2QWjy
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
	Cunhao Lu <1579567540@qq.com>
Subject: [PATCH v2 0/4] can: rockchip: add RK3588 CAN support
Date: Thu,  2 Jul 2026 22:06:50 +0800
X-OQ-MSGID: <20260702140654.2961561-1-1579567540@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-7958-lists,linux-can=lfdr.de];
	FORGED_SENDER(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:kernel@pengutronix.de,m:conor+dt@kernel.org,m:heiko@sntech.de,m:dmitry.torokhov@gmail.com,m:shengjiu.wang@nxp.com,m:pengpeng@iscas.ac.cn,m:rmk+kernel@armlinux.org.uk,m:ebiggers@kernel.org,m:mario.limonciello@amd.com,m:kmehltretter@gmail.com,m:dlan@kernel.org,m:sboyd@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:1579567540@qq.com,m:krzk@kernel.org,m:conor@kernel.org,m:dmitrytorokhov@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qq.com:+];
	FREEMAIL_FROM(0.00)[qq.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,sntech.de,gmail.com,nxp.com,iscas.ac.cn,armlinux.org.uk,amd.com,vger.kernel.org,lists.infradead.org,qq.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:dkim,qq.com:email,qq.com:mid,qq.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCF5C6F8B7A

From: Cunhao Lu <1579567540@qq.com>

Add support for the RK3588 CAN controller.

RK3588 integrates three CAN-FD controllers that are closely related to
the existing Rockchip CAN-FD IP already supported in the kernel. The
RK3588 variant is not fully compatible with RK3568v2 because the RX
FIFO count register field has a different layout.

This series therefore:

- extends the existing Rockchip CAN-FD binding with the
  rockchip,rk3588-canfd compatible
- adds a dedicated RK3588 match entry and devtype in the driver
- describes the three CAN controller nodes in rk3588-base.dtsi
- enables CAN on the RK3588 Tiger Haikou board

RK3588 encodes RX_FIFO_CNT in bits 7:5 instead of 6:4. This
difference was found by comparing Rockchip's vendor kernel 6.1 CAN
support for RK3568 and RK3588, and was also confirmed by runtime
testing.

RK3588 uses the existing erratum 5 empty-FIFO workaround. Based on
Heiko's testing, v2 also enables the erratum 6 workaround for extended
frames being transmitted as standard frames.

RKCANFD_QUIRK_CANFD_BROKEN remains enabled for RK3588, so CAN-FD stays
disabled for now. Local testing did not reproduce the two known CAN-FD
trigger frames that cause Error Interrupts on RK3568 variants. Instead,
RK3588 shows a different CAN-FD failure mode: CAN-FD frames without BRS
work in this setup, but BRS with a data bitrate different from the
nominal bitrate immediately drives the controller bus-off.

Tested on an embedfire,rk3588-lubancat-5io board with can0/can1
directly connected. Runtime testing used a 200 MHz CAN clock, nominal
bitrate 500 kbit/s, data bitrate 500 kbit/s and 1 Mbit/s, and included stress and
error-path coverage for the existing Rockchip errata handling.

Changes in v2:
- use real author name
- fold the single-compatible entries into an enum, as suggested by Krzysztof
- enable the erratum 6 workaround for RK3588 based on Heiko's testing
- add Heiko's RK3588 Tiger Haikou CAN enablement patch
- keep RKCANFD_QUIRK_CANFD_BROKEN enabled for RK3588 so CAN-FD stays disabled
- document the RK3588 CAN-FD/BRS bus-off failure mode

Cunhao Lu (3):
  dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
  can: rockchip: add RK3588 CAN support
  arm64: dts: rockchip: add CAN-FD nodes for RK3588

Heiko Stuebner (1):
  arm64: dts: rockchip: Enable CAN controller on RK3588-Tiger-Haikou

 .../net/can/rockchip,rk3568v2-canfd.yaml      |  4 +-
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 39 +++++++++++++++++++
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts |  6 +++
 .../net/can/rockchip/rockchip_canfd-core.c    | 12 ++++++
 drivers/net/can/rockchip/rockchip_canfd-rx.c  |  5 ++-
 drivers/net/can/rockchip/rockchip_canfd.h     | 26 ++++++++++++-
 6 files changed, 89 insertions(+), 3 deletions(-)

-- 
2.34.1


