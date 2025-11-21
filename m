Return-Path: <linux-can+bounces-5543-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32782C77F42
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C406E3132B
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 08:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD533242A8;
	Fri, 21 Nov 2025 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="W0no6I8Q";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="8nHcmy03"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A052EF66A
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714088; cv=pass; b=aWxFLZ+xvdujFrbHNtLqHgJMvXuuFddjX1jpMNkcJQ2UgGmH53bhCUzCltJY1sBvfG0SoPSjaOQB7gjG9ABiVJ/SkBnxC1LOHcQvFPi4XwsirrUTKgueAQi7mdl3R0LjUHtzelekDSQuq0XBlXnaiXFOjXnzPnHjrZs92HONVKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714088; c=relaxed/simple;
	bh=g0lfyZNhG335IvmQveHIUwm/CB8KS2HIYGP96gBQ+fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAMnjE+agPI1J3E9vyM1Wrp9ZKFG9bcItNgycHKQ2cg8251ZoIAEoVK0kajWDafnh19gOAHv5+qpHVRfOYxo7JBHs4Qpx9e3Td+I+j1nIvjMnF8oyApETa4d9d4uSabfRpNHi/p5Lh/FagaloXYujHKGFasDDUSkFj8KgM+Mpkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=W0no6I8Q; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=8nHcmy03; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763714068; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LvITDB/VevaZXwBN/CrZQxDPevDuJMLbKmHbWdEDvbRRUWAAY4XlkNsN6cezEyj6Mc
    Ut3ndVzDw6yO5PZK0zjbHb8E61nXXG7IzfxjcF7BDbW95mBgTU0Y7Yy43+xjsH1eMf91
    73W2tTAH9oHi8ubrfI7BkCKluJcV1BgM2c8BHDf9ikrN6xU2qEjKj1oX/WpCWiJzjPFS
    icKDR60HZhdGlkKTpXbnNAk0jfYX0FqBsPRl9iNo97ljhGQgKjYmovgJgGdGxJfLQSth
    nmIshciv+H3fmPU2hs2JS5WV/XbfmlV7qv1Rfu2NWVAR9MRuZhfZrdaFyv2HpteJZPCG
    5kkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714068;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TURJq2H9MFaCwEfPVZt9g3ey+UxghSfaERaUiXXN+1M=;
    b=lK//s7K7GZONm8Pa6Ggjhxy2y+xa65zNu1uW9VR/iwHxmJlhSxTowaT8BZ2cEcNCT/
    c6Pzvb7OSm19eE8BK9u3rUd597kKgHRAi0w8QGyYYshAEaJ1L47WGkhfSGIM2eDPPFhU
    fQ+/DLJmHm6cmkKQ8apslGOk0EPIGyoUWeWCleKpos8ZGBPdC4OKwbi+jLjjWtzwZ18F
    APFBoUTxXx/s4wf2N/fKLnxVUnoutHZV14F7ctuf7dbuIIF93XqJrpwSBmlHOx2WqQqV
    fPUoolC5FYzaNLlBUL3X6rcAzoPn6qY7krgt+yzjUnGplUkKY1PtjjwzuP7Sjh+NZnOt
    pBhA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714068;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TURJq2H9MFaCwEfPVZt9g3ey+UxghSfaERaUiXXN+1M=;
    b=W0no6I8QEmYI3WQyaiBXE5iXpEzI03JUPMfxW2aWxscF4Gu0R5kQLMjS9AEE1JwY2i
    pBSyDRqDl01EEh5WSi7ubkQtcN+0+PJdkDOoe8YoeXN+bNjynt+yTd2B1AI4UImdpu8r
    40Fhs1ird9XjVyfZ83B2wCaE31xE7TiORmLNOnXJ1XqzbezAmJN7AfExz0IUnpiguywZ
    Td1vl+/i6BAh3czunWizXfqpnJNr7U7IfPouGg02UAZkq5H3oAe8W8o8vKJYLD6JR7iP
    I/UWQidt+M2PRCUGou3TAHIoJx2Bb4YRoTFr6eRc5qGrvJ+bHTMNhYzLVzyQWNPD742O
    1ABQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763714068;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=TURJq2H9MFaCwEfPVZt9g3ey+UxghSfaERaUiXXN+1M=;
    b=8nHcmy03rb/Am+O3UZ0zdjFad5xHGHLxAwsa+69XRtABPDLhDbkQVpzFSL+61+kHWs
    VTyvc4uY32O+Q42M/sAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL8YSAfs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 09:34:28 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v4 05/17] can: netlink: add CAN_CTRLMODE_XL_TMS flag
Date: Fri, 21 Nov 2025 09:34:02 +0100
Message-ID: <20251121083414.3642-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121083414.3642-1-socketcan@hartkopp.net>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Vincent Mailhol <mailhol@kernel.org>

The Transceiver Mode Switching (TMS) indicates whether the CAN XL
controller shall use the PWM or NRZ encoding during the data phase.

The term "transceiver mode switching" is used in both ISO 11898-1 and
CiA 612-2 (although only the latter one uses the abbreviation TMS). We
adopt the same naming convention here for consistency.

Add the CAN_CTRLMODE_XL_TMS flag to the list of the CAN control modes.

Add can_validate_xl_flags() to check the coherency of the TMS flag.
That function will be reused in upcoming changes to validate the other
CAN XL flags.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/dev.c        |  2 ++
 drivers/net/can/dev/netlink.c    | 48 ++++++++++++++++++++++++++++++--
 include/uapi/linux/can/netlink.h |  1 +
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 32f11db88295..1de5babcc4f3 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -121,10 +121,12 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
 		return "xl";
 	case CAN_CTRLMODE_XL_TDC_AUTO:
 		return "xl-tdc-auto";
 	case CAN_CTRLMODE_XL_TDC_MANUAL:
 		return "xl-tdc-manual";
+	case CAN_CTRLMODE_XL_TMS:
+		return "xl-tms";
 	default:
 		return "<unknown>";
 	}
 }
 EXPORT_SYMBOL_GPL(can_get_ctrlmode_str);
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 26c25e660e31..5a628c629109 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -179,10 +179,36 @@ static int can_validate_databittiming(struct nlattr *data[],
 		return err;
 
 	return 0;
 }
 
+static int can_validate_xl_flags(struct netlink_ext_ack *extack,
+				 u32 masked_flags, u32 mask)
+{
+	if (masked_flags & CAN_CTRLMODE_XL) {
+		if (masked_flags & CAN_CTRLMODE_XL_TMS) {
+			const u32 tms_conflicts_mask = CAN_CTRLMODE_FD |
+				CAN_CTRLMODE_XL_TDC_MASK;
+			u32 tms_conflicts = masked_flags & tms_conflicts_mask;
+
+			if (tms_conflicts) {
+				NL_SET_ERR_MSG_FMT(extack,
+						   "TMS and %s are mutually exclusive",
+						   can_get_ctrlmode_str(tms_conflicts));
+				return -EOPNOTSUPP;
+			}
+		}
+	} else {
+		if (mask & CAN_CTRLMODE_XL_TMS) {
+			NL_SET_ERR_MSG(extack, "TMS requires CAN XL");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
 	u32 flags = 0;
 	int err;
@@ -199,10 +225,14 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 		    (flags & CAN_CTRLMODE_RESTRICTED)) {
 			NL_SET_ERR_MSG(extack,
 				       "Listen-only and restricted modes are mutually exclusive");
 			return -EOPNOTSUPP;
 		}
+
+		err = can_validate_xl_flags(extack, flags, cm->mask);
+		if (err)
+			return err;
 	}
 
 	err = can_validate_bittiming(data, extack, IFLA_CAN_BITTIMING);
 	if (err)
 		return err;
@@ -224,11 +254,11 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 				   struct nlattr *data[],
 				   struct netlink_ext_ack *extack)
 {
 	struct can_priv *priv = netdev_priv(dev);
 	struct can_ctrlmode *cm;
-	u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing;
+	u32 ctrlstatic, maskedflags, deactivated, notsupp, ctrlstatic_missing;
 
 	if (!data[IFLA_CAN_CTRLMODE])
 		return 0;
 
 	/* Do not allow changing controller mode while running */
@@ -236,10 +266,11 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 		return -EBUSY;
 
 	cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 	ctrlstatic = can_get_static_ctrlmode(priv);
 	maskedflags = cm->flags & cm->mask;
+	deactivated = ~cm->flags & cm->mask;
 	notsupp = maskedflags & ~(priv->ctrlmode_supported | ctrlstatic);
 	ctrlstatic_missing = (maskedflags & ctrlstatic) ^ ctrlstatic;
 
 	if (notsupp) {
 		NL_SET_ERR_MSG_FMT(extack,
@@ -257,15 +288,25 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 				   "missing required %s static control mode",
 				   can_get_ctrlmode_str(ctrlstatic_missing));
 		return -EOPNOTSUPP;
 	}
 
+	/* If FD was active and is not turned off, check for XL conflicts */
+	if (priv->ctrlmode & CAN_CTRLMODE_FD & ~deactivated) {
+		if (maskedflags & CAN_CTRLMODE_XL_TMS) {
+			NL_SET_ERR_MSG(extack,
+				       "TMS can not be activated while CAN FD is on");
+			return -EOPNOTSUPP;
+		}
+	}
+
 	/* If a top dependency flag is provided, reset all its dependencies */
 	if (cm->mask & CAN_CTRLMODE_FD)
 		priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 	if (cm->mask & CAN_CTRLMODE_XL)
-		priv->ctrlmode &= ~(CAN_CTRLMODE_XL_TDC_MASK);
+		priv->ctrlmode &= ~(CAN_CTRLMODE_XL_TDC_MASK |
+				    CAN_CTRLMODE_XL_TMS);
 
 	/* clear bits to be modified and copy the flag values */
 	priv->ctrlmode &= ~cm->mask;
 	priv->ctrlmode |= maskedflags;
 
@@ -393,11 +434,12 @@ static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
 
 	memset(&dbt_params->tdc, 0, sizeof(dbt_params->tdc));
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 
-		need_tdc_calc = !(cm->mask & tdc_mask);
+		if (fd || !(priv->ctrlmode & CAN_CTRLMODE_XL_TMS))
+			need_tdc_calc = !(cm->mask & tdc_mask);
 	}
 	if (data_tdc) {
 		/* TDC parameters are provided: use them */
 		err = can_tdc_changelink(dbt_params, data_tdc, extack);
 		if (err) {
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index c2c96c5978a8..ebafb091d80f 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -105,10 +105,11 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
 #define CAN_CTRLMODE_RESTRICTED		0x800	/* Restricted operation mode */
 #define CAN_CTRLMODE_XL			0x1000	/* CAN XL mode */
 #define CAN_CTRLMODE_XL_TDC_AUTO	0x2000	/* XL transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_XL_TDC_MANUAL	0x4000	/* XL TDCV is manually set up by user */
+#define CAN_CTRLMODE_XL_TMS		0x8000	/* Transceiver Mode Switching */
 
 /*
  * CAN device statistics
  */
 struct can_device_stats {
-- 
2.47.3


