Return-Path: <linux-can+bounces-5158-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F957BD2B18
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 13:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A780D189C738
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193AF306498;
	Mon, 13 Oct 2025 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0azoQ2J"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8975306495;
	Mon, 13 Oct 2025 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353343; cv=none; b=gfnML5hWGKvuEpwDUuy8rMcmCyVhXJ6vlQ28Wgc4kj67Oi77PwwGQP4HpTVP7H3NvSz+H+sK/srYDf953mBmnd6wvx+UczjTvKd9geO61Txyvs9XpCE+oK/z8XMSoJNGx7XBcv2CBu0yefwyE1pdTyTnIOocbNWTh3StrvgPKxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353343; c=relaxed/simple;
	bh=VMd2jLfl17yXHcMVN4REYXUpVUjagU+Tc7WCN87WQ9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bu2Rz71Cmegihu3teXdhIH9fIxqsLxbCGSFPMQ0SsnO2i65Voi5xvqHkF25evL1pXBk8//2wLo/Qvm/2BXMQ8pLNAzkTmc0iGXt7TvcWRnR0xH6Ibu7+QlPBs6Dn4OGhJJNNkRpC7QzCiPHeYnO+KpNGrAUifG6nq6HC4nHbxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0azoQ2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FC8C4AF09;
	Mon, 13 Oct 2025 11:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760353343;
	bh=VMd2jLfl17yXHcMVN4REYXUpVUjagU+Tc7WCN87WQ9s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p0azoQ2Jm5uR+ocYrqjVeNE8OoyYXqIXysbPTlvq5Da6aXr84amN7liIP/zKu8S7U
	 2aXbwLa96SXu2vu0UOPMx8qkrYCuhBNW01jPuD8knTTtJl/RBXXJTKPGSeSUktK9gV
	 R2pic4rw5xA6AY+316N957Ye9Kjzl3KbdLhs3Bh/j1fIMGnZ42bAud+2uerpF7Hfco
	 JyD6l8fw/w49ukcAlXHt2j8hd0cxT3tKP/j8rQeQZPE/3FP4IhubqboB/mgYNuHKl5
	 3uGv26j9M0Z8CJmy9IoSry3WiIbydc4L1oaNirgPX/eZymUBqBawxNB25d8J3tiQfd
	 VtgAmxWx57Ugg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 13 Oct 2025 20:01:26 +0900
Subject: [PATCH 4/9] can: netlink: add CAN_CTRLMODE_XL_TMS flag
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-canxl-netlink-v1-4-f422b7e2729f@kernel.org>
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
In-Reply-To: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7104; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=VMd2jLfl17yXHcMVN4REYXUpVUjagU+Tc7WCN87WQ9s=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlv7qhK3ukwfZ9WMd9jQlKj2IMX4V2bJE33SfGtfvm2b
 de57VPPdpSyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZiIExMjw7LbDWZ3u4/m/fnC
 Vbl86THGB5cuiqycdkpDqCQgfoGiLh8jw8yoS7c6HZdvC5qucVNTK1nOvvOZwsHObS2HhPKe6AQ
 3MAMA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The Transceiver Mode Switching (TMS) indicates whether the CAN XL
controller shall use the PWM or NRZ encoding during the data phase.

The term "transceiver mode switching" is used in both ISO 11898-1 and
CiA 612-2 (although only the latter one uses the abbreviation TMS). We
adopt the same naming convention here for consistency.

Add the CAN_CTRLMODE_XL_TMS flag to the list of the CAN control modes.

In the netlink interface, each boolean option is in reality a tristate
in disguise: on, off or omitted. For the moment, TMS is implemented as
below:

  - CAN_CTRLMODE_XL_TMS is set to false: TMS is disabled.
  - CAN_CTRLMODE_XL_TMS is set to true: TMS is enabled.
  - CAN_CTRLMODE_XL_TMS is omitted: return -EOPNOTSUPP.

For most of the other control modes, omitting a flag default to the
option turned off. It could also be possible to provide a default
behaviour if the TMS flag is omitted (i.e. either default to TMS off
or on). However, it is not clear for the moment which default
behaviour is preferable. If the usage shows a clear trend (for example
if the vast majority of the users want TMS on by default), it is still
possible to revisit that choice in the future. Whereas once a default
option is provided, we can not change it back without breaking the
interface.

As a corollary, for the moment, the users will be forced to specify
the TMS in the ip tool when using CAN XL.

Add can_validate_xl_flags() to check the coherency of the TMS flag.
That function will be reused in upcoming changes to validate the other
CAN XL flags.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Question:

Is it still possible to send Classical CAN frames when TMS is on? If
not, we need to also add this filter in can_dev_dropped_skb():

	if ((priv->ctrlmode & CAN_CTRLMODE_XL_TMS) && !can_is_canxl_skb(skb)) {
		netdev_info_once(dev,
				 "Classical CAN frames are not allowed under CAN XL's TMS mode\n");
		goto invalid_skb;
	}

My current assumption is that this is possible. But the standard being
not crystal clear on that point, I want to double check this with you!
---
 drivers/net/can/dev/dev.c        |  2 ++
 drivers/net/can/dev/netlink.c    | 52 +++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/can/netlink.h |  1 +
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 32f11db88295..1de5babcc4f3 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -123,6 +123,8 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
 		return "xl-tdc-auto";
 	case CAN_CTRLMODE_XL_TDC_MANUAL:
 		return "xl-tdc-manual";
+	case CAN_CTRLMODE_XL_TMS:
+		return "xl-tms";
 	default:
 		return "<unknown>";
 	}
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 2405f1265488..8afd2baa03cf 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -181,6 +181,36 @@ static int can_validate_databittiming(struct nlattr *data[],
 	return 0;
 }
 
+static int can_validate_xl_flags(struct netlink_ext_ack *extack,
+				 u32 masked_flags, u32 mask)
+{
+	if (masked_flags & CAN_CTRLMODE_XL) {
+		if (!(mask & CAN_CTRLMODE_XL_TMS)) {
+			NL_SET_ERR_MSG(extack, "Specify whether TMS is on or off");
+			return -EOPNOTSUPP;
+		}
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
@@ -201,6 +231,10 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 				       "Listen-only and restricted modes are mutually exclusive");
 			return -EOPNOTSUPP;
 		}
+
+		err = can_validate_xl_flags(extack, flags, cm->mask);
+		if (err)
+			return err;
 	}
 
 	err = can_validate_bittiming(data, extack, IFLA_CAN_BITTIMING);
@@ -227,7 +261,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 	struct can_priv *priv = netdev_priv(dev);
 	struct can_ctrlmode *cm;
 	const u32 xl_mandatory = CAN_CTRLMODE_RESTRICTED;
-	u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing, xl_missing;
+	u32 ctrlstatic, maskedflags, deactivated, notsupp, ctrlstatic_missing, xl_missing;
 
 	if (!data[IFLA_CAN_CTRLMODE])
 		return 0;
@@ -239,6 +273,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 	cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 	ctrlstatic = can_get_static_ctrlmode(priv);
 	maskedflags = cm->flags & cm->mask;
+	deactivated = ~cm->flags & cm->mask;
 	notsupp = maskedflags & ~(priv->ctrlmode_supported | ctrlstatic);
 	ctrlstatic_missing = (maskedflags & ctrlstatic) ^ ctrlstatic;
 	xl_missing = (priv->ctrlmode_supported & xl_mandatory) ^ xl_mandatory;
@@ -268,11 +303,21 @@ static int can_ctrlmode_changelink(struct net_device *dev,
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
@@ -404,7 +449,8 @@ static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 
-		need_tdc_calc = !(cm->mask & tdc_mask);
+		if (fd || !(priv->ctrlmode & CAN_CTRLMODE_XL_TMS))
+			need_tdc_calc = !(cm->mask & tdc_mask);
 	}
 	if (data_tdc) {
 		/* TDC parameters are provided: use them */
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index c2c96c5978a8..ebafb091d80f 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -107,6 +107,7 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_XL			0x1000	/* CAN XL mode */
 #define CAN_CTRLMODE_XL_TDC_AUTO	0x2000	/* XL transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_XL_TDC_MANUAL	0x4000	/* XL TDCV is manually set up by user */
+#define CAN_CTRLMODE_XL_TMS		0x8000	/* Transceiver Mode Switching */
 
 /*
  * CAN device statistics

-- 
2.49.1


