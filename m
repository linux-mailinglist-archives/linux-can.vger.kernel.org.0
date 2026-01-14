Return-Path: <linux-can+bounces-6136-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C84ED1E469
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 12:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99D5B3005E92
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 10:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF81304BCB;
	Wed, 14 Jan 2026 10:54:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA62D396D09
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388043; cv=none; b=BjE/vIQr5wE7hQWY7n17+qF1RzFTQjx2UzyV2iSTQ2e4+8thhWQuQ+9xDK1aGmnv4vigmWpwJKEffHFs2KHDsbHiJLU+HxgD63YcXfXgD5AIVPtPwYwWqLzLPDolSV6mmkXEKQvKIhKsqz0xInZm0NT0IQ0uqnmiyaMhBMzt7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388043; c=relaxed/simple;
	bh=xslTz0QAsrjmjJhCdA2M85qhDLJ1vcw6JdsnlpToTE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HuxySo1ENe2/L4xxZe0wZ9K5K1HRk0Ft1nXqlLw58rHG52S+hSXc7vF6RTshgSNYkHaej8GaYctu+girA2mIvWR2jYGx+pE37BE+en+idl1L3KHRBSzflwTwjDUzjpgYLvYC3ZRUeb62NgzGYzaNI/3HqejGXhoYNxtptOn7frA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfyU4-0006p1-3t; Wed, 14 Jan 2026 11:52:16 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfyU4-000Zeu-0a;
	Wed, 14 Jan 2026 11:52:15 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 45B3A4CCB67;
	Wed, 14 Jan 2026 10:52:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/4] pull-request: can 2026-01-14
Date: Wed, 14 Jan 2026 11:44:59 +0100
Message-ID: <20260114105212.1034554-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
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

this is a pull request of 4 patches for net/main.

The first 3 patches are by Oliver Hartkopp and revert the approach to
instantly reject unsupported CAN frames introduced in
net-next-for-v6.19 and replace it by placing the needed data into the
CAN specific ml_priv.

The last patch is by Tetsuo Handa and fixes a J1939 refcount leak for
j1939_session in session deactivation upon receiving the second RTS.

regards,
Marc

---

The following changes since commit e707c591a139d1bfa4ddc83036fc820ca006a140:

  can: ctucanfd: fix SSP_SRC in cases when bit-rate is higher than 1 MBit. (2026-01-09 14:26:29 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.19-20260114

for you to fetch changes up to 426c303c80c2cc220d1477c6ea63bbb183cabd77:

  net: can: j1939: j1939_xtp_rx_rts_session_active(): deactivate session upon receiving the second rts (2026-01-14 11:36:58 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.19-20260114

----------------------------------------------------------------
Marc Kleine-Budde (1):
      Merge patch series "can: raw: better approach to instantly reject unsupported CAN frames"

Oliver Hartkopp (3):
      Revert "can: raw: instantly reject unsupported CAN frames"
      can: propagate CAN device capabilities via ml_priv
      can: raw: instantly reject disabled CAN frames

Tetsuo Handa (1):
      net: can: j1939: j1939_xtp_rx_rts_session_active(): deactivate session upon receiving the second rts

 drivers/net/can/Kconfig       |  7 +++++--
 drivers/net/can/Makefile      |  2 +-
 drivers/net/can/dev/Makefile  |  5 +++--
 drivers/net/can/dev/dev.c     | 27 ++++++++++++++++++++++++
 drivers/net/can/dev/netlink.c |  1 +
 drivers/net/can/vcan.c        | 15 +++++++++++++
 drivers/net/can/vxcan.c       | 15 +++++++++++++
 include/linux/can/can-ml.h    | 24 +++++++++++++++++++++
 include/linux/can/dev.h       |  8 +------
 net/can/j1939/transport.c     | 10 ++++++++-
 net/can/raw.c                 | 49 +++++++------------------------------------
 11 files changed, 109 insertions(+), 54 deletions(-)

