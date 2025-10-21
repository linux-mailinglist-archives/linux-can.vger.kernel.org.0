Return-Path: <linux-can+bounces-5255-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B74DBF77C5
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 17:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F96119A822C
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 15:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B996C34677D;
	Tue, 21 Oct 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fv9gMyIn"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084B346777;
	Tue, 21 Oct 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061679; cv=none; b=PrhFVoR8oRBLd2M9HyFXg6MOgeld96X+/Vk3Rl1K7R+AEMrwL3YJ1zazt5yNsCdrhV/kvjzLsN5NXlRRciYl4x73txuDx18JXUFf/E5l8ZXiUDBk22CNMCPrXPcJOQZWE4xQi8oYhWM0zOyhhcTbCo9zmwwwKG/490AuxyW9J+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061679; c=relaxed/simple;
	bh=98gYOgiiHJ0nKbOHOeoQpgkidZg0DRmEDM+Th+DWzcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jcjFKUbj/Pd6n1kJj40loGlTmpFYSbMx6yi+uL2kMCpGXa40/JBGptkMZNSEL4hk2x4IgHwsaq5xVflnULG/l0p4jJvtqQlE/kQPG+PE+8o/1X+ExIYnfrUQPmuh+AiFQ7ZPJvsc7ED3x90/t+4yfn/9db2VDFJwjKqsPVBmaXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fv9gMyIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2262C4CEF1;
	Tue, 21 Oct 2025 15:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761061679;
	bh=98gYOgiiHJ0nKbOHOeoQpgkidZg0DRmEDM+Th+DWzcM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fv9gMyInBRvVirCn/sd9GLcmIimu3h86EHdK1zk31uaRmNPEyAKcvpNkzoMTQn1mB
	 8LBeQJGYQJTDGR1s2/qo6jrQs5vNGlh4S8KTntAZUs8uySzYvC+5gzhvQrVMihaFvP
	 +lribjxFfj2ySsGcr/Y6dJB6/yB0ycBteY3Nmrqwo6+C/GA1KBKD9f9R+dE9nO5A9R
	 2lDDeduMxJiOvW3j4dyboS0jypqnQc11bS2Cf7lPlwjLeO+B92jKiQ2MruVvR5ZMET
	 feHESJ7XOHLBfq3LR/5fHGZL7GkZA6bt5ljbhxggpLO4u5AUyr7L+XjdaXiEYyb6qw
	 qu5oWsB8VIRPQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 21 Oct 2025 17:47:06 +0200
Subject: [PATCH v2 06/10] can: netlink: add CAN_CTRLMODE_XL_ERR_SIGNAL
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-canxl-netlink-v2-6-8b8f58257ab6@kernel.org>
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
In-Reply-To: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5152; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=98gYOgiiHJ0nKbOHOeoQpgkidZg0DRmEDM+Th+DWzcM=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnfVwtJGbxb7+9ofaNjueTtnjdVoudW1lbzFcQ82NHGu
 y1SQkq4o5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwEQ4PBj+OzhYX5/sLXPn4D8/
 BqOTVldq5u1abP+tjk2nXv7RmeC9eowMZ3Ujz3N8nrxwb8vCZbHO90K010uc4uD8IqoxdfmSxEv
 WjAA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Classical CAN and CAN FD must generate error frames on the CAN bus
when detecting a protocol violation.

CAN XL's error signaling is different and works as follows:

  - In interoperability mode (both FD and XL), error signaling must be
    on.

  - When operating a CAN controller in CAN XL only mode but with TMS
    off, the user can decide whether the error signalling is enabled
    or disabled.

  - On the contrary, when using TMS, error signalling must be off.

Introduce the new CAN_CTRLMODE_XL_ERR_SIGNAL control mode. This new
option is only made available for CAN XL, so despite the error
signalling being always on for Classical CAN and CAN FD, forbid the
use of this flag when CAN XL is off.

If the user provides the error signalling flag, check its validity. If
the flag is omitted, activate error signalling by default whenever
possible. This is summarized in below table:

			CAN_CTRLMODE_XL_ERR_SIGNAL
	-------------------------------------------
	CC/FD		option not available
	CC/FD/XL	on
	XL TMS off	configurable (default on)
	XL TMS on	off

Suggested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/linux-can/20250527195625.65252-9-socketcan@hartkopp.net/
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/dev.c        |  2 ++
 drivers/net/can/dev/netlink.c    | 29 +++++++++++++++++++++++++++--
 include/uapi/linux/can/netlink.h |  1 +
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 1de5babcc4f3..0c16d0174f7f 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -125,6 +125,8 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
 		return "xl-tdc-manual";
 	case CAN_CTRLMODE_XL_TMS:
 		return "xl-tms";
+	case CAN_CTRLMODE_XL_ERR_SIGNAL:
+		return "xl-error-signalling";
 	default:
 		return "<unknown>";
 	}
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 8afd2baa03cf..6126b191fea0 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -191,7 +191,8 @@ static int can_validate_xl_flags(struct netlink_ext_ack *extack,
 		}
 		if (masked_flags & CAN_CTRLMODE_XL_TMS) {
 			const u32 tms_conflicts_mask = CAN_CTRLMODE_FD |
-				CAN_CTRLMODE_XL_TDC_MASK;
+				CAN_CTRLMODE_XL_TDC_MASK |
+				CAN_CTRLMODE_XL_ERR_SIGNAL;
 			u32 tms_conflicts = masked_flags & tms_conflicts_mask;
 
 			if (tms_conflicts) {
@@ -201,11 +202,23 @@ static int can_validate_xl_flags(struct netlink_ext_ack *extack,
 				return -EOPNOTSUPP;
 			}
 		}
+		if ((masked_flags & CAN_CTRLMODE_FD) &&
+		    (mask & CAN_CTRLMODE_XL_ERR_SIGNAL) &&
+		    !(masked_flags & CAN_CTRLMODE_XL_ERR_SIGNAL)) {
+			NL_SET_ERR_MSG(extack,
+				       "When using both CAN FD and XL, error signalling must be on");
+			return -EOPNOTSUPP;
+		}
 	} else {
 		if (mask & CAN_CTRLMODE_XL_TMS) {
 			NL_SET_ERR_MSG(extack, "TMS requires CAN XL");
 			return -EOPNOTSUPP;
 		}
+		if (mask & CAN_CTRLMODE_XL_ERR_SIGNAL) {
+			NL_SET_ERR_MSG(extack,
+				       "Error signalling is only configurable with CAN XL");
+			return -EOPNOTSUPP;
+		}
 	}
 
 	return 0;
@@ -310,6 +323,11 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 				       "TMS can not be activated while CAN FD is on");
 			return -EOPNOTSUPP;
 		}
+		if (deactivated & CAN_CTRLMODE_XL_ERR_SIGNAL) {
+			NL_SET_ERR_MSG(extack,
+				       "Error signalling can not be deactivated while CAN FD is on");
+			return -EOPNOTSUPP;
+		}
 	}
 
 	/* If a top dependency flag is provided, reset all its dependencies */
@@ -317,12 +335,19 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 		priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 	if (cm->mask & CAN_CTRLMODE_XL)
 		priv->ctrlmode &= ~(CAN_CTRLMODE_XL_TDC_MASK |
-				    CAN_CTRLMODE_XL_TMS);
+				    CAN_CTRLMODE_XL_TMS |
+				    CAN_CTRLMODE_XL_ERR_SIGNAL);
 
 	/* clear bits to be modified and copy the flag values */
 	priv->ctrlmode &= ~cm->mask;
 	priv->ctrlmode |= maskedflags;
 
+	/* If omitted, set error signalling on if possible */
+	if ((maskedflags & CAN_CTRLMODE_XL) &&
+	    !(cm->mask & CAN_CTRLMODE_XL_ERR_SIGNAL) &&
+	    !(priv->ctrlmode & CAN_CTRLMODE_XL_TMS))
+		priv->ctrlmode |= CAN_CTRLMODE_XL_ERR_SIGNAL;
+
 	/* Wipe potential leftovers from previous CAN FD/XL config */
 	if (!(priv->ctrlmode & CAN_CTRLMODE_FD)) {
 		memset(&priv->fd.data_bittiming, 0,
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index ebafb091d80f..30d446921dc4 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -108,6 +108,7 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_XL_TDC_AUTO	0x2000	/* XL transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_XL_TDC_MANUAL	0x4000	/* XL TDCV is manually set up by user */
 #define CAN_CTRLMODE_XL_TMS		0x8000	/* Transceiver Mode Switching */
+#define CAN_CTRLMODE_XL_ERR_SIGNAL	0x10000	/* XL error signalling */
 
 /*
  * CAN device statistics

-- 
2.51.0


