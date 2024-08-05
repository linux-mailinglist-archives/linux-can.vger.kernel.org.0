Return-Path: <linux-can+bounces-1114-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4967A947F3A
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80CD281D73
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 16:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20B715C15C;
	Mon,  5 Aug 2024 16:23:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D0015C130
	for <linux-can@vger.kernel.org>; Mon,  5 Aug 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875018; cv=none; b=iuuoQZUax0W6mnPAi3OJSFfNc5ooL00vzmpRqFvi9YV3lygTo54PvXgX3PHEgyE1l67luJzEgwPQ4i84J6b0Ef4ng/XRuwioxkD5cdIEwqC9+MR2fGlqDrFwczjS58NSg7aS4JdNf8f6wZSweSwTLsG+3uHWLGNBBsyT6rsUcho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875018; c=relaxed/simple;
	bh=t5VweJvAiI1Atb+P8Qzue+nMuwsy9UiQ90FuUMWC6OI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bWUG6p6iIzEg+Xmg1ftAN5+qJ1cwsFo5i1Co3ZFwbpTCT3MozE5jYQ/JA+JF2wl0CGTWycqEnCd9/xC4HMrIb9CmsclV34EV8ArIU38yfi1prCz5cn46cf2cA/gopFWyw1n9hYLZG2T98Ba5KgODOy5Mukjunbni7+gkNV9iUxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sb0Ug-00075A-TZ
	for linux-can@vger.kernel.org; Mon, 05 Aug 2024 18:23:34 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sb0Ug-004kl9-Bb
	for linux-can@vger.kernel.org; Mon, 05 Aug 2024 18:23:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 096463173DA
	for <linux-can@vger.kernel.org>; Mon, 05 Aug 2024 16:23:33 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C01D83173BF;
	Mon, 05 Aug 2024 16:23:31 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 652f6045;
	Mon, 5 Aug 2024 16:23:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/2] can: mcp251xfd: fix ring/coalescing configuration
Date: Mon, 05 Aug 2024 18:23:19 +0200
Message-Id: <20240805-mcp251xfd-fix-ringconfig-v1-0-72086f0ca5ee@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHf8sGYC/x2MQQqAMAzAviI9W5hlTvEr4kFmO3twygYiDP/u8
 BhIUiBzUs4wNQUS35r1jBW6tgG/rzEw6lYZyJA1g7F4+Iv67pENRR9MGoM/o2hAJ465FzeSJaj
 5lbga/3pe3vcDoDHquWoAAAA=
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=831; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=t5VweJvAiI1Atb+P8Qzue+nMuwsy9UiQ90FuUMWC6OI=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmsPx4vmESfWiSKGEf6XKF/xYiy2Av0eGdDkqeN
 RPDavu0fJuJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZrD8eAAKCRAoOKI+ei28
 b7U7B/0cnTYoiZ40DuJXWlKinwspYMxli2se56VYzwAL6K0M3HtNY1R0tSCt4og5LMgc2wP7ArJ
 BwcOZc3AWRlCOmF3wpzQ+x6uBgm2+HQDsPHulU4pPZ3HITtOx1++oi3gZmJR81DozUIeP8gnkd0
 WUrrOl4+TA8ItL+o2R2j46yruVd636uOf1k1X7T4T1BbN/I8RfOoOVeul7QpWcTxSEY2fh8qI7V
 CUbe/BLJctXeKNF82aB43T3OcQkvzwx8omfiwWYin9JiXSD2KsqN7KF8NLjxzf9KbDy0RcFXhSf
 enGx60zpUga4A5zHyOmtA6wi2OHdVLcpfjlLKETl2gdFH2uJ
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

When changing from CAN-CC to CAN-FD mode the ring and/or coalescing
parameters might be too big.

This series fixes the problem and adds a safeguard to detect broken
coalescing configuration.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (2):
      can: mcp251xfd: fix ring configuration when switching from CAN-CC to CAN-FD mode
      can: mcp251xfd: mcp251xfd_ring_init(): check TX-coalescing configuration

 drivers/net/can/spi/mcp251xfd/mcp251xfd-ram.c  | 11 ++++++++-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c | 34 +++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 7 deletions(-)
---
base-commit: 14ab4792ee120c022f276a7e4768f4dcb08f0cdd
change-id: 20240704-mcp251xfd-fix-ringconfig-6f6ee5f68242

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



