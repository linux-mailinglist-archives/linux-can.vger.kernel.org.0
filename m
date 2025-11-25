Return-Path: <linux-can+bounces-5645-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69760C85002
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 13:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB043B2820
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 12:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E1F27702D;
	Tue, 25 Nov 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="S0HsaOiy";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jR2airOZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BDE31D371
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074370; cv=pass; b=iU1IS/5qteLG8rAVi1Ekr8lvqG/jwNdno6dvxvA13q9iULOdnAu4x80kj9HAlyI2oUtq+9DN/rgrkyJbrk1tbh54C2vIO9LxXafIny3UybAdyduIkiMzR43qh3x9cw/UiHHXOHZCjMAvoNholsbc3jMsKz0KVHWVzK1PzKkddIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074370; c=relaxed/simple;
	bh=GLYw6DWDt3oePp+8a+BgZIKpOTOFAKzaaYW/2Fjfr0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iap1Z3qowIioI0IJO68ct3vDWeNNtOxxvy3e7wGXDRvHsdUUXN7HKJXOjoTGxghWu6rpntJIp7ThECZocrDTstpesiX83p9o4Ykx+AYn+0rEiSE2SzKceo/93qFFA0wjdcXf6GwjZbyOxIv+yMlPhDRZG9xmQhpsNjmFNALk9Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=S0HsaOiy; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jR2airOZ; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764074354; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=k8tv14gXG4qQ2rfz93QW8O1JgZIiaXzAhCYxYToEQFYWHKAHsWe7xBRG9a82DuF1Rw
    snk37jwrt5jrEBQX7THAiIRGKKLbjKw3dU6bpV1KhOK7RWNdBD87PMFKskHqnFCNO8Vz
    /R0IPJQs0ILeA5vqIlR/aSl2I8NHSVcqrmraCqhneR8mKAdneeeJlAsVbsa/Kf6PVDYw
    cpOJC7iL1Pv/QKwV20/Dq5SblQvn72dlpobTzXla8B+5vf6lEUtShLpTf6cut9BR7bC5
    7LmYheP/kdSO6ertA7txhJjZjijX1zZPqP+qKG7fVtCUGRA1r8Apu/1uA1r7IPZ0ok3u
    hNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074354;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tFwzf0H47txhVYqX1RnH/isA6GYuE7RxeqKNFJkbEsE=;
    b=hV2pY8q4fv5WNO8QO5xzMVa6PXmwQH805V0tgzhb7sDxJEoXFDZv3ldsVteAMrzSrr
    yp1OYfKWAk4RCZgK23iQdJ2YAy5azPByffX3xTtqNewvKPmq/zi+YFoaomuvI1E94l9j
    AiYhWReOohKvC2k/b643yw4fRivpo8+1bwPjPZe1k4RZwW8vOGPB6t2/Qp1Tis9XJ+T1
    CYus6ooU5Uwc48TGMg/NI8qLTiDm0J0IqzU23GOh3Kcs7L8iqAw7cO2Y4oMvkOtgRjm/
    20FgaEZYKA9Lxs5qD9iuWlL/oMRnR5C1lfiIzfhspKcvE9rCllYJOgU8300ZweAPJcP0
    GagQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074354;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tFwzf0H47txhVYqX1RnH/isA6GYuE7RxeqKNFJkbEsE=;
    b=S0HsaOiyLdM620nzwlBwik2nKwua798zkCndgQBPORQTpttiHmiJuXTXHWMfzj68HX
    u756vVcSqDM5hoIcWg/l/lYaERncNRljuC1SuNbrd58MAa/UwYaE4TUpY+yD1SSuwZTG
    ycofA2RWd9ewabcl/ET2OGQJyIfip6tP9uXzG0KIpRr/bmMnY0V+nENBN6Asv6IuyEhx
    59630NaXu4Kma8JyNs0NE911GUxj7tm2jvEp0aBY2P3G1u1ypD86KfRijaqOQ0Am9yNw
    +GeiUlMkygwsV3+lt6drGoO3WLP7GpF7H51i67pfr56MM5t7IOJNpxj7eeebhgsC3HLM
    E6xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764074354;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tFwzf0H47txhVYqX1RnH/isA6GYuE7RxeqKNFJkbEsE=;
    b=jR2airOZr8O8GjaggWlEe21Fjt2cEExDSOmhsN3FFgo1MGXyQE3VOdLJCh3o6Z49Mc
    M9zk4nBjPs7u3FMu8zCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461APCdET8Q
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Nov 2025 13:39:14 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v7 06/17] can: netlink: add CAN_CTRLMODE_XL_TMS flag
Date: Tue, 25 Nov 2025 13:38:48 +0100
Message-ID: <20251125123859.3924-7-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251125123859.3924-1-socketcan@hartkopp.net>
References: <20251125123859.3924-1-socketcan@hartkopp.net>
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


