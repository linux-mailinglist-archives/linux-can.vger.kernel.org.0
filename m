Return-Path: <linux-can+bounces-2856-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5BBA3BCDF
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 12:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E693D17080D
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 11:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A981D9663;
	Wed, 19 Feb 2025 11:34:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AD41B85CC
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964842; cv=none; b=JRCtTwDUBlxfgaYkulUobiemjyctxEFsDdJ2gtL7lXt4lRpiyd0foc5WCs7G13s5UOS9cfGHBcOcm/LMsDlpxupxPoa0eukl+iDIIPW+kh+d7vVrws0wex0Rkh4fJztsSisqS8yGlZQjykHFeuSfl24C73K0tGUOg+NXG1bRYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964842; c=relaxed/simple;
	bh=2vEYWqL9IhP9w2W6QCmr4AOaeSTiUWRpX6YPZaP42ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pBvl20H2M4FbwY2IuB3tyr+IX2gFMB7OZqigCnzPzWM6RdyxFPut/SeK9AA+W/18YRri6vwwSmqtN0CfABMGIXm9+9kydUEn3R59Qcu4Rxf4rFZCiyd+0iIhk8PscMWIRlgGoIZafXtBejRwc9lbkYu2q8YIwET+OMubAjbBErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL0-0001Sc-Pl
	for linux-can@vger.kernel.org; Wed, 19 Feb 2025 12:33:58 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL0-001kxp-1X
	for linux-can@vger.kernel.org;
	Wed, 19 Feb 2025 12:33:58 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 18DC33C68F0
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:33:58 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D92853C68D5;
	Wed, 19 Feb 2025 11:33:56 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c883b4f2;
	Wed, 19 Feb 2025 11:33:56 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/12] pull-request: can-next 2025-02-19
Date: Wed, 19 Feb 2025 12:21:05 +0100
Message-ID: <20250219113354.529611-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hello netdev-team,

this is a pull request of 12 patches for net-next/master.

The first 4 patches are by Krzysztof Kozlowski and simplify the c_can
driver's c_can_plat_probe() function.

Ciprian Marian Costea contributes 3 patches to add S32G2/S32G3 support
to the flexcan driver.

Ruffalo Lavoisier's patch removes a duplicated word from the mcp251xfd
DT bindings documentation.

Oleksij Rempel extends the J1939 documentation.

The next patch is by Oliver Hartkopp and adds access for the Remote
Request Substitution bit in CAN-XL frames.

Henrik Brix Andersen's patch for the gs_usb driver adds support for
the CANnectivity firmware.

The last patch is by Robin van der Gracht and removes a duplicated
setup of RX FIFO in the rockchip_canfd driver.

regards,
Marc

---

The following changes since commit aefd232de5eb2e77e3fc58c56486c7fe7426a228:

  Merge branch 'net-deduplicate-cookie-logic' (2025-02-18 18:27:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.15-20250219

for you to fetch changes up to d9e1cc087a55286fe028e0f078159b30d7da90bd:

  can: rockchip_canfd: rkcanfd_chip_fifo_setup(): remove duplicated setup of RX FIFO (2025-02-19 12:17:40 +0100)

----------------------------------------------------------------
linux-can-next-for-6.15-20250219

----------------------------------------------------------------
Ciprian Marian Costea (3):
      dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
      can: flexcan: Add quirk to handle separate interrupt lines for mailboxes
      can: flexcan: add NXP S32G2/S32G3 SoC support

Henrik Brix Andersen (1):
      can: gs_usb: add VID/PID for the CANnectivity firmware

Krzysztof Kozlowski (4):
      can: c_can: Drop useless final probe failure message
      can: c_can: Simplify handling syscon error path
      can: c_can: Use of_property_present() to test existence of DT property
      can: c_can: Use syscon_regmap_lookup_by_phandle_args

Marc Kleine-Budde (2):
      Merge patch series "can: c_can: Simplify few things"
      Merge patch series "add FlexCAN support for S32G2/S32G3 SoCs"

Oleksij Rempel (1):
      can: j1939: Extend stack documentation with buffer size behavior

Oliver Hartkopp (1):
      can: canxl: support Remote Request Substitution bit access

Robin van der Gracht (1):
      can: rockchip_canfd: rkcanfd_chip_fifo_setup(): remove duplicated setup of RX FIFO

Ruffalo Lavoisier (1):
      dt-binding: can: mcp251xfd: remove duplicate word

 .../devicetree/bindings/net/can/fsl,flexcan.yaml   |  44 +-
 .../bindings/net/can/microchip,mcp251xfd.yaml      |   2 +-
 Documentation/networking/j1939.rst                 | 675 +++++++++++++++++++++
 drivers/net/can/c_can/c_can_platform.c             |  51 +-
 drivers/net/can/flexcan/flexcan-core.c             |  35 +-
 drivers/net/can/flexcan/flexcan.h                  |   5 +
 drivers/net/can/rockchip/rockchip_canfd-core.c     |   5 -
 drivers/net/can/usb/gs_usb.c                       |   5 +
 include/uapi/linux/can.h                           |   3 +-
 9 files changed, 777 insertions(+), 48 deletions(-)


