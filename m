Return-Path: <linux-can+bounces-3928-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E51AAED631
	for <lists+linux-can@lfdr.de>; Mon, 30 Jun 2025 09:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3562164691
	for <lists+linux-can@lfdr.de>; Mon, 30 Jun 2025 07:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32062238151;
	Mon, 30 Jun 2025 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="jo+VDgf5"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC6B237704;
	Mon, 30 Jun 2025 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269998; cv=none; b=gKsjbTs0cX11YIJygEIGa9uOotxsEChMrRRMR5hYXwt4dWWCXhlCmJFOt3XiN/jRJxDBBjJxGcJJHXvyV/1/dgmgdgkrOM3SdEXa/iFlqecFj2kG3paqlFLUe29LCgoC5IYelNRRfydt2MGYqrUsz9WDlVrN/ZU9chAlrawTeKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269998; c=relaxed/simple;
	bh=43trQA6JGX0q1DkUsOqI2l4Rd2xx3J+EmFJrrvGcEmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iUWAKMasNhDAvfiSSj1NvO1l1N71w1w7u1U93aE7LX/fwge/RH9a3xhYo+Sqn6v/XtE8yJ0MON21gpG5RFVfwM4XRCEsOrr4H/t53YtFRPRdJgxOoNc1+U+6NZQXl6tZ3lTOfqFSWFLB7VJshoRxNrl30jxPf8/d52Rs+74+WRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=jo+VDgf5; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751269975; x=1751529175;
	bh=e5HFJV7m/E4MoUGLl0jUTtR9BOfcOHJtokCPnk30wuw=;
	h=From:Date:Subject:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jo+VDgf5qezUy/YQSZMw1m4mkYN9Zrp4+7S0iKD2JEHBRwp3EBwCwiZzUqA7G11Ai
	 H102tz3RbQTc0z0mvbQLjgakWC7q4czR+rPjSj3MMxD5prwGZ5+sC7D+uu4mow/5gH
	 FqVqv0DTXFaxx5PfwFOV6Zb//zCYJg3kJJvof8VXWhTAzuff3pxFJygh82byWjAA5H
	 AWW0UwfVhji4cTQfOMf2stBSuckfWeDDspZhAX2ButvqyoVOdRhx/ffdxmd3l3P4Pu
	 oRBTe79E6Wgg4xzowCgeubsD6xNgh22Y1wPv541wmejWKrwe9JvxfUmMWFiWYaI4Re
	 3N7vrpl6/UNlg==
X-Pm-Submission-Id: 4bVz0f0s7GzB53
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 30 Jun 2025 09:52:44 +0200
Subject: [PATCH v2] can: m_can: apply rate-limiting to lost msg in rx
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-mcan_ratelimit-v2-1-6b7a01341ea9@geanix.com>
X-B4-Tracking: v=1; b=H4sIAEtCYmgC/3XMSwrDIBSF4a2EO65F7cOmo+6jhCLmmlyoGlQkJ
 bj32sw7/A+cb4OEkTDBvdsgYqFEwbeQhw7MrP2EjMbWILm88KvkzBntX1FnfJOjzFChsP14s7o
 30E5LREvrDj6H1jOlHOJn94v4rX+pIpho3lkhnrhVwj4m1J7WowkOhlrrFwtJ7QWtAAAA
X-Change-ID: 20250620-mcan_ratelimit-e7e1f9d8fa9c
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Fengguang Wu <fengguang.wu@intel.com>, 
 Varka Bhadram <varkabhadram@gmail.com>, Dong Aisheng <b29396@freescale.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

Wrap the "msg lost in rxf0" error in m_can_handle_lost_msg() with
a call to net_ratelimit() to prevent flooding the kernel log
with repeated debug messages.

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v2:
- Changed to dbg msg
- Link to v1: https://lore.kernel.org/r/20250620-mcan_ratelimit-v1-1-e747ee30f71f@geanix.com
---
 drivers/net/can/m_can/m_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 6c656bfdb3235e1f5d6405c49b07b821ddacc1b9..9f43111609d364c01c6df10489fc4708deab9fbb 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -665,7 +665,8 @@ static int m_can_handle_lost_msg(struct net_device *dev)
 	struct can_frame *frame;
 	u32 timestamp = 0;
 
-	netdev_err(dev, "msg lost in rxf0\n");
+	if (net_ratelimit())
+		netdev_dbg(dev, "msg lost in rxf0\n");
 
 	stats->rx_errors++;
 	stats->rx_over_errors++;

---
base-commit: db22720545207f734aaa9d9f71637bfc8b0155e0
change-id: 20250620-mcan_ratelimit-e7e1f9d8fa9c

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


