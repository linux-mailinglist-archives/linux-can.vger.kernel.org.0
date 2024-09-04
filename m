Return-Path: <linux-can+bounces-1333-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A379796B3F5
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 10:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63401C23A00
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 08:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F08F180021;
	Wed,  4 Sep 2024 08:13:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6941883CDB
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437612; cv=none; b=kindCYIKD/kO7rJRqloSOutp8z1pjV8s2PQ+BtvlKdbkg5wTpsN/gIyoX2j2vF4piulKBKaUfigR5g4rx691O35blsqMsG1mA5Gd6aZOCx8u6Lsywv1rXLtiqzP3esAqg7LJEh8BIkgXkiLI/whKKOmetfXY1hhrRP9M16S69fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437612; c=relaxed/simple;
	bh=duMAzSx3zxVVMczxRw39IYMJhca9+AMRHhj+0T0+g+g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=STR/Ex0AQrFgFZ+7imFVZtf18G5CnQkIwzlch6eULcw0XoTUbgvQWq5wSNyExkiET3fpokp6FS8AjTKTZvhvb984qURjRRUW20hQkl8ZaTZMb1H7iBBot2ph0aC3zqgooOjyy/VBIUA2DGTLXIuNmkfdi4nCEeDL/1m0Qy+bkXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sll8q-0007T6-92
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 10:13:28 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sll8o-005Omc-QO
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 10:13:26 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 71DBF331FBB
	for <linux-can@vger.kernel.org>; Wed, 04 Sep 2024 08:13:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 84DBA331F4B;
	Wed, 04 Sep 2024 08:13:21 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d08ac60a;
	Wed, 4 Sep 2024 08:13:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next v5 00/20] can: rockchip_canfd: add support for
 CAN-FD IP core found on Rockchip RK3568
Date: Wed, 04 Sep 2024 10:12:44 +0200
Message-Id: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHwW2GYC/3XNQYrDMAwF0KsUr8fFlmw36ar3KLNIZLkxA05w0
 pBScvfxZNOBtGj1+dLTU4ycI4/ifHiKzHMcY59KsF8HQV2TbiyjL1mAAqNOUMvc0w91cZDUpOC
 lAUQ66aCInChHQ+YQlw28irIiEy+T+C5NF8epz4/t06y3/hM6a6lkaDRYFbxrGS8Dp9t9yn2Ky
 9Hz5s3wz0C9M6AYvnbKkG1Ny9VbA19GhWpn4J9hwIFzxmJo3hrmZdQKd4YphvaEoQxU1u2MdV1
 /AatLCIGHAQAA
To: kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 David Jander <david@protonic.nl>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=4654; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=duMAzSx3zxVVMczxRw39IYMJhca9+AMRHhj+0T0+g+g=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm2BaBx65953NsHT7vSpWYvxoN16JCIdAT29FHw
 qk2mHyN1gKJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtgWgQAKCRAoOKI+ei28
 b5DjB/40D1AL/GUM5srz14BeftH8sfSRPk/R4lm1UOPuy8zQok9h7OVoYc4X9FxwSw3riYHUSBq
 bY557sJqZOCpfiuB0UXj2PfmuMWFU6XI90yTe/YfM5C5CgWV+QbL4TWYz0EEd+vWZLLEsKihGgB
 cWfVikkbsj+xawunZwYtRoETygiuJzgmavWWrJoenOyeqvNHBBGCERJPlBMyyZNBvXdDnmCgX8y
 zLruXV/O26B2d/+sQZRAZB/zlmo0yim18/u1cI33JXtLKzpIqVwtprv5Q1Eso7byNTG3KaGgf7Q
 Qy1kGDBeucLpVOIyYyShKlMwFKW3JeJFIzqaor4vmNZ6/4mn
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

This series adds support for the CAN-FD IP core found on the Rockchip
RK3568.

The IP core is a bit complicated and has several documented errata.
The driver is added in several stages, first the base driver including
the RX-path. Then several workarounds for errata and the TX-path, and
finally features like hardware time stamping, loop-back mode and
bus error reporting.

regards,
Marc

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v5:
- MAINTAINERS: fix dt-bindings filename (also noted by kernel test robot <lkp@intel.com>)
- dt-bindings: added Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
- Link to v4: https://patch.msgid.link/20240903-rockchip-canfd-v4-0-1dc3f3f32856@pengutronix.de

Changes in v4:
- dt-bindings: renamed to rockchip,rk3568v2-canfd.yaml to match the
  first compatible
- dt-bindings: fix "$id" in yaml (thanks Rob's bot)
- all: add Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
- Link to v3: https://patch.msgid.link/20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de

Changes in v3:
- dt-bindings: renamed file to rockchip,rk3568-canfd.yaml (thanks Rob)
- dt-bindings: reworked compatibles (thanks Rob)
- Link to v2: https://lore.kernel.org/all/20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de

Changes in v2:
- dt-bindings: remove redundant words from subject and patch
  description (thanks Rob)
- dt-bindings: clean up clock- and reset-names (thanks Rob)
- base driver: add missing bitfield.h header
- base driver: rkcanfd_handle_rx_int_one(): initialize header to avoid
  uninitialzied variable warning on m68k
- base driver: rkcanfd_get_berr_counter_raw(): don't add assigned only
  variable (bec_raw), move to 14/20 (thanks Simon)
- CAN-FD frame equal check + TX-path: squash, to avoid unused
  functions (thanks Simon)
- TX-path: rkcanfd_handle_tx_done_one(): don't add assigned only
  variable (skb), move to 18/20 (thanks Simon)
- HW-timetamping: add missing timecounter.h header (thanks Simon)
- Link to v1: https://lore.kernel.org/all/20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de

---
David Jander (2):
      arm64: dts: rockchip: add CAN-FD controller nodes to rk3568
      arm64: dts: rockchip: mecsbc: add CAN0 and CAN1 interfaces

Marc Kleine-Budde (18):
      dt-bindings: can: rockchip_canfd: add rockchip CAN-FD controller
      can: rockchip_canfd: add driver for Rockchip CAN-FD controller
      can: rockchip_canfd: add quirks for errata workarounds
      can: rockchip_canfd: add quirk for broken CAN-FD support
      can: rockchip_canfd: add support for rk3568v3
      can: rockchip_canfd: add notes about known issues
      can: rockchip_canfd: rkcanfd_handle_rx_int_one(): implement workaround for erratum 5: check for empty FIFO
      can: rockchip_canfd: rkcanfd_register_done(): add warning for erratum 5
      can: rockchip_canfd: add TX PATH
      can: rockchip_canfd: implement workaround for erratum 6
      can: rockchip_canfd: implement workaround for erratum 12
      can: rockchip_canfd: rkcanfd_get_berr_counter_corrected(): work around broken {RX,TX}ERRORCNT register
      can: rockchip_canfd: add stats support for errata workarounds
      can: rockchip_canfd: prepare to use full TX-FIFO depth
      can: rockchip_canfd: enable full TX-FIFO depth of 2
      can: rockchip_canfd: add hardware timestamping support
      can: rockchip_canfd: add support for CAN_CTRLMODE_LOOPBACK
      can: rockchip_canfd: add support for CAN_CTRLMODE_BERR_REPORTING

 .../bindings/net/can/rockchip,rk3568v2-canfd.yaml  |  74 ++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts     |  14 +
 arch/arm64/boot/dts/rockchip/rk3568.dtsi           |  39 +
 drivers/net/can/Kconfig                            |   1 +
 drivers/net/can/Makefile                           |   1 +
 drivers/net/can/rockchip/Kconfig                   |   9 +
 drivers/net/can/rockchip/Makefile                  |  10 +
 drivers/net/can/rockchip/rockchip_canfd-core.c     | 969 +++++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd-ethtool.c  |  73 ++
 drivers/net/can/rockchip/rockchip_canfd-rx.c       | 299 +++++++
 .../net/can/rockchip/rockchip_canfd-timestamp.c    | 105 +++
 drivers/net/can/rockchip/rockchip_canfd-tx.c       | 167 ++++
 drivers/net/can/rockchip/rockchip_canfd.h          | 553 ++++++++++++
 14 files changed, 2322 insertions(+)
---
base-commit: 3d4d0fa4fc32f03f615bbf0ac384de06ce0005f5
change-id: 20240729-rockchip-canfd-4233c71f0cc6

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



