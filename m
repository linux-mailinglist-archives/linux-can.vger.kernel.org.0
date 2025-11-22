Return-Path: <linux-can+bounces-5595-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F1FC7CBF1
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 10:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D54D23476C7
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 09:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362C2D3217;
	Sat, 22 Nov 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Csw/uoJB";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="btWhTEM1"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA641E8826
	for <linux-can@vger.kernel.org>; Sat, 22 Nov 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763804184; cv=pass; b=RWPj8Fpdk26IFuMCXrCKsZdAcFTkuRIi6hVzJE9WxkyWpoODCKVH8MvfDgpabP1barFRagL+yKp+9m6ag2d5mQpyjk3Pd5NgRJaFOLSFjXHhI2snsGA+3CKAFIp9y/Jt0NHkcO0NZ7ejOEcyXPXN3q9BsttERs+GVx7ci1YX4V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763804184; c=relaxed/simple;
	bh=GLYw6DWDt3oePp+8a+BgZIKpOTOFAKzaaYW/2Fjfr0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqN36+gk/gfogTNCbw9IR3rLzs9n3jkIFG/vy70I1KfuxGlTtgQgGHPwrnbOi+ydeKXRPitg3xyFrvqMxu2NEY4KekmlxnKFJwg4NCDA1MfqrMqk0P+ehAa9upQVVRgBfbpmpeDTQTqlAN77pflJ5MSlM5xrykidicaH09zOqiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Csw/uoJB; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=btWhTEM1; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763804170; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mOz97YunR/oy3ZtCEh0aV9xG+0Pd7jpcf9mM45UjOvzaKWOtoIhiotgFud0evTe36M
    GtDMp5UqtYrkENwEdvI9zl3y5whxKHHzKeS3y+QMW1qQbPOGR6IIxrqnANp3JzW4d2Ed
    NBsIjTFsV6Qvo/b2QiswFKSiCQ7q5zgUe4PjSrwqt+EIrpGYR5O3EpDRJgp+Y+nWNIRR
    6Jm91vaPYnJb0ubSEzoVgBUt320yZFpCQxpr/b1paMGbZ1xH1AhOSO+1z4ELZNhNxb2x
    qpfylRX1i8TZAuXPbEkdNeCBcVaX4LcIwEcMKxGlYBnpUseKzkNIaB10p7vXAYux0hxh
    FOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804170;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tFwzf0H47txhVYqX1RnH/isA6GYuE7RxeqKNFJkbEsE=;
    b=hK3OAB3v/DdAgTAHSA+ME1spnM6wgCcrM7AvizbSoNzxdzL9CQX6XAnj0kmbsuMJjp
    vxbkeFt5+PXkNjMBOD8gVXOmakC60OudoXulYysUMDq6WYgcwuPY6e2O3j1QvHueZVaZ
    onvlyq9mIJPQKb+IzpGX+Z2xmMPXffL91C5R5EVHgLgaTp5XZmHElGiTQxgbvwG9LeuT
    w1h6LoZawQ7ZZa3CHeyQ6DJMrkqigZZW2nPVjJBF42eVJ1YEEQzwKgGbWDW9aiF+EGP6
    2e+zwtrcgr7Xz52hkrcFZkQFQst6exqNr0dtvPPoVyD3iiPs+Ak2k9i7mfTdquk3tx1p
    NVJQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804170;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tFwzf0H47txhVYqX1RnH/isA6GYuE7RxeqKNFJkbEsE=;
    b=Csw/uoJBcRLpAdtkYXYOqkH/uxz64Y5YJq3JUBtCneA2IhoEH67dSKfEs0ayOdd64n
    CegmxYrBrVQt8UyAry/0ADm4T0w/q6DJcBXCwl1yMsQJEIX01C7lNA7d9aVsD+QK0Bvp
    61J0+/UaPKSUeT0EDl5Jj0kSAI05Xrztj2qS2XtA0oBIpibxMmuZJTsQiAprqFGtVnCl
    1K22Q/rJaEwpJ8o/+KL51+vGUz1wZezzksW0W3zHyj8m+HMGpQOJ/BhNUL4qtaMSb4+I
    tCKbOw4VE4ZWcw46JxZzv6kMMG57+lbw16sYDt6gdFR68pHCBCrAfmNYzi1vdW3KM1ES
    nspQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763804170;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tFwzf0H47txhVYqX1RnH/isA6GYuE7RxeqKNFJkbEsE=;
    b=btWhTEM1eo2uXfR3LVQhUour9svY6LqDEeD2HwLLk9Akao2Mbj1tGj7dDl6/zWb2zh
    xs2bRhDHoc7oPq709tDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AM9aAFdq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 22 Nov 2025 10:36:10 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v6 06/17] can: netlink: add CAN_CTRLMODE_XL_TMS flag
Date: Sat, 22 Nov 2025 10:35:50 +0100
Message-ID: <20251122093602.1660-7-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122093602.1660-1-socketcan@hartkopp.net>
References: <20251122093602.1660-1-socketcan@hartkopp.net>
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
index dbc9b099b3f9..32db9f69844d 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -121,10 +121,12 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
 		return "XL";
 	case CAN_CTRLMODE_XL_TDC_AUTO:
 		return "XL-TDC-AUTO";
 	case CAN_CTRLMODE_XL_TDC_MANUAL:
 		return "XL-TDC-MANUAL";
+	case CAN_CTRLMODE_XL_TMS:
+		return "TMS";
 	default:
 		return "<unknown>";
 	}
 }
 EXPORT_SYMBOL_GPL(can_get_ctrlmode_str);
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index fdd1fa7cf93a..b2c24439abba 100644
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
 				       "LISTEN-ONLY and RESTRICTED modes are mutually exclusive");
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


