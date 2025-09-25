Return-Path: <linux-can+bounces-5017-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9FAB9F21C
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB13D327327
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E2F302CAC;
	Thu, 25 Sep 2025 12:14:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23973009E7
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802448; cv=none; b=Rp8bt32IwfIn9Arbf5ljZSiH5zdG89/0FgctnBIYmSKozEv4T6pEOqH+V03l+P53HiaKvbayoWkJsxazjch1zcBwtpT027YI4zmoYlL2X4SEFpDfy6+pMsNkXnC1+RQHjyYLBOuqh+2IBK4hSCUuQx0VPwbgPDQZqhZ6ZbX6wt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802448; c=relaxed/simple;
	bh=1hMgtbcpCIHT85BZOKOYvog0eBg6GGoFYXVxqO9eXqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMGgRYGVr1I014EbVVAkm0EkhFOU4iZ7PM3RZhbfxzzIr8p8V3wL/PXNakP98nR1lj3t/C++WAaCcrY5yasqAuIeR9iTtoU8onXbx9xDXEh8M1q/56gVtxiMCnQUIcDCTfa05JY2gdnp8OfWu7h+LLS3+iYQmCsog6fCtMbHMzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqx-0000Yi-4I; Thu, 25 Sep 2025 14:13:39 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqv-000Px0-1Q;
	Thu, 25 Sep 2025 14:13:37 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 35B8B479990;
	Thu, 25 Sep 2025 12:13:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 36/48] can: netlink: remove useless check in can_tdc_changelink()
Date: Thu, 25 Sep 2025 14:08:13 +0200
Message-ID: <20250925121332.848157-37-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925121332.848157-1-mkl@pengutronix.de>
References: <20250925121332.848157-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol@kernel.org>

can_tdc_changelink() return -EOPNOTSUPP under this condition:

  !tdc_const || !can_fd_tdc_is_enabled(priv)

But this function is only called if the data[IFLA_CAN_TDC] parameters
are provided. At this point, can_validate_tdc() already checked that
either of the tdc auto or tdc manual control modes were provided, that
is to say, can_fd_tdc_is_enabled(priv) must be true.

Because the right hand operand of this condition is always true,
remove it.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-8-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index c212c7ff26cd..17ed52d238e3 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -180,7 +180,7 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
 	int err;
 
-	if (!tdc_const || !can_fd_tdc_is_enabled(priv))
+	if (!tdc_const)
 		return -EOPNOTSUPP;
 
 	err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX, nla,
-- 
2.51.0


