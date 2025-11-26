Return-Path: <linux-can+bounces-5674-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC442C89378
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABE914E3A30
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808072F616D;
	Wed, 26 Nov 2025 10:17:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49D1E5207
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152221; cv=none; b=nfDE/ziyFFbXWbVSp6mro2dLCQR0Z2ic4MQ/WT49uYgW28XHIX/3TTOXFRq62K3V+oX22T5xpCXYDooHuGtBrw0/+pmIxNFVrFPKPHtYrtGQpf+W0FjCGjhsy5Op7R+5xghhCLhjjhvbO/Yd6mfQQx2tONgkNVyDiU7OPbAfhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152221; c=relaxed/simple;
	bh=gM3SyOf9QU2wdFX7Be/+r0/qgWhSCapRqeMuixhfzmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lU5FGvX4FNVaG3uNE80ykWUFbDlMh+qAnbnCIPB0Sf8VlNE/kART0/r/EkndAXDTyIhlg4ERVsdClKPdIRKAnpBOm6SCYVFGWoHaH/pWKW2eMCingq8EF5vUMQSSiDygQ4hA7Ga2IWmkWPPN4lmK1TyE2YxE5dPoI6ydtlz6Eo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZv-0000Qg-7Z; Wed, 26 Nov 2025 11:16:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZu-002aSa-2p;
	Wed, 26 Nov 2025 11:16:50 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9B4FF4A88D2;
	Wed, 26 Nov 2025 10:16:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 26 Nov 2025 11:16:02 +0100
Subject: [PATCH can-next v8 01/17] can: dev: can_get_ctrlmode_str: use
 capitalized ctrlmode strings
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-canxl-v8-1-e7e3eb74f889@pengutronix.de>
References: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
In-Reply-To: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Stephane Grosjean <stephane.grosjean@hms-networks.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=rs0Pl7/UcgAVqu4AJjLmNogiVYwdJnmpuTL4w/fwyFQ=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpJtNzClLx8LW0G5XbQcpZItJaFjmQqJ64PH1jC
 M2U5tZgH+aJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaSbTcwAKCRAMdGXf+ZCR
 nCFuCACnmGgpQ1VjkXlmxoUbA2crbb4hbbVzJxjOfm1mvFlfpqQyF64WvDa7aY4p3756qP0942m
 Xx1XMo/AzzH6pNnVMge0nld6iTCrS1a6aCQ3bRDZ/MtPj1RmACD9m+G2yoLhGhP+SsmDkGyIqv7
 BgeMK/CnBQbO03cCVnHAzGP91ljnOeFWYbXnLJzxNoj6qmrEpRjWhjXbHf6wb1w5W/jmIuvfnCo
 muYTYv/DKgq/RNz2ms8AXcYQqkKH2b8U2v8MVRC0Io1SM8/TGHec5RD7XnysHSQuuGiVyA7QzbZ
 oiBkE3UmJAz0wRFlc+LrOSPUyIXgi65RBp/Mi8XsEvPnHZLU
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

Unify the ctrlmode related strings to the command line options of the
'ip' tool from the iproute2 package. The capitalized strings are also
shown when the detailed interface configuration is printed by 'ip'.

Suggested-by: Stephane Grosjean <stephane.grosjean@hms-networks.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 80e1ab18de87..b392483e4499 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -92,29 +92,29 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
 {
 	switch (ctrlmode & ~(ctrlmode - 1)) {
 	case 0:
-		return "none";
+		return "(none)";
 	case CAN_CTRLMODE_LOOPBACK:
-		return "loopback";
+		return "LOOPBACK";
 	case CAN_CTRLMODE_LISTENONLY:
-		return "listen-only";
+		return "LISTEN-ONLY";
 	case CAN_CTRLMODE_3_SAMPLES:
-		return "triple-sampling";
+		return "TRIPLE-SAMPLING";
 	case CAN_CTRLMODE_ONE_SHOT:
-		return "one-shot";
+		return "ONE-SHOT";
 	case CAN_CTRLMODE_BERR_REPORTING:
-		return "berr-reporting";
+		return "BERR-REPORTING";
 	case CAN_CTRLMODE_FD:
-		return "fd";
+		return "FD";
 	case CAN_CTRLMODE_PRESUME_ACK:
-		return "presume-ack";
+		return "PRESUME-ACK";
 	case CAN_CTRLMODE_FD_NON_ISO:
-		return "fd-non-iso";
+		return "FD-NON-ISO";
 	case CAN_CTRLMODE_CC_LEN8_DLC:
-		return "cc-len8-dlc";
+		return "CC-LEN8-DLC";
 	case CAN_CTRLMODE_TDC_AUTO:
-		return "fd-tdc-auto";
+		return "TDC-AUTO";
 	case CAN_CTRLMODE_TDC_MANUAL:
-		return "fd-tdc-manual";
+		return "TDC-MANUAL";
 	default:
 		return "<unknown>";
 	}

-- 
2.51.0


