Return-Path: <linux-can+bounces-2571-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5D8A08F36
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 12:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF86F167DD5
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABDD20B813;
	Fri, 10 Jan 2025 11:27:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F5020A5C2
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508440; cv=none; b=KElkzXvQtkldlro4eEsp/QZRjm/qcQKWApNmyufS9vk7CmeViswFQOywl65KQTWfCZpGrVLrRdZPr9EAW0NlPy4laq9/jWbLKaCOCRLQEQXQUz+5pg+q55+dH14Z/KD80w09GSPg7XW5GOCw/uMCX8n5DNVHo00qj+tCHKxO82s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508440; c=relaxed/simple;
	bh=86aNBKdbVeEYwrNY3ykEWWFCcFhj7ebi7u4x5u+Gqg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HD4JMBxvR3yDr9kA6ja3MZL+wVk+XPBCzMFk9+etf5vPMCWnp9taVlLsOLAGZYDD9pfPszuCGTjawMVcSHsFOAvRDhS0qzTuTmHJ4bMDw4y6Eq7R4Th2rImui2kajSV6vbopYevkebpPf40V91uy+h7CQsDhCVWeItMwbEPulFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAZ-0004uK-Sq
	for linux-can@vger.kernel.org; Fri, 10 Jan 2025 12:27:15 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAZ-0009c4-1y
	for linux-can@vger.kernel.org;
	Fri, 10 Jan 2025 12:27:15 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 468253A45A7
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:15 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 52DF73A458B;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d4c76e2f;
	Fri, 10 Jan 2025 11:27:13 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/18] pull-request: can-next 2025-01-10
Date: Fri, 10 Jan 2025 12:04:08 +0100
Message-ID: <20250110112712.3214173-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
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

this is a pull request of 18 patches for net-next/master.

Pierre-Henry Moussay adds PIC64GX compatibility to the DT bindings for
Microchip's mpfs-can IP core.

The next 3 patches are by Sean Nyekjaer and target the tcan4x5x
driver. First the DT bindings is converted to DT schema, then nWKRQ
voltage selection is added to the driver.

Dario Binacchi's patch for the sun4i_can makes the driver more
consistent by adding a likely() to the driver.

Another patch by Sean Nyekjaer for the tcan4x5x driver gets rid of a
false error message.

Charan Pedumuru converts the atmel-can DT bindings to DT schema.

The next 2 patches are by Oliver Hartkopp. The first one maps Oliver's
former mail addresses to a dedicated CAN mail address. The second one
assigns net/sched/em_canid.c additionally to the CAN maintainers.

Ariel Otilibili's patch removes dead code from the CAN dev helper.

The next 3 patches are by Sean Nyekjaer and add HW standby support to
the tcan4x5x driver.

A patch by Dario Binacchi fixes the DT bindings for the st,stm32-bxcan
driver.

The last 4 patches are by Jimmy Assarsson and target the kvaser_usb
and the kvaser_pciefd driver: error statistics are improved and
CAN_CTRLMODE_BERR_REPORTING is added.

regards,
Marc

---

The following changes since commit 65ae975e97d5aab3ee9dc5ec701b12090572ed43:

  Merge tag 'net-6.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-11-28 10:15:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.14-20250110

for you to fetch changes up to c1a6911485b022e093c589c295a953ff744112b9:

  Merge patch series "can: kvaser_usb: Update stats and state even if alloc_can_err_skb() fails" (2025-01-10 11:32:43 +0100)

----------------------------------------------------------------
linux-can-next-for-6.14-20250110

----------------------------------------------------------------
Ariel Otilibili (1):
      can: dev: can_get_state_str(): Remove dead code

Charan Pedumuru (1):
      dt-bindings: net: can: atmel: Convert to json schema

Dario Binacchi (2):
      can: sun4i_can: continue to use likely() to check skb
      dt-bindings: can: st,stm32-bxcan: fix st,gcan property type

Jimmy Assarsson (4):
      can: kvaser_usb: Update stats and state even if alloc_can_err_skb() fails
      can: kvaser_usb: Add support for CAN_CTRLMODE_BERR_REPORTING
      can: kvaser_pciefd: Update stats and state even if alloc_can_err_skb() fails
      can: kvaser_pciefd: Add support for CAN_CTRLMODE_BERR_REPORTING

Marc Kleine-Budde (3):
      Merge patch series "can: tcan4x5x: add option for selecting nWKRQ voltage"
      Merge patch series "can: tcan4x5x/m_can: use standby mode when down and in suspend"
      Merge patch series "can: kvaser_usb: Update stats and state even if alloc_can_err_skb() fails"

Oliver Hartkopp (2):
      mailmap: add an entry for Oliver Hartkopp
      MAINTAINERS: assign em_canid.c additionally to CAN maintainers

Pierre-Henry Moussay (1):
      dt-bindings: can: mpfs: add PIC64GX CAN compatibility

Sean Nyekjaer (7):
      dt-bindings: can: convert tcan4x5x.txt to DT schema
      dt-bindings: can: tcan4x5x: Document the ti,nwkrq-voltage-vio option
      can: tcan4x5x: add option for selecting nWKRQ voltage
      can: tcan4x5x: get rid of false clock errors
      can: m_can: add deinit callback
      can: tcan4x5x: add deinit callback to set standby mode
      can: m_can: call deinit/init callback when going into suspend/resume

 .mailmap                                           |   2 +
 .../bindings/net/can/atmel,at91sam9263-can.yaml    |  58 ++++++
 .../devicetree/bindings/net/can/atmel-can.txt      |  15 --
 .../bindings/net/can/microchip,mpfs-can.yaml       |   6 +-
 .../bindings/net/can/st,stm32-bxcan.yaml           |   2 +-
 .../devicetree/bindings/net/can/tcan4x5x.txt       |  48 -----
 .../devicetree/bindings/net/can/ti,tcan4x5x.yaml   | 199 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 drivers/net/can/dev/dev.c                          |   2 -
 drivers/net/can/kvaser_pciefd.c                    |  81 +++++----
 drivers/net/can/m_can/m_can.c                      |  22 ++-
 drivers/net/can/m_can/m_can.h                      |   1 +
 drivers/net/can/m_can/tcan4x5x-core.c              |  30 +++-
 drivers/net/can/m_can/tcan4x5x.h                   |   2 +
 drivers/net/can/sun4i_can.c                        |   2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |   3 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  | 133 ++++++--------
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   |  38 ++--
 18 files changed, 432 insertions(+), 213 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/atmel-can.txt
 delete mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml


