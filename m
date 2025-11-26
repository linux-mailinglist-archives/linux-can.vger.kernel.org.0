Return-Path: <linux-can+bounces-5676-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C8BC8937B
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39186350833
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342181A23B9;
	Wed, 26 Nov 2025 10:17:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3447823AB88
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152222; cv=none; b=YuoDL0Q5A7WanPMYmZbOtou8xHGfeLv3iurFtVj3VfsvOx6Dwj1xe9Yoe2ukhvPtrCl47xGQjv2sB4vdW+plRK5YUBbMGt67N/+l3G0X5QhVgSd21IJe8T6yTvz/cWium0IAgjkdLrsjFLWtm8IldfqODiSiHTAGl4SJejWjApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152222; c=relaxed/simple;
	bh=XbwD81IF2hWlAqj8+XiP5Jch3xUbg5Ot/2nn03qkwCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qv7hwroIaI4q05ggBn6Hr5AHFTmYgyoPh849A19PNjozoG1CDeBPCURTrI9OJ5ynj+qPkkTttS8KP5+Wj9/fiTwMku/qtrRYmpLFp0X3SN9rpDWBeurebR1e4Y2m7FtBiEf8LBTuaivw9jeE21Hz3B4tA8+s06dhc+GMHDXy89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZv-0000Qh-7Z; Wed, 26 Nov 2025 11:16:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZu-002aSb-2v;
	Wed, 26 Nov 2025 11:16:50 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A45904A88D3;
	Wed, 26 Nov 2025 10:16:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 26 Nov 2025 11:16:03 +0100
Subject: [PATCH can-next v8 02/17] can: bittiming: apply NL_SET_ERR_MSG()
 to can_calc_bittiming()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-canxl-v8-2-e7e3eb74f889@pengutronix.de>
References: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
In-Reply-To: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=v8m7nKBeI46RR6uNXm/Tz3YaMp4YiXOun4vKbbogbgs=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpJtN1rO+4rE424E9mGwz6GVizQHeA8QyjObr5F
 dC1IHgLL8WJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaSbTdQAKCRAMdGXf+ZCR
 nIpdB/9N3sYGeTP/fPZ6UmcnqgjFU4Xsa+gMx+08FgPAEi+NXjw1WLTWM9cBBVBovKFUAR6003j
 vGHDmIut+FMTS06I/LVoGWnKv0dv+oEZo99IA9a2UDWOtmbMaQEHlkyIbQ0qNxP1KgID02qk9pU
 ZdzW2h8irgPB+v8hUxQJeuJeZH6wY4sVc61mRWwtCOmrPJDv0ZsEMQegEqoVxnN8qa6ZNlbdGuZ
 V+kC4HkWtIzCUkfKwYlk6hDJ+7Yw949faiEcnvdVeLgYeJBfipUYu9M0+Z/kFERESbcVlYgBlkQ
 IA903wwq1Rc6HoF2kNjeTz+KDd+gjj8+Jb7ewp65J4hquyV2
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol@kernel.org>

When CONFIG_CAN_CALC_BITTIMING is disabled, the can_calc_bittiming()
functions can not be used and the user needs to provide all the
bittiming parameters.

Currently, can_calc_bittiming() prints an error message to the kernel
log. Instead use NL_SET_ERR_MSG() to make it return the error message
through the netlink interface so that the user can directly see it.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/bittiming.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index d30816dd93c7..3926c78b2222 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -141,7 +141,7 @@ static inline int
 can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		   const struct can_bittiming_const *btc, struct netlink_ext_ack *extack)
 {
-	netdev_err(dev, "bit-timing calculation not available\n");
+	NL_SET_ERR_MSG(extack, "bit-timing calculation not available\n");
 	return -EINVAL;
 }
 

-- 
2.51.0


