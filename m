Return-Path: <linux-can+bounces-1385-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFD496BD96
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 15:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA171C21982
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 13:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7181D9357;
	Wed,  4 Sep 2024 13:03:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405E31D88BB
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454986; cv=none; b=kOyziWMj782Wi6QV3ttJLt1Gi+6KvpB+Gya3n6tls87Z7VhAWJGJk/1EL60dXYqefId8jGNk+TnDyQJISdWu1ZdkxkA5XXM5TKO/rmuY5PQsZpxpQqhcwr/9IfkQw4pIIiawpBVa+wE0tv3itdioqPRA7rdpwaGrQ3Y+BbofNiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454986; c=relaxed/simple;
	bh=mPMnVZJNI1PXraBZoo3+o0U35cW4il190VTuQNuYusw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKx/EWlRWJcvnNzcJIxtMK4DJPw55CerkGf7HXLQ488OVQM2sjmt/9uNUZ7SRMoicVvdFbZNbcR61nY9zVkl2h/NNe6OYkEHuruoQW4wrM6nAAstfXzBLS+qCfRDMMezAK57M4xQhjzbDwB452QL1x1KTryPLwBFLBeAnrVeCEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slpf3-0006tw-H7
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 15:03:01 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slpf2-005SQz-TK
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 15:03:00 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 96DF2332773
	for <linux-can@vger.kernel.org>; Wed, 04 Sep 2024 13:03:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B098233275C;
	Wed, 04 Sep 2024 13:02:59 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 79bd080a;
	Wed, 4 Sep 2024 13:02:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/18] pull-request: can-next 2024-09-04-2
Date: Wed,  4 Sep 2024 14:55:16 +0200
Message-ID: <20240904130256.1965582-1-mkl@pengutronix.de>
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

All 18 patches add support for CAN-FD IP core found on Rockchip
RK3568.

The first patch is co-developed by Elaine Zhang and me and adds DT
bindings documentation.

The remaining 17 patches are by me and add the driver in several
stages.

regards,
Marc

---

The following changes since commit 3d4d0fa4fc32f03f615bbf0ac384de06ce0005f5:

  be2net: Remove unused declarations (2024-09-03 15:38:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.12-20240904-2

for you to fetch changes up to 9d56d4aa1b7b0e05e829d8f3db26a1c33a4fcd44:

  Merge patch series "can: rockchip_canfd: add support for CAN-FD IP core found on Rockchip RK3568" (2024-09-04 14:48:17 +0200)

----------------------------------------------------------------
linux-can-next-for-6.12-20240904-2

----------------------------------------------------------------
Marc Kleine-Budde (19):
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
      Merge patch series "can: rockchip_canfd: add support for CAN-FD IP core found on Rockchip RK3568"

 .../bindings/net/can/rockchip,rk3568v2-canfd.yaml  |  74 ++
 MAINTAINERS                                        |   8 +
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
 12 files changed, 2269 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
 create mode 100644 drivers/net/can/rockchip/Kconfig
 create mode 100644 drivers/net/can/rockchip/Makefile
 create mode 100644 drivers/net/can/rockchip/rockchip_canfd-core.c
 create mode 100644 drivers/net/can/rockchip/rockchip_canfd-ethtool.c
 create mode 100644 drivers/net/can/rockchip/rockchip_canfd-rx.c
 create mode 100644 drivers/net/can/rockchip/rockchip_canfd-timestamp.c
 create mode 100644 drivers/net/can/rockchip/rockchip_canfd-tx.c
 create mode 100644 drivers/net/can/rockchip/rockchip_canfd.h


