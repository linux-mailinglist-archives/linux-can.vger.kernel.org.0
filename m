Return-Path: <linux-can+bounces-1035-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2AF93F626
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 15:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97741F2250F
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 13:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D40B149C7A;
	Mon, 29 Jul 2024 13:06:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028E1465B4
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258410; cv=none; b=c/B47qA8emnvl7nJ9W29esFaDpi4Y2TJLnlebO4G/zLJID2qVOqXVy0s7/kYlwgFi3j6aHvOaCymRdumEFBoadqhGHAu8+86OmvESDflcNZFco9wAohl+4Mc0QwhmzIXpwITGBvC6tWv5Ynf8EMDpA3C0UwFUca6LDTxCv8+wKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258410; c=relaxed/simple;
	bh=hlEGTdwY0x+K5Na55TZsk5mIJrFenASjMW0vF12hjuI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E+iLpwEKO/kycIpFGpvgfnTQ9gqTn1k1MJ9xXCx7jv8qAL7ccn9Q2mGVDfkekFiOjE1Kb8pt6i+NQQiuOMtyomyp3SBRjhOuRTzXdvs6s1Giq34aOVNyN489yT5OMU65KNxeKAvAxdja66L0piDxnrO/4nJtymdmImjZo0MkNhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5O-0008KW-3i
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:06:46 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5N-0032tx-Ly
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:06:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 58575310D67
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:06:45 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 1313E310D4C;
	Mon, 29 Jul 2024 13:06:33 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 10482e65;
	Mon, 29 Jul 2024 13:06:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next 00/21] can: rockchip_canfd: add support for CAN-FD
 IP core found on Rockchip RK3568
Date: Mon, 29 Jul 2024 15:05:31 +0200
Message-Id: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJuTp2YC/x2MQQqAIBAAvxJ7bkEtivpKdJBtrSVQ0Qgh+nvSc
 WBmHsichDPMzQOJb8kSfAXdNkCH9TujbJXBKNOr0UyYAp10SESy3m3Ym66jUTtFNECNYmIn5R8
 uUBX0XC5Y3/cD9cpekWoAAAA=
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, David Jander <david@protonic.nl>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3079; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=hlEGTdwY0x+K5Na55TZsk5mIJrFenASjMW0vF12hjuI=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmp5Ozrs1zPlMaUXtRWewD09/Zeezcdp08WvMnE
 Tnekw1F6UiJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqeTswAKCRAoOKI+ei28
 b708CACBi8YDC8rPjeTmlHKrwHiQCg5ojwJOGeHWUOPsaX1WhXrUOGMBVcNK3CxmbZBPpVjOI2B
 yn/kgGxwtps7Q/KFUSx4oD6V4J+TWngs3ozPCjOxOFtnXzuxXmRbU0hf9pnDca4cLfil9afV3iL
 jeBU5PdLQZ9A1hW07/6d3IHfx5DvOKVr4zIniqg4fhLxzumA/nKZjU3NXfu598YvEEmhaRVDxHU
 xhnFciRbGpn19H/Vbjy3Z1K3Q+U3yDVWmY4Uid7upx7ZqXympEBNYcHfnmKcGjgTPiafGAJltH4
 bRTwX0KV/udqRnUgL3p+BC9682GurEyCcJS0BmsfgfKe4RFk
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
David Jander (2):
      arm64: dts: rockchip: add CAN-FD controller nodes to rk3568
      arm64: dts: rockchip: mecsbc: add CAN0 and CAN1 interfaces

Marc Kleine-Budde (19):
      dt-bindings: can: rockchip_canfd: add binding for rockchip CAN-FD controller
      can: rockchip_canfd: add driver for Rockchip CAN-FD controller
      can: rockchip_canfd: add quirks for errata workarounds
      can: rockchip_canfd: add quirk for broken CAN-FD support
      can: rockchip_canfd: add support for rk3568v3
      can: rockchip_canfd: add notes about known issues
      can: rockchip_canfd: rkcanfd_handle_rx_int_one(): implement workaround for erratum 5: check for empty FIFO
      can: rockchip_canfd: rkcanfd_register_done(): add warning for erratum 5
      can: rockchip_canfd: add functions to check if CAN-FD frames are equal
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

 .../bindings/net/can/rockchip,canfd.yaml           |  76 ++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts     |  14 +
 arch/arm64/boot/dts/rockchip/rk3568.dtsi           |  39 +
 drivers/net/can/Kconfig                            |   1 +
 drivers/net/can/Makefile                           |   1 +
 drivers/net/can/rockchip/Kconfig                   |   9 +
 drivers/net/can/rockchip/Makefile                  |  10 +
 drivers/net/can/rockchip/rockchip_canfd-core.c     | 972 +++++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd-ethtool.c  |  73 ++
 drivers/net/can/rockchip/rockchip_canfd-rx.c       | 299 +++++++
 .../net/can/rockchip/rockchip_canfd-timestamp.c    | 105 +++
 drivers/net/can/rockchip/rockchip_canfd-tx.c       | 167 ++++
 drivers/net/can/rockchip/rockchip_canfd.h          | 551 ++++++++++++
 14 files changed, 2325 insertions(+)
---
base-commit: 1722389b0d863056d78287a120a1d6cadb8d4f7b
change-id: 20240729-rockchip-canfd-4233c71f0cc6

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



