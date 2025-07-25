Return-Path: <linux-can+bounces-4121-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171AEB11C19
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B265A24EF
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC4A2E040C;
	Fri, 25 Jul 2025 10:16:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F82E06D2
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438586; cv=none; b=j6S3hCBZbgpFDf72xNPOAdg+jfPeE3FBGAmvzF4CMkz/vSNGlBIODmbxeHyW7UYCS7oGvGedEkF8wm6mmhtQCqdgAAzGkh5Q8RfAmt8azoSF5gnHy9VGhEkdFdaxy2wP+hgYWFCjdHNNaGaCmJSSQiwNu4veebGEjt6d2wGjUHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438586; c=relaxed/simple;
	bh=XfLiIJP+lNbTHHUZoH9kSblj58GrrbRlOO2gsVGCJJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGT5L+1UCnDLyEg7hW03m6C1fFRQ5eLdnYXQXmi4EpJJX/8WReWZVWCcxmeaHC0TShctLvQN2SSTXSGQ7oHspdW74kqN1Fvc00gxvJ/kmR9iGAUmiVZvqVuBRVCGYBQTYpcIyQfCjBR3dNcqsRM35dFOXHsGBvi13IIdl8NcnR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufFTS-0006N0-8X
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 12:16:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufFTS-00ACa1-09
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 12:16:22 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id BC9C04493C0
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 10:16:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id DC64F4493B7;
	Fri, 25 Jul 2025 10:16:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 17066578;
	Fri, 25 Jul 2025 10:16:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/1] pull-request: can 2025-07-25
Date: Fri, 25 Jul 2025 12:13:48 +0200
Message-ID: <20250725101619.4095105-1-mkl@pengutronix.de>
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

this is a pull request of 1 patch for net/main.

The patch is by Stephane Grosjean and adds support the recent firmware
of USB CAN FD interfaces to the peak_usb driver.

regards,
Marc

---

The following changes since commit c8f13134349b4385ae739f1efe403d5d3949ef92:

  Merge branch 'selftests-drv-net-tso-fix-issues-with-tso-selftest' (2025-07-24 18:55:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.16-20250725

for you to fetch changes up to 788199b73b6efe4ee2ade4d7457b50bb45493488:

  can: peak_usb: fix USB FD devices potential malfunction (2025-07-25 12:09:19 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.16-20250725

----------------------------------------------------------------
Stephane Grosjean (1):
      can: peak_usb: fix USB FD devices potential malfunction

 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)


