Return-Path: <linux-can+bounces-5973-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECDFCEC769
	for <lists+linux-can@lfdr.de>; Wed, 31 Dec 2025 19:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C57C305058B
	for <lists+linux-can@lfdr.de>; Wed, 31 Dec 2025 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902A52BDC27;
	Wed, 31 Dec 2025 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKvHlqcY"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E82C0F72
	for <linux-can@vger.kernel.org>; Wed, 31 Dec 2025 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767205071; cv=none; b=uIPuKSa6lS4/tZowmAlW5Dpq5BX35zNiXPsHS3nz6YoYpMncQAPNu1JXDvTnIbDuTmPjHaJmDyt70y0HZWCoFQVPzNx0tJh5HYznJ9F4RNUDvNkKpdL3Y/uuxmz9MNVOo+LLjIFpS8TLRjDqhFwuV5rvwspb3BrdIBKPn23GUQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767205071; c=relaxed/simple;
	bh=dB2DxS6/hQ4cWBT1mL/g2GXYJzNqtTvACLxfJuWsr64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2vhnJCYsjgegIVhsivKpOT0wbvgivHcBnORY3kKvPeM6OLTPYQatoEFkT4goWJkaYTwAlodHvr6ES0k2CJIZmSRF5BrN+QtTAZxJd48s0CBr4C7C/Q7BiVPj0eX+Th5r5xY0UKOZGZSeOWiWVatXgaa1YnnimSbWkfPU5t6wyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKvHlqcY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a099233e8dso92017815ad.3
        for <linux-can@vger.kernel.org>; Wed, 31 Dec 2025 10:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767205067; x=1767809867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XFZphiT5rD5wJiK3SZFCUG5+Jd7y/1KKNDXda+ZvC8=;
        b=iKvHlqcYXdTOvI7/I4Mb3etqb1U1e6p6U6rBO4gMPVp1HZBjYmcoswmJ9b8KRlkuIP
         4Q5RX7RIT7PtCQu8hybAIAoT4SrKoaRgbXTD2guo1teB8SwlYJ87GLxoOmlR5aKZEdIB
         oxXhSIDkuXcd2tIuQ+yIvb/+SacrQp89PBEYkTDGTXD2FhA8JxsIGT+YHwfVc/mYSCb3
         G7w5pV4xNcUIReSMgfsoH608axEsXbB8VNNI4y4DQBkFs1xupdb9NrmLRcHFdYwiwMiU
         73juPxwnd0/ONQhRwo2knG9+g4H3Ou+909tklFoz0Z/U0vJoO81OXWT8h7gGEIUuE8V+
         2sQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767205067; x=1767809867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6XFZphiT5rD5wJiK3SZFCUG5+Jd7y/1KKNDXda+ZvC8=;
        b=CjHOTe4rRD3vETE/dKYA+YDttlKVCzg7aZcw8Avn/RhczmAYsS40t2Mht/rAcKgyXW
         UHZZCrmYUA9NCZnajgOZkH9JGmzuGhGfd8OnZscyZ8SEn/vQGwnZKYzEeaia30ogf286
         Qs37ivCthl8O0i4TYrmwt601spAjkpWTzVeo8beuErvXJon3aqgavanZFBnew+wXUaIa
         gR8/UlJRFkeW449CJP5/BFanszZSVFy1qvqD8wSx50FC4ioAdwSmfWKxroQjjBMGvTmj
         kkfiHONnr6Od6UeiMk3gkYmiAU0Z7GdOu+Q09IuH1BN76iCYupBB/D/xJxMU9LvbF0Bg
         3LPQ==
X-Gm-Message-State: AOJu0Yz/Y+pmo+OWB9MqSzm6XS8gpRPIMbEWdeCoOE7JhzyqMZ2Yc8pC
	91+rNCrP1oPpmO3o4MwcruBk7qdJvAffeWeFNMdCzaZ4Gl7mDe4Hzyqf
X-Gm-Gg: AY/fxX6nszJug0B8zO3pCC55Iyhso253YOmZ74qh3G78BcTzIxHZhj6nJwyKRqzFlD8
	OlBBmprHoEWMkkb8xIFPj3Md09MF1OFZWcLdA0QNewjmphK7xliNqigfHP7Say1uDd+FJcR6p4/
	C/irSCkBC4xukiQlL6UdFEGv+OgrlH5G235R1U7HTrNP/S/hSqK5YURtyB2uB76qKNt6J0iA4h6
	20dlNLPAWld8o8Ic7cSNkRDGklMIwOJoacDdYIYY4uNEf7iPkKIuqdwWTiHOWh1kK2r8beSGVSg
	mpNEL0dzbNG4FVaUXml/cga+AgEtbBHxoRP/Jnjha81nLC9ftZEpeKE3PK9BUdE03iRkBs68AmP
	1X3Z0FIWLMSD7NwOtkNToO+YFelh2iI/vypCJtFg4u9S6zRT/fUVrP1OFm+Jj4KWwf0r82zuLCv
	RNfaTgzV8BcAGxQNjq
X-Google-Smtp-Source: AGHT+IFLyU879sREsum14e+whPX7oYGacLa8gelBRymC+21ag2DKvCrTdgtlaY0XNOiocu/U2/AN4g==
X-Received: by 2002:a17:902:ef52:b0:2a0:dabc:1383 with SMTP id d9443c01a7336-2a2f22234a1mr428210655ad.14.1767205067215;
        Wed, 31 Dec 2025 10:17:47 -0800 (PST)
Received: from rakuram-MSI ([2401:4900:93ef:93d6:a0f7:dedb:d261:86b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66473sm310787225ad.13.2025.12.31.10.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 10:17:46 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: rakuram.e96@gmail.com,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/2] can: dummy_can: add CAN termination support
Date: Wed, 31 Dec 2025 23:43:15 +0530
Message-ID: <20251231-can_doc_update_v1-v1-1-97aac5c20a35@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231-can_doc_update_v1-v1-0-97aac5c20a35@gmail.com>
References: <20251231-can_doc_update_v1-v1-0-97aac5c20a35@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767203695; l=2548; i=rakuram.e96@gmail.com; s=20251022; h=from:subject:message-id; bh=/VHe7Ay06eDBrZBDf+ehbGiVOu/+rnbHmhOETk1LKwI=; b=sPrViP4uOkV7IW1k0c9KOtZspggUOvc61/3MFqzPJvuvo4iwL8SjEOEGfppeLYBMDtbtRG33N gsDpLOxiZriDgaoKrRfTbr65iwa2klYgamdPkXFZTBxlbALdBtdWPLu
X-Developer-Key: i=rakuram.e96@gmail.com; a=ed25519; pk=swrXGNLB3jH+d6pqdVOCwq0slsYH5rn9IkMak1fIfgA=
Content-Transfer-Encoding: 8bit

Add support for configuring bus termination in the dummy_can driver.
This allows users to emulate a properly terminated CAN bus when
setting up virtual test environments.

Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---
Tested the termination setting using below iproute commands:

  ip link set can0 type can termination 120
  ip link set can0 type can termination off
  ip link set can0 type can termination potato
  ip link set can0 type can termination 10000
  
 drivers/net/can/dummy_can.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dummy_can.c b/drivers/net/can/dummy_can.c
index 41953655e3d3c9187d6574710e6aa90fc01c92a7..418d9e25bfca1c7af924ad451c8dd8ae1bca78a3 100644
--- a/drivers/net/can/dummy_can.c
+++ b/drivers/net/can/dummy_can.c
@@ -86,6 +86,11 @@ static const struct can_pwm_const dummy_can_pwm_const = {
 	.pwmo_max = 16,
 };
 
+static const u16 dummy_can_termination_const[] = {
+	CAN_TERMINATION_DISABLED,	/* 0 = off */
+	120,				/* 120 Ohms */
+};
+
 static void dummy_can_print_bittiming(struct net_device *dev,
 				      struct can_bittiming *bt)
 {
@@ -179,6 +184,16 @@ static void dummy_can_print_bittiming_info(struct net_device *dev)
 	netdev_dbg(dev, "\n");
 }
 
+static int dummy_can_set_termination(struct net_device *dev, u16 term)
+{
+	struct dummy_can *priv = netdev_priv(dev);
+
+	netdev_dbg(dev, "set termination to %u Ohms\n", term);
+	priv->can.termination = term;
+
+	return 0;
+}
+
 static int dummy_can_netdev_open(struct net_device *dev)
 {
 	int ret;
@@ -243,17 +258,23 @@ static int __init dummy_can_init(void)
 	dev->ethtool_ops = &dummy_can_ethtool_ops;
 	priv = netdev_priv(dev);
 	priv->can.bittiming_const = &dummy_can_bittiming_const;
-	priv->can.bitrate_max = 20 * MEGA /* BPS */;
-	priv->can.clock.freq = 160 * MEGA /* Hz */;
 	priv->can.fd.data_bittiming_const = &dummy_can_fd_databittiming_const;
 	priv->can.fd.tdc_const = &dummy_can_fd_tdc_const;
 	priv->can.xl.data_bittiming_const = &dummy_can_xl_databittiming_const;
 	priv->can.xl.tdc_const = &dummy_can_xl_tdc_const;
 	priv->can.xl.pwm_const = &dummy_can_pwm_const;
+	priv->can.bitrate_max = 20 * MEGA /* BPS */;
+	priv->can.clock.freq = 160 * MEGA /* Hz */;
+	priv->can.termination_const_cnt = ARRAY_SIZE(dummy_can_termination_const);
+	priv->can.termination_const = dummy_can_termination_const;
+
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
 		CAN_CTRLMODE_FD | CAN_CTRLMODE_TDC_AUTO |
 		CAN_CTRLMODE_RESTRICTED | CAN_CTRLMODE_XL |
 		CAN_CTRLMODE_XL_TDC_AUTO | CAN_CTRLMODE_XL_TMS;
+
+	priv->can.do_set_termination = dummy_can_set_termination;
+
 	priv->dev = dev;
 
 	ret = register_candev(priv->dev);

-- 
2.51.0


