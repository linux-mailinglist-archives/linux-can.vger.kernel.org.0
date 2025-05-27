Return-Path: <linux-can+bounces-3703-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CBFAC5B14
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 21:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86043AEA02
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 19:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3274202996;
	Tue, 27 May 2025 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CmUnBB0X";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="u0edbRUx"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48932202969
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375813; cv=pass; b=sY2WQtR3+At5fEJAIXorHg/gwr6SFfa8Z8uRHihdw7m0GxLMUCxCAXXVgNjnY/PmRgCHcsmnO+1zbsle//GKtvxf9OeSlALGe9Z3EOc3cxWq40bj1f9HXtsbf3xYpP7Cine1jSooPPI5IVBVrZsmbENkQc1dbzW/I9hzu19yzzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375813; c=relaxed/simple;
	bh=yFETaAOXfkowykeC6nntqajh2bsyd29O9ec+WsFHCJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXkD+Yl6aePoDcDsH84gUCuUheSr6L7T1LsqBk3vsnpW7ueMo5HPRNepGqJI5NMcT0MjX/d1IHS8qxa55To4Gxa+qzrSGLn6c1PPrS6wbseV0yStiAAX24BqqQvyObbofZVSL7qMpXu4bLZ+YUC+8S/emiXIvgA3wIY4TIUwI+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CmUnBB0X; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=u0edbRUx; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748375801; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OBM9Ipgq99P3XObIAooyK6+cZs9o6pM9Dj1xxT8tLnBXyqDZjqKLKgtmQED+9v/kR3
    YtSwUWv8GP8FjIR3mqoOvIqMP0a3ugtIadJ/3ZKqTLIgLLRmO4jaU9j7Tu8GLo1nmAnW
    WZ59lJ50AJmLP2ZHPIpqomWaIYkWid6UPpHveHPdNrku4BVJQ3kuMjx/EMR3PkiGZ3y3
    9J2AVcjIQ0RXnOuQXAgoBw7Xh6wskpup8D4ZdW61iFghotOjQTkLjXwdWQA7ZtfLeQFw
    1sTgRzcVzEez+qGvgNwpr9fRNLqj1iLdz+dF/Wj9Syx5CvmLhdykKhkA4c81DNA6k+OB
    NHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375801;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=PpAIO/0jgty9NN0BCGjH2RbQXea8c7+GDG//4gaGR/k=;
    b=OJPyn6qmkOafCwhTgmK8eBC2G2Pp0O6FapgcvcC9j4t3LRtou+8Ho0KcutxahwOlXC
    taVPBhuLPrnhHxfVyCMRLqmabAZIPQV2+g9fRjWgPkWnB1rOxga6jH0lA7y9IrY+SFaJ
    ZOETBIu/yy/NunE23jLR4MOSzbzBuZ26xXu5sj130hSz3wMH1rmdBzpYkA54ydLq11wZ
    mAw/41cnIEhnarFdn9ftxE3xmH7YCKon2TGK7LW8Tax/QANSw+citd/zn7k3SnvlYU8e
    x+20iF8fJEMb5YSdU3XG3Rm9J7G9CErI9x/tE1Fx4eGjNrtzveg5jHDHxFBynHstQODw
    EGLw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375801;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=PpAIO/0jgty9NN0BCGjH2RbQXea8c7+GDG//4gaGR/k=;
    b=CmUnBB0XsHD0tA1+hsdwzPvOj2r0ie9l38GWYaJWooY5azbgHaI5vCtO13mEQNKdh6
    uULM779lfwZfI7QjuLpxSZn42hbpaMtPXVYdIK2OsPodP2qMENAIq/6hXwbmhqmV3An6
    GHmtMVzpAS2ercdzGYkxXxQNSsztGOj8g0jdUJR76VhIDaUAL5bVWkSzQZD3iUnjas3j
    rHIblRksIlXo5DeDcC6m4xjHHm3pqUlO4AGO8xXYhSsZBFa0VskEOmufu5hwedAt6vrf
    xBm+S0CR3CXQhKApG2aSSu8H2jPS/zOiYYq5m4xZ4yVFHSguKG3t7PUC0hyv1Uinxdhe
    4lhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748375801;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=PpAIO/0jgty9NN0BCGjH2RbQXea8c7+GDG//4gaGR/k=;
    b=u0edbRUxK+lJUwOdGZtRDFr89vFJNgfvL5uXTl4xMYI51MuH38RGcZr7VpVtnfYgAV
    tMUdpozp1Xpbh3HGL+Bw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514RJufiW6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 May 2025 21:56:41 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 04/11] can: bittiming: rename can_tdc_is_enabled() into can_fd_tdc_is_enabled()
Date: Tue, 27 May 2025 21:56:18 +0200
Message-ID: <20250527195625.65252-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250527195625.65252-1-socketcan@hartkopp.net>
References: <20250527195625.65252-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

With the introduction of CAN XL, a new can_xl_tdc_is_enabled() helper
function will be introduced later on. Rename can_tdc_is_enabled() into
can_fd_tdc_is_enabled() to make it more explicit that this helper is
meant for CAN FD.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c             | 6 +++---
 drivers/net/can/usb/etas_es58x/es58x_fd.c | 2 +-
 drivers/net/can/xilinx_can.c              | 2 +-
 include/linux/can/dev.h                   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 08261cfcf6b2..16b0f326c143 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -142,11 +142,11 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 	struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
 	struct can_tdc tdc = { 0 };
 	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
 	int err;
 
-	if (!tdc_const || !can_tdc_is_enabled(priv))
+	if (!tdc_const || !can_fd_tdc_is_enabled(priv))
 		return -EOPNOTSUPP;
 
 	err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX, nla,
 			       can_tdc_policy, extack);
 	if (err)
@@ -407,11 +407,11 @@ static size_t can_tdc_get_size(const struct net_device *dev)
 	if (priv->fd.tdc_const->tdcf_max) {
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF_MIN */
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF_MAX */
 	}
 
-	if (can_tdc_is_enabled(priv)) {
+	if (can_fd_tdc_is_enabled(priv)) {
 		if (priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL ||
 		    priv->fd.do_get_auto_tdcv)
 			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV */
 		size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO */
 		if (priv->fd.tdc_const->tdcf_max)
@@ -488,11 +488,11 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (tdc_const->tdcf_max &&
 	    (nla_put_u32(skb, IFLA_CAN_TDC_TDCF_MIN, tdc_const->tdcf_min) ||
 	     nla_put_u32(skb, IFLA_CAN_TDC_TDCF_MAX, tdc_const->tdcf_max)))
 		goto err_cancel;
 
-	if (can_tdc_is_enabled(priv)) {
+	if (can_fd_tdc_is_enabled(priv)) {
 		u32 tdcv;
 		int err = -EINVAL;
 
 		if (priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL) {
 			tdcv = tdc->tdcv;
diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
index d924b053677b..6476add1c105 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
@@ -427,11 +427,11 @@ static int es58x_fd_enable_channel(struct es58x_priv *priv)
 
 	if (tx_conf_msg.canfd_enabled) {
 		es58x_fd_convert_bittiming(&tx_conf_msg.data_bittiming,
 					   &priv->can.fd.data_bittiming);
 
-		if (can_tdc_is_enabled(&priv->can)) {
+		if (can_fd_tdc_is_enabled(&priv->can)) {
 			tx_conf_msg.tdc_enabled = 1;
 			tx_conf_msg.tdco = cpu_to_le16(priv->can.fd.tdc.tdco);
 			tx_conf_msg.tdcf = cpu_to_le16(priv->can.fd.tdc.tdcf);
 		}
 
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 3f2e378199ab..81baec8eb1e5 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -513,11 +513,11 @@ static int xcan_set_bittiming(struct net_device *ndev)
 
 	if (priv->devtype.cantype == XAXI_CANFD ||
 	    priv->devtype.cantype == XAXI_CANFD_2_0) {
 		/* Setting Baud Rate prescaler value in F_BRPR Register */
 		btr0 = dbt->brp - 1;
-		if (can_tdc_is_enabled(&priv->can)) {
+		if (can_fd_tdc_is_enabled(&priv->can)) {
 			if (priv->devtype.cantype == XAXI_CANFD)
 				btr0 |= FIELD_PREP(XCAN_BRPR_TDCO_MASK, priv->can.fd.tdc.tdco) |
 					XCAN_BRPR_TDC_ENABLE;
 			else
 				btr0 |= FIELD_PREP(XCAN_2_BRPR_TDCO_MASK, priv->can.fd.tdc.tdco) |
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index e492dfa8a472..9a92cbe5b2cb 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -89,11 +89,11 @@ struct can_priv {
 			    enum can_state *state);
 	int (*do_get_berr_counter)(const struct net_device *dev,
 				   struct can_berr_counter *bec);
 };
 
-static inline bool can_tdc_is_enabled(const struct can_priv *priv)
+static inline bool can_fd_tdc_is_enabled(const struct can_priv *priv)
 {
 	return !!(priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 }
 
 /*
-- 
2.47.2


