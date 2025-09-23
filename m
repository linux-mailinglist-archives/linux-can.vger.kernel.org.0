Return-Path: <linux-can+bounces-4874-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC92CB94A6A
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECBD178278
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98157313E2C;
	Tue, 23 Sep 2025 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZuvLj/t"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C0313E25;
	Tue, 23 Sep 2025 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610806; cv=none; b=HuU5rAOQ8Minzp4tpy/iUFsGpxx9Rs8yy121PqXcqGLbGWDEdVi05AkLJY6PmF6mJv9UAEe7ih9mx9Yxrb4dJrsaF57ouAXQOWgfmZc06LftdVmwtQTs9g/3kMlDN5a5mSpn/J4HqQVU+B+DC3cCPVEvvYwZVW7q+bLtRL2st5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610806; c=relaxed/simple;
	bh=b+C6iL5E7JnwjQ5NjxVbqJevhBvTZfzFh4fIjIFyacE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tB9RcGP5WzZzsdt1Ms9vbm1lCL8ZATG46JdCoKPCSX5jpJeAbn3p7wUnuBeAmYsBOlK07nNlelZuIFV+emcqzprLf69YtZ8Lur0euhvrZMqdeD6ozDzu/nCtWc7yEyf4h4DNTF4lEl9FTCmjAmGD+RFveJ69oVNOncmccsRpluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZuvLj/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC55C116C6;
	Tue, 23 Sep 2025 07:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610806;
	bh=b+C6iL5E7JnwjQ5NjxVbqJevhBvTZfzFh4fIjIFyacE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RZuvLj/tb4nrqFuBRfG3mVMHIjMWtHlm8zqxcAe4OsraCQTkzbbkZ2wYSoznq0ORB
	 2gAuhv6ojMIj8DaDEyam/7haMExfO3Hk5432ovlyHeMmUgwAhdMifXbz55GMK2GBL3
	 JxS+Y0yWGxj/whVNwI2QnvgV2itcbLaG+SvpHKkibeIIFxUdmTQd6ADH4iBoWZeVrP
	 APvL+N2KCqPSRXCg1XfsB+xTqhu4hlU0MUgJTR8BsMD3ZrU8ADfxYYHpCbsQd8ofGI
	 e9rObSRDz/pTGrTH9UqeaMH6s2AoRpRpaObrIU2GaJYMFJTwIZbkjP6e1IHIxsigy3
	 vH+IgCKWnao7A==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:38 +0900
Subject: [PATCH v4 13/20] can: netlink: add can_data_bittiming_get_size()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-13-e720d28f66fe@kernel.org>
References: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
In-Reply-To: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3222; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=b+C6iL5E7JnwjQ5NjxVbqJevhBvTZfzFh4fIjIFyacE=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXN1uFPsaW0452J3JdvdMUMymddNvcFa6zA4Q0TTOe
 KoetPFdRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgInkejL8lci5+21t/q+3qk+7
 5oiJWAuFHcg9dkCFoWGb6jrFJS969jH8d1p4Lu928MmAxEV/ew5x7P38yneHr5esQl/0u9Wzu3z
 ZuAE=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Add the can_data_bittiming_get_size() function to factorise the logic
to retrieve the size of below data bittiming parameters:

  - data_bittiming
  - data_bittiming_const
  - data_bitrate_const
  - tdc parameters

This function will be reused later on for CAN XL.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 3c0675877f5ef84a2b84d5852a0e91d23b164eeb..5d2b524daea90442e56a1b24e7c32190a84ed934 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -504,6 +504,23 @@ static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
 	return size;
 }
 
+static size_t can_data_bittiming_get_size(struct data_bittiming_params *dbt_params,
+					  u32 tdc_flags)
+{
+	size_t size = 0;
+
+	if (dbt_params->data_bittiming.bitrate)		/* IFLA_CAN_DATA_BITTIMING */
+		size += nla_total_size(sizeof(dbt_params->data_bittiming));
+	if (dbt_params->data_bittiming_const)		/* IFLA_CAN_DATA_BITTIMING_CONST */
+		size += nla_total_size(sizeof(*dbt_params->data_bittiming_const));
+	if (dbt_params->data_bitrate_const)		/* IFLA_CAN_DATA_BITRATE_CONST */
+		size += nla_total_size(sizeof(*dbt_params->data_bitrate_const) *
+				       dbt_params->data_bitrate_const_cnt);
+	size += can_tdc_get_size(dbt_params, tdc_flags);/* IFLA_CAN_TDC */
+
+	return size;
+}
+
 static size_t can_ctrlmode_ext_get_size(void)
 {
 	return nla_total_size(0) +		/* nest IFLA_CAN_CTRLMODE_EXT */
@@ -525,10 +542,6 @@ static size_t can_get_size(const struct net_device *dev)
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
 	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
 		size += nla_total_size(sizeof(struct can_berr_counter));
-	if (priv->fd.data_bittiming.bitrate)			/* IFLA_CAN_DATA_BITTIMING */
-		size += nla_total_size(sizeof(struct can_bittiming));
-	if (priv->fd.data_bittiming_const)			/* IFLA_CAN_DATA_BITTIMING_CONST */
-		size += nla_total_size(sizeof(struct can_bittiming_const));
 	if (priv->termination_const) {
 		size += nla_total_size(sizeof(priv->termination));		/* IFLA_CAN_TERMINATION */
 		size += nla_total_size(sizeof(*priv->termination_const) *	/* IFLA_CAN_TERMINATION_CONST */
@@ -537,14 +550,12 @@ static size_t can_get_size(const struct net_device *dev)
 	if (priv->bitrate_const)				/* IFLA_CAN_BITRATE_CONST */
 		size += nla_total_size(sizeof(*priv->bitrate_const) *
 				       priv->bitrate_const_cnt);
-	if (priv->fd.data_bitrate_const)			/* IFLA_CAN_DATA_BITRATE_CONST */
-		size += nla_total_size(sizeof(*priv->fd.data_bitrate_const) *
-				       priv->fd.data_bitrate_const_cnt);
 	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
-	size += can_tdc_get_size(&priv->fd,			/* IFLA_CAN_TDC */
-				 priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
 
+	size += can_data_bittiming_get_size(&priv->fd,
+					    priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
+
 	return size;
 }
 

-- 
2.49.1


