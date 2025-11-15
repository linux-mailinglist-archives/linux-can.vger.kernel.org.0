Return-Path: <linux-can+bounces-5429-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA063C608BC
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 17:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A7FA4E84C1
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 16:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06552FF644;
	Sat, 15 Nov 2025 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bHn/Nro0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Ky9A3VCQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A132FD68C
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224683; cv=pass; b=e6aoGcgSY5zGFUIvpRR/kxc2FKerid6u7y7RLkvvKb25TpLs875EiWZ/20fLE32/3tCzSa3a2oCsT56BsWcgTipVvd+qMuZHpJb8Vr1m4hg6JsvMxjnTMD1XPWXrmhabFg9wNJA6prW33qdsTbMNU6I0JSHL7yhvHPunzarXUB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224683; c=relaxed/simple;
	bh=aNspXQiZIzxG/kECI/BQvFm4gChcnuBouj+OolO50DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2KOnPkuqEtbpI2yutGxBgQp/+o+Ap4PBi0Cv7e+CaZikef85oM46xaWLFDqUWk5Yhx1du4PEITwW5ZTYVECHAzHiKCWd6GgNjRCCpNlgBxtg9c8MZce23iMlYQRqR+cWSC7LwlxtSDABzrqQgDlwYW7PJ+ST5yYPDQMFX0zfFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bHn/Nro0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Ky9A3VCQ; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763224674; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=N2SpIth7PsHY3WxqpC/z2m2Ao+T1w6X8f5BU1z2Df+WGxJhHgZGRHwL1dQUKp3F+JG
    7liD3vGBBwWVmv0N0ZHyU2INyk5ezYGlbDt1U9ukCAETzBX6qT9H7IO3JF5VnW0TY0Em
    tg6eDmlCSpBO1BOlVUYwCShQ0BJWoQ6CS18cu7xckDM64wsCGPaEiv9cmky8X33l7s0W
    v4gWR9gEpA699j4OuRQVTO+VIHu7W8DhPcZhJJ2rimhNq/EHkHPWwqJvkspFe4fuOCFc
    llkJSOwCl15MMen5h7M+ixSSSVBh46TJSiTD48+4McU0MZSWlRghVIKouUDzUMhxzniI
    BEPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224674;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nTtDY9XaKTNTqo2/YNyotzVG20HO00Z5YizB6ADow3Y=;
    b=eyXF9xbQ3VDF8gSeMrkS3/cQGSaIjD6rumixjaZOKiXJejptsbrtRbafnx00ymcsJV
    AwlWvATLa7PT7q79ZYM+N/r6aSEjHjR8rdMbbEw1lnI3WuwoMTCe8U5lUXOYVzRA00on
    +6jH+kWaLiPq6Kum1P8G5cZxuilsM+VihAlzuCHo8nsLnOLvZ/E09VlX4zCPgdGTCo17
    av/HSWw5r/w/3cT/gJxdAUgSjqieAPTBz0TsFcKDCwUaxvNaC5os3ibaDPQNuSrnEdSw
    6aLsoqsluzBSc4OEfOG9PGBO9Wm5PJT85RFfFe1A0L6L2r1j3c9ufglmG6/uDLikxAlF
    RUPA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224674;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nTtDY9XaKTNTqo2/YNyotzVG20HO00Z5YizB6ADow3Y=;
    b=bHn/Nro02uJPddbeuX5Ffw98JvAHwTUBAgNv9nJY5S4ha8lIJ5agK9duZFoL2MqMHJ
    lJOoxo/IP+EjcIJPEdI/Jor9vy8ZqAaEieSl+2lho9rOaCCmsjabMSaKQFVeFWspDsEe
    mQRHruQSK8FXyU9qAhoygNjHBsBfXGz5sfrCDfief5RJX+CJWvr2WiKKTEW8yk8wNqsx
    7sm+OfHew0tkir93hFX4GcD+OSf8Fexy8QhAszrZgszyfCFokk1EnD93wP5+u0CUv3WB
    dltsaSE0GaU3NBEt0soVEkT1zf70XvVX3wjjiV1Cq76j7Tp6mdLiBl200FuoOjd8J5XF
    RuOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763224674;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nTtDY9XaKTNTqo2/YNyotzVG20HO00Z5YizB6ADow3Y=;
    b=Ky9A3VCQPbOFWyG+fOwOeY6gDGb8T1gces7URvbZHhTAcAsuo5zSZiLmD13TnVyZ/D
    JtR151HlPReyJ0psQ/DA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFGbseQo
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 17:37:54 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl v2 05/15] can: netlink: add CAN_CTRLMODE_XL_TMS flag
Date: Sat, 15 Nov 2025 17:37:30 +0100
Message-ID: <20251115163740.7875-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115163740.7875-1-socketcan@hartkopp.net>
References: <20251115163740.7875-1-socketcan@hartkopp.net>
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
---
 drivers/net/can/dev/dev.c        |  2 ++
 drivers/net/can/dev/netlink.c    | 48 ++++++++++++++++++++++++++++++--
 include/uapi/linux/can/netlink.h |  1 +
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 443692587217..9da3da8c6225 100644
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


