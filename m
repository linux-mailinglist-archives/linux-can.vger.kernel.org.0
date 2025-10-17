Return-Path: <linux-can+bounces-5206-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B233BBE97BD
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 17:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF183A8AC5
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FD92F12BE;
	Fri, 17 Oct 2025 15:00:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EB923EABB
	for <linux-can@vger.kernel.org>; Fri, 17 Oct 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713237; cv=none; b=cQ5UTkFsWOHTpi1eWs3EvIo88b326tQ3vjh8c1iYr0X7ZLPtj6TKUNa+j79CE4hRUolbaOktN0W1s5KHmJJO9oCouOwG2F5n65YEK/sc6LL8cz1TEQntvmY9jl8UxQfs2BzLGKrfoH/jEzbQ20sRK2MUmONJ2Cr83zwbO1qUZ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713237; c=relaxed/simple;
	bh=pWc9HZbLPbfcSCrgHFOQpUP27TzOtZyl/WElcU1OSLE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W7/nFh05xRYw9ipOPKLBZXPefo+qLYnqySZqsjclBjWCS0pbPxainhuSEW3eVLQw86QmMR2i/5ATiwgnCVpLITCj574HgGUJ5Hq1dNLRGoQKH8PJC4GmbpwlnMEdtdchIcvBimzrnPkj3fphSihbDvUFozRZCItep5M8cje+gpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9lwJ-00028C-Pd; Fri, 17 Oct 2025 17:00:19 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9lwI-0044jW-2y;
	Fri, 17 Oct 2025 17:00:18 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8DCD8489288;
	Fri, 17 Oct 2025 15:00:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can 0/3] can: drivers: drop skb in xmit if device is in
 listen only mode
Date: Fri, 17 Oct 2025 16:59:58 +0200
Message-Id: <20251017-fix-skb-drop-check-v1-0-556665793fa4@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO5Z8mgC/x2MWwqAIBAArxL73UJWVnSV6MPHlotgoRCBePekz
 4GZyZAoMiVYmwyRHk58hQqibcA4FU5CtpWh73opOjHjwS8mr9HG60bjyHiUVolRy0VOwwg1vCN
 V659uYFSAvZQPGY2K2mkAAAA=
X-Change-ID: 20251017-fix-skb-drop-check-5da14b585634
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 =?utf-8?q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>, socketcan@esd.eu, 
 Heiko Stuebner <heiko@sntech.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-2196b
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=pWc9HZbLPbfcSCrgHFOQpUP27TzOtZyl/WElcU1OSLE=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo8ln6myT9qBOPNmTPcBHzX2BueVmxUrp6rx6VN
 CA77ZyrQ3OJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaPJZ+gAKCRAMdGXf+ZCR
 nCZEB/96b7TNVi+j7RI9FP0tDmjKZgiS1RBQZMmfkPW68pgASoz4UZcKgYDTpUGwB+p3BEAcy0e
 hFHSIoLf/S1LsSJFzejD9TXrvSTlQ99ZzPJIaZ2UUpY9rPd9zmn5ROaF6TdVEre5p+/tPVpSzyI
 p3+yo52xskYjA28LPTv1+ByW94+IwR1qwf4Awd3eBsk7vF2JYr6fmBJZ9OD8QCJ5UAmdU+ggnmt
 o5wrCvC36VewAfHVbzFSuH8wmfzX5eafwLOom787d4kmFArucbo/eLNBA/t3StVhY+3qp/W3sE4
 SrcF7l5fgMEP+5QsJ0/T8sopsA42gd/tAsS2HzQUkAIfukOh
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

I notived that 3 drivers (bxcan, esd and rockchip) use the function
can_dropped_invalid_skb(), that doesn't check if the device is in listen
only mode. This series converts these driver to use the new
can_dev_dropped_skb() function.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (3):
      can: bxcan: bxcan_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      can: esd: acc_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      can: rockchip-canfd: rkcanfd_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()

 drivers/net/can/bxcan.c                      | 2 +-
 drivers/net/can/esd/esdacc.c                 | 2 +-
 drivers/net/can/rockchip/rockchip_canfd-tx.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 7e0d4c111369ed385ec4aaa6c9c78c46efda54d0
change-id: 20251017-fix-skb-drop-check-5da14b585634

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


