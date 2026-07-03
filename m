Return-Path: <linux-can+bounces-7977-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EWbZIkYgR2osTgAAu9opvQ
	(envelope-from <linux-can+bounces-7977-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 04:36:54 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE3B6FDF89
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 04:36:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=Yl70rcAL;
	dmarc=pass (policy=quarantine) header.from=qq.com;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7977-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7977-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADE31303276C
	for <lists+linux-can@lfdr.de>; Fri,  3 Jul 2026 02:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A389238C36;
	Fri,  3 Jul 2026 02:36:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85168233949;
	Fri,  3 Jul 2026 02:36:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783046170; cv=none; b=rMIrTeu/ZPQVspL2px+fWht7BVYq9l9BN6SIkvtzeJbZc9zwZVhCk7z9x5sd0Zhi/ShrBak4iLgp+9q72yA9An1dOm5RMt2HnGdSMT2mVp1D+ro8+VjEslCtu3876YdKSQ/vBo57F4BVTJ8GSmaCXk0UchdZt1o3ZJ1rMstElxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783046170; c=relaxed/simple;
	bh=9LqzhRpYj9NYtU+MjfggZGnyythjraKKenuyIF9maDo=;
	h=Message-ID:From:Subject:Date:MIME-Version:Content-Type:To:Cc; b=o7rJFzLAapYaQb327OCu8YCtAZL9oRkld7jeRofNjIASagO7zqoAsxtBjkomaRHW880kJHPe03x/CVCbpnC3SzB47y+ZMqBBcrnNehQADeKUheZNKNEe4rlKFdK7gyKlRR8+qdmjf2Vghislpyeb2XcesqtYsxcdMKSxsAdUFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Yl70rcAL; arc=none smtp.client-ip=43.163.128.47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783046160; bh=Ygojyp0bDF3m1hG4wdzA6tVvoWHQZC539t+dNCrdS60=;
	h=From:Subject:Date:To:Cc;
	b=Yl70rcALW07TLVPgPd2M88mr9yTmmtLu2510EYrwHUwRcMgGaYwa6gxaIDoTxb2DE
	 8fCgnzp4TfHFxr6uTY38/KQ7jzGRbeG3/5ESKO2yqQSF4aGfaSeAQRu/UT7MN/Vv7y
	 g4bPctWCrfBfZbrfiQ9jzxza4E2WsgCbNnl/uXwI=
Received: from ubuntu2204.localdomain ([218.4.149.66])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 8F90EEF9; Fri, 03 Jul 2026 10:35:57 +0800
X-QQ-mid: xmsmtpt1783046157t5fksbsjd
Message-ID: <tencent_AA108D2806AC225EF9553469D218C8C0260A@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+3KmgUKGD76+hykZmOInL9Y0xSuZx+MoBIwu/ISbYLz5Ckgifd1
	 LEj6XlcfWOBnhCaHt7hmCOoUoFzy+K/KXHUAQ88bxIAmBFfIlJQRqPHxkovI6oYbu7l6vH/T2/x6
	 grZ/zZu2MzDH4meUIU45bntctml/qWhGkPjG6PyV0FZj92wfqCmJBX5AymIV07GpLuSuX6g0DCJO
	 2eXQQv/fiYYGkr9i/ZE+2RxTZynau9CszCbCbNP/ZDhU+Mg2/weUzrZtT9Hky38D64V5Nq2BfYor
	 6xTHeiPnOS5TrYoA5pElzXRbWDYyJCJxgJF87TqkWfB+XnTAbwpZ/kcMtHR4uxRN/u/DP9s2s8pl
	 n38zjZvKhABIItsJcwJlVRB0RORSToaGS3CUea1e4mB2RrZLzYMx9Fi/GUuyeQpPBMEAVZ+83ipv
	 Ls7uKh4QuL1myJkfC2uezCAaIGrz5Zj8JEe0wz8/R5C0+aasDI5lh5GgZ+7jnd32il9xhlbiPg6E
	 Yip+Lca2WGTBqEFMbhvniWB1nhY0tiUWw0BEsGqnV525yO4mGharcsCPp7sZjQMTjFKP7l4qU8d9
	 ZTqcllymiMIBP2JxCqKVqgEj8rnxOoAlu0M1DALXxeIXX7ku3I8SbVGU3pgMw2xFYAhs24X3J5i9
	 4i3wQwBIyrTM6YS4prddpP2UdUFGZYNFFOx24yK0Rgdg5ECNSToHC5PRfbEq0WVdEBxTxAUukOil
	 AQFIiUiGkwpHtuQhhf/Y6Xi5G3aXxUm/x75bP3+ClKVI6q9LlDE5KzqnIKo3OpWxF2l5+I5kqk4/
	 yuxekeEquXx8FCmMp5VGzTdLFqv25P6/xlG9kUUSQI3w47MsU5LRrHXd0PKY2dCtAEaJusdbBd32
	 dOm+fPb8ny+TGNc4k4GU6zsT6KRIlNT9qblq3ZD/KbBLRw/WrlCywBpRN/4n9L7VVPYVHRk5mpYe
	 WFXlprbDUzca6QItRb+dlQu71RFzMbwMB/f/xgIcWD2GohxHurd5A300PXKoSzU6HRof3RQ8PXCH
	 L3fCOS4uARZvMCvn1Ju7J1nd1UpHCamprjELEYASexwdEg/QUsGL/WxxwfT0/+K84fsRHkJpr6ML
	 7BuGn8L3sqmy2FkhO+LJlvl+Uc4H6/Z/ATwwuPh0qhbmX2C/SjeRGvnRsUXA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Cunhao Lu <1579567540@qq.com>
Subject: [PATCH v3 0/4] can: rockchip: add RK3588 CAN support
Date: Fri, 03 Jul 2026 10:35:39 +0800
X-OQ-MSGID: <20260703-master-v3-0-6d56de6fd2f3@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPsfR2oC/yXMSwqAMAxF0a1IxhZKxO9WxEGtUSP4oakiiHu36
 vDAfe8CIcckUEUXODpYeF0CkjgCO5plIMVdMKDGTOca1WzEk1OFTbGlokST9BDizVHP53dUN79
 lbyey/l3DfT9B5L3KagAAAA==
X-Change-ID: 20260702-master-8c52be892a3f
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-7977-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qq.com:from_mime,qq.com:email,qq.com:mid,qq.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FE3B6FDF89

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
bitrate 500 kbit/s, data bitrate 500 kbit/s and 1 Mbit/s, and included
stress and error-path coverage for the existing Rockchip errata handling.

v2 -> v3:
- Move the Changelog below ---
- Collect Heiko's Reviewed-by and the driver patch Tested-by tag
- Use Co-developed-by for Heiko's RK3588 contributions and add his
  Signed-off-by
v1 -> v2:
- use real author name
- fold the single-compatible entries into an enum, as suggested by Krzysztof
- enable the erratum 6 workaround for RK3588 based on Heiko's testing
- add Heiko's RK3588 Tiger Haikou CAN enablement patch
- keep RKCANFD_QUIRK_CANFD_BROKEN enabled for RK3588 so CAN-FD stays disabled
- document the RK3588 CAN-FD/BRS bus-off failure mode

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
Cunhao Lu (3):
      dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
      can: rockchip: add RK3588 CAN support
      arm64: dts: rockchip: add CAN-FD nodes for RK3588

Heiko Stuebner (1):
      arm64: dts: rockchip: Enable CAN controller on RK3588-Tiger-Haikou

 .../bindings/net/can/rockchip,rk3568v2-canfd.yaml  |  4 ++-
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      | 39 ++++++++++++++++++++++
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts      |  6 ++++
 drivers/net/can/rockchip/rockchip_canfd-core.c     | 12 +++++++
 drivers/net/can/rockchip/rockchip_canfd-rx.c       |  5 ++-
 drivers/net/can/rockchip/rockchip_canfd.h          | 26 ++++++++++++++-
 6 files changed, 89 insertions(+), 3 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260702-master-8c52be892a3f

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


