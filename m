Return-Path: <linux-can+bounces-354-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E059D86FD12
	for <lists+linux-can@lfdr.de>; Mon,  4 Mar 2024 10:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8B31C20A51
	for <lists+linux-can@lfdr.de>; Mon,  4 Mar 2024 09:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED131BDEE;
	Mon,  4 Mar 2024 09:21:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFBE12E73
	for <linux-can@vger.kernel.org>; Mon,  4 Mar 2024 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544066; cv=none; b=d8SrEngT6HeWiS2R4f8rCDpMEx0PXsFpZYBucsPj8zpES89TCZcI2FQyCT3AV+PZwZj7cAtoYmqiQgV9FLB46RD+IIGqUZOTM49H9wzIfntSSDhbl7A1NfPRNj7Y3KK/NzuuNH7phoH2cs2Se0qQbsP1VAxi1ftuBirEGCHPhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544066; c=relaxed/simple;
	bh=LADCPty7Oz8t2Igge4UBcRg9ObfAg7W91mlnsyKOR5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sy+RtgjOBdSTlVwFilMa8aabqQt6neEswlog8SMAuJnFq9aTi5cgpOgxOEUL8gNRQfp2Ayx3N98Mq/Ggw5aehRvhL/evXTVCDDiSWHqyVEBQ47spcWmWEd39A3h9EFvhNKPpaBXYQGcUs+5/9f6GMCIY/JgCHdHfqDuIcCd/GKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rh4VL-000521-9g
	for linux-can@vger.kernel.org; Mon, 04 Mar 2024 10:21:03 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rh4VK-004K2z-RK
	for linux-can@vger.kernel.org; Mon, 04 Mar 2024 10:21:02 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 871BA29CB37
	for <linux-can@vger.kernel.org>; Mon,  4 Mar 2024 09:21:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 9EA3329CB27;
	Mon,  4 Mar 2024 09:21:01 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 546a4ee0;
	Mon, 4 Mar 2024 09:21:01 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/4] pull-request: can-next 2024-03-04
Date: Mon,  4 Mar 2024 10:13:54 +0100
Message-ID: <20240304092051.3631481-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hello netdev-team,

this is a pull request of 4 patches for net-next/master.

The 1st patch is by Jimmy Assarsson and adds support for the Leaf v3
to the kvaser_usb driver.

Martin Jocić's patch targets the kvaser_pciefd driver and adds support
for the Kvaser PCIe 8xCAN device.

Followed by a patch by me that adds a missing a cpu_to_le32() to the
gs_usb driver, the change is not critical as the assigned value is 0.

The last patch is also by me and replaces a literal 256 with a proper
define.

regards,
Marc

---

The following changes since commit 4b2765ae410abf01154cf97876384d8a58c43953:

  Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next (2024-03-02 20:50:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.9-20240304

for you to fetch changes up to 79f7319908fb568f60b7ddbe0cb9c9d2e714ac87:

  can: mcp251xfd: __mcp251xfd_get_berr_counter(): use CAN_BUS_OFF_THRESHOLD instead of open coding it (2024-03-04 08:47:04 +0100)

----------------------------------------------------------------
linux-can-next-for-6.9-20240304

----------------------------------------------------------------
Jimmy Assarsson (1):
      can: kvaser_usb: Add support for Leaf v3

Marc Kleine-Budde (2):
      can: gs_usb: gs_cmd_reset(): use cpu_to_le32() to assign mode
      can: mcp251xfd: __mcp251xfd_get_berr_counter(): use CAN_BUS_OFF_THRESHOLD instead of open coding it

Martin Jocić (1):
      can: kvaser_pciefd: Add support for Kvaser PCIe 8xCAN

 drivers/net/can/Kconfig                          | 1 +
 drivers/net/can/kvaser_pciefd.c                  | 7 ++++++-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c   | 2 +-
 drivers/net/can/usb/Kconfig                      | 1 +
 drivers/net/can/usb/gs_usb.c                     | 2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 3 +++
 6 files changed, 13 insertions(+), 3 deletions(-)


