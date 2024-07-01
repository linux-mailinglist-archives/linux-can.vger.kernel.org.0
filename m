Return-Path: <linux-can+bounces-915-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DA091D9A1
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 10:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37D6284CC7
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 08:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F681723;
	Mon,  1 Jul 2024 08:06:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223FE7D08D
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821215; cv=none; b=jXFZNq3gkCQzFhda4WbChc1GtvENYPp8FYfcvQDTqdNRAvqNudBdOz5nZKvhsHgJfF9HvjWupcICTZo6fLrfGrYLWmO9FeHo17NbPu2BLcwgMzjM5PgOBt8oQel0taGzNfvR1UB5AHSOUJQj2BlFARXF7SKGpPoTR/hrOGEMyZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821215; c=relaxed/simple;
	bh=qHArqbNYlXaBcr5ma4KWcFFp3nH2lHPUG2fCdNxhQoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5oXqcOTPtskElhJlmorPX/dPJchJ6cO2C2fDIgArTEyz6r///VbJTfB1M9ljd7n8eeoE+uJAnLzwq0OLncV/CfNmVZB6qWOTc7JTVHC70MHPlI0OqCXYEXt2UtZHg2P+OOBMaOD5NWibZSuCkpNr1NdZ/7rOTd5X550j0+Im50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sOC3k-0002lM-Gc
	for linux-can@vger.kernel.org; Mon, 01 Jul 2024 10:06:48 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sOC3k-006KC2-3l
	for linux-can@vger.kernel.org; Mon, 01 Jul 2024 10:06:48 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C3D4E2F7191
	for <linux-can@vger.kernel.org>; Mon, 01 Jul 2024 08:06:47 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id EB5932F7189;
	Mon, 01 Jul 2024 08:06:46 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ef2aa0a2;
	Mon, 1 Jul 2024 08:06:46 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/1] pull-request: can 2024-07-01
Date: Mon,  1 Jul 2024 10:03:21 +0200
Message-ID: <20240701080643.1354022-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
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

this is a pull request of 1 patch for net/master.

Jimmy Assarsson's patch for the kvaser_usb adds a missing explicit
initialization of the struct kvaser_usb_driver_info::family for the
kvaser_usb_driver_info_leafimx.

regards,
Marc

---
The following changes since commit 134061163ee5ca4759de5c24ca3bd71608891ba7:

  bnx2x: Fix multiple UBSAN array-index-out-of-bounds (2024-06-28 18:19:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.10-20240701

for you to fetch changes up to 19d5b2698c35b2132a355c67b4d429053804f8cc:

  can: kvaser_usb: Explicitly initialize family in leafimx driver_info struct (2024-07-01 08:55:16 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.10-20240701

----------------------------------------------------------------
Jimmy Assarsson (1):
      can: kvaser_usb: Explicitly initialize family in leafimx driver_info struct

 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 1 +
 1 file changed, 1 insertion(+)


