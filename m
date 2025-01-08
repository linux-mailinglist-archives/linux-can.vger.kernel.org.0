Return-Path: <linux-can+bounces-2562-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C18BA05607
	for <lists+linux-can@lfdr.de>; Wed,  8 Jan 2025 10:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6C118884F3
	for <lists+linux-can@lfdr.de>; Wed,  8 Jan 2025 09:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1451A83F9;
	Wed,  8 Jan 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zn6IEtd/"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC4814B95A;
	Wed,  8 Jan 2025 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736326882; cv=none; b=CFBN4ifYSFVZTyu3G1vMhdSwZUCAbQ1MiULfEaiGMKE9IH8mcv8gFrgzEA0i1sdwy1p9505/JIeFtbYO+UIq560BySUA5VhVAgpRdjkzechhNZVmh8creA1/v+IuAaByXHc/0VtbZrLbaasl/UQoIOAmeUvLYV65HX3q5A4Rqks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736326882; c=relaxed/simple;
	bh=1/dmrtgI0VRd4HfkTxBDEJqU6yxTZzJ1DMNIgvHADVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kSj+U8goh/kf8fpQhmofaM2KGduDGGEpvvw6wx9dDO/7/O7yx7E68lOfw9H64Bpz3nGfSFhQnHz8xZmzc30Lx1wEY61pTvXGVcboTaHw+NGThTClIXs7Z641Tk7J5Hq79KZeoxiy6TnF7oU06c7XcG0H8N7YzmH16Hm3DQwfalE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zn6IEtd/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736326881; x=1767862881;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1/dmrtgI0VRd4HfkTxBDEJqU6yxTZzJ1DMNIgvHADVo=;
  b=Zn6IEtd/3KiTjsDYG+hLajeBippd5EbLltHOVTW+3VqUAxS0wfSG1v57
   n4lOzK2UaZ4JE90iHF+qaQ1ld6tNX3Oa6jfRWTU4mQfH4MLd7wIL1HVA+
   8P3hnQFsYCzc9cnofFKqzgi9BZ+DE97ZrIehLQRWqQVKTZrtyGYQvJlD5
   cMqoY+ldQCnr43yB7d61KVu+GEJJm0hRSc5on0o1joETYQG/PdqD4g5Sh
   f44z9Q3OMzd2EUWEChiaRqT/S6ZPL2EHzCjZWM919jPTPaSIQF8swGzwn
   caOH7qU5SAQCVEypYCYF71pw+LErDeyPSYzO46Q75K1B00UWGcWSY92fJ
   g==;
X-CSE-ConnectionGUID: LbJgGUFmS5mlcxBCHb+P7w==
X-CSE-MsgGUID: IjKREzT0SfmIjkQBxz9v9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="47958613"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="47958613"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 01:01:19 -0800
X-CSE-ConnectionGUID: yyFtFHT+S/Ca31kWntquPQ==
X-CSE-MsgGUID: 0XTWQGM1Rzegf8mzzUVZlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="102843534"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by fmviesa006.fm.intel.com with ESMTP; 08 Jan 2025 01:01:14 -0800
From: subramanian.mohan@intel.com
To: rcsekar@samsung.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: msp@baylibre.com,
	balbi@kernel.org,
	raymond.tan@intel.com,
	jarkko.nikula@linux.intel.com,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	lst@pengutronix.de,
	subramanian.mohan@intel.com,
	matthias.hahn@intel.com,
	srinivasan.chinnadurai@intel.com
Subject: [PATCH 1/1] can: m_can: Control tx flow to avoid message stuck
Date: Wed,  8 Jan 2025 14:31:12 +0530
Message-Id: <20250108090112.58412-1-subramanian.mohan@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Subramanian Mohan <subramanian.mohan@intel.com>

The prolonged testing of passing can messages between
two Elkhartlake platforms resulted in message stuck
i.e Message did not receive at receiver side

Contolling TX i.e TEFN bit helped to resolve the message
stuck issue.

The current solution is enhanced/optimized from the below patch:
https://lore.kernel.org/lkml/20230623051124.64132-1-kumari.pallavi@intel.com/T/

Setup used to reproduce the issue:

+---------------------+         +----------------------+
|Intel ElkhartLake    |         |Intel ElkhartLake     |
|       +--------+    |         |       +--------+     |
|       |m_can 0 |    |<=======>|       |m_can 0 |     |
|       +--------+    |         |       +--------+     |
+---------------------+         +----------------------+

Steps to be run on the two Elkhartlake HW:
1)Bus-Rate is 1 MBit/s
2)Busload during the test is about 40%
3)we initialize the CAN with following commands
4)ip link set can0 txqueuelen 100/1024/2048
5)ip link set can0 up type can bitrate 1000000

Python scripts are used send and receive the can messages
between the EHL systems.

Signed-off-by: Hahn Matthias <matthias.hahn@intel.com>
Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
---
 drivers/net/can/m_can/m_can.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 97cd8bbf2e32..0a2c9a622842 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1220,7 +1220,7 @@ static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
 static int m_can_interrupt_handler(struct m_can_classdev *cdev)
 {
 	struct net_device *dev = cdev->net;
-	u32 ir = 0, ir_read;
+	u32 ir = 0, ir_read, new_interrupts;
 	int ret;
 
 	if (pm_runtime_suspended(cdev->dev))
@@ -1283,6 +1283,9 @@ static int m_can_interrupt_handler(struct m_can_classdev *cdev)
 			ret = m_can_echo_tx_event(dev);
 			if (ret != 0)
 				return ret;
+
+			new_interrupts = cdev->active_interrupts & ~(IR_TEFN);
+			m_can_interrupt_enable(cdev, new_interrupts);
 		}
 	}
 
@@ -1989,6 +1992,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	unsigned int frame_len;
 	netdev_tx_t ret;
+	u32 new_interrupts;
 
 	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
@@ -2008,8 +2012,11 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 
 	if (cdev->is_peripheral)
 		ret = m_can_start_peripheral_xmit(cdev, skb);
-	else
+	else {
+		new_interrupts = cdev->active_interrupts | IR_TEFN;
+		m_can_interrupt_enable(cdev, new_interrupts);
 		ret = m_can_tx_handler(cdev, skb);
+	}
 
 	if (ret != NETDEV_TX_OK)
 		netdev_completed_queue(dev, 1, frame_len);
-- 
2.35.3


