Return-Path: <linux-can+bounces-328-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D9B85B5FB
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 09:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1DBDB25303
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 08:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E992360EC4;
	Tue, 20 Feb 2024 08:51:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293A05FBA6
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419100; cv=none; b=eCrCRaMkLmiYwbq+cVXZ1uqO5oome7Sy1eq9mNbeMSQw3ZAwSwX8bp2n7KyUdyk+/sYSixD3wQGht4d+KsayRo5E2vTq2G1RIROpRzOtSBdMUxQbLsKlgJh2rT7h0wopUahkbA+VvKMbUQEg1jFhy8ah5VG+bvVs27RXb33x5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419100; c=relaxed/simple;
	bh=cr9pu0Y40a2Aj9Fchr7Df/NvPcjKmNiG6/bLaIexty4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAleAruILyMmxi3eC530wJhuYLs+Gs+ZdraIlIrPyMsJ3YcpmNbbvFy8ANE/iVz7KrkO3/MjGFJMBagMrXNoiSgXoEd5E1prU9Kr+q0r6DgtdeMLTy1vWm77SgtGT9fwRwdT9bNwFc4bJP3xvlRAs6CvjEawUrSEfZp0mjdXiIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqj-0001i0-4p
	for linux-can@vger.kernel.org; Tue, 20 Feb 2024 09:51:37 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqi-001oGU-2e
	for linux-can@vger.kernel.org; Tue, 20 Feb 2024 09:51:36 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id BFC39292F2D
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 08:51:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 14BB6292EF0;
	Tue, 20 Feb 2024 08:51:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e49f5aff;
	Tue, 20 Feb 2024 08:51:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Simon Horman <horms@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 8/9] can: raw: fix getsockopt() for new CAN_RAW_XL_VCID_OPTS
Date: Tue, 20 Feb 2024 09:46:10 +0100
Message-ID: <20240220085130.2936533-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220085130.2936533-1-mkl@pengutronix.de>
References: <20240220085130.2936533-1-mkl@pengutronix.de>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

The code for the CAN_RAW_XL_VCID_OPTS getsockopt() was incompletely adopted
from the CAN_RAW_FILTER getsockopt().

Add the missing put_user() and return statements.

Flagged by Smatch.

Fixes: c83c22ec1493 ("can: canxl: add virtual CAN network identifier support")
Reported-by: Simon Horman <horms@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/all/20240219200021.12113-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index cb8e6f788af8..897ffc17d850 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -835,7 +835,9 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 			if (copy_to_user(optval, &ro->raw_vcid_opts, len))
 				err = -EFAULT;
 		}
-		break;
+		if (!err)
+			err = put_user(len, optlen);
+		return err;
 
 	case CAN_RAW_JOIN_FILTERS:
 		if (len > sizeof(int))
-- 
2.43.0



