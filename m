Return-Path: <linux-can+bounces-3077-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6D1A6127E
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC9A162F87
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 13:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71431FFC43;
	Fri, 14 Mar 2025 13:23:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E051FF7D5
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958613; cv=none; b=c63H47YB1IbLkLWte+AKafmyrZJLvMe4iuWeEOX6j2SH8E+/by6QvCFkqpbwC9TIYJjku3OYZTUXWIboEJJ0g4oAuPtMbhI5bkxIe6/uRuvdJWKDXre0W9x9uvmDEINwEN9sRkufM71wvrzwqtNbh3d2XnrKE252BchWkTQ9tqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958613; c=relaxed/simple;
	bh=lMCIKNZKcc02fMfv+ywfFQtyP/pXJF8iB5Pk7aJHZjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KVZeB82BK9vQdHitBxpoY8mTJW47Mk20bn/J1w8WMFFS2Gzrp1nD74OFELhhpBxRSrrngWIJUAbHsGaoamolME4myjoyY4BBIYGMuyCcZCDtTX0/vNR9SNzmIsJKgvkI8rvikrn/Jw9ZxgzKkHvRinjcmkF0nZwpvVSQfS6VjzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt50c-0001hF-K5
	for linux-can@vger.kernel.org; Fri, 14 Mar 2025 14:23:30 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt50c-005i4Y-1H
	for linux-can@vger.kernel.org;
	Fri, 14 Mar 2025 14:23:30 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 169F23DBBF9
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 13:23:30 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3B6C93DBBE6;
	Fri, 14 Mar 2025 13:23:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7e77eee0;
	Fri, 14 Mar 2025 13:23:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/4] pull-request: can-next 2025-03-14
Date: Fri, 14 Mar 2025 14:19:14 +0100
Message-ID: <20250314132327.2905693-1-mkl@pengutronix.de>
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

this is a pull request of 4 patches for net-next/main.

In the first 2 patches by Dimitri Fedrau add CAN transceiver support
to the flexcan driver.

Frank Li's patch adds i.MX94 support to the flexcan device tree
bindings.

The last patch is by Davide Caratti and adds protocol counter for
AF_CAN sockets.

regards,
Marc

---
The following changes since commit 941defcea7e11ad7ff8f0d4856716dd637d757dd:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-03-13 23:08:11 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.15-20250314

for you to fetch changes up to 6bffe88452dbe284747442f10a7ac8249d6495d7:

  can: add protocol counter for AF_CAN sockets (2025-03-14 13:27:33 +0100)

----------------------------------------------------------------
linux-can-next-for-6.15-20250314

----------------------------------------------------------------
Davide Caratti (1):
      can: add protocol counter for AF_CAN sockets

Dimitri Fedrau (2):
      dt-bindings: can: fsl,flexcan: add transceiver capabilities
      can: flexcan: add transceiver capabilities

Frank Li (1):
      dt-bindings: can: fsl,flexcan: add i.MX94 support

Marc Kleine-Budde (1):
      Merge patch series "can: flexcan: add transceiver capabilities"

 .../devicetree/bindings/net/can/fsl,flexcan.yaml   | 13 +++++++++++
 drivers/net/can/flexcan/flexcan-core.c             | 27 +++++++++++++++++-----
 drivers/net/can/flexcan/flexcan.h                  |  1 +
 net/can/af_can.c                                   |  2 ++
 net/can/bcm.c                                      |  1 +
 net/can/isotp.c                                    |  1 +
 net/can/raw.c                                      |  5 +++-
 7 files changed, 43 insertions(+), 7 deletions(-)


