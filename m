Return-Path: <linux-can+bounces-5250-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507A8BF779B
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 17:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A6F188B6F3
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 15:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14FA3451CD;
	Tue, 21 Oct 2025 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCiVa+qy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E283451C7;
	Tue, 21 Oct 2025 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061671; cv=none; b=a2JW0aM72Jmu6fm7p7UYDHqz5Xjx3CjR51AP7HolsxfeCldFY6by8gfrdEf/FoqzBrXpLeFZ9igBW0ZAYTh+W35GSg9wYqRQwglKhpRMk7UwdT0U49NW5ypir956FFnfOYKrFmuoEK9UFhHp8q1mxLed6dszDuJJKIiVRgOFQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061671; c=relaxed/simple;
	bh=yloHVT/ZWbwsMdentgq3wkJfJDSHxtJH/8vBDr2zvH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=flRkD98oZrFWvws2RHmfwOBbZJdbGJLoLJAX5URGoMgr8pPw9GxgGB7nwedt015odzQPo6zstKpjUd+JYp9g8M/AAjN/blRhR3mW+p/o4rTLTDCSwZLcY8TMBdk/jJpDEF4esqQKh6ZHcqlx/uFBceedMd2JyaEzK7UBx/hkqC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCiVa+qy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A42C4CEF5;
	Tue, 21 Oct 2025 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761061671;
	bh=yloHVT/ZWbwsMdentgq3wkJfJDSHxtJH/8vBDr2zvH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pCiVa+qyjSv3Zic1X1H0Ej2RTae+/7SlKzt0iMWsMNXEBw8vXJsG3HW2G5S0M0MTH
	 XXYPe08W/TMjWNK5j5R+FEdYypKXFgF6PmT7EJSKAAydRhlASrtQ40FbqZuyyeI53s
	 9/ioUhKnyY/RRIvRhJMfOlIBD0vGuUORcJeNL6j2z8Cs3tIKsO3W6Lmd0sFsMXwLB/
	 Zfw73uo+fWtlT6tg5ITfl5s6+uFwbPyoG+lm9qhgS+sn6LtOrtXkUkJcQzy/ShObxf
	 /HLWZaAF8EOv+ppgpkuOU14dGeZ2ITJHgURm6QSBoNgQ+VmPMuf2LMUJxXXBJPWjv8
	 6MsoDgJTjXIPg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 21 Oct 2025 17:47:01 +0200
Subject: [PATCH v2 01/10] can: bittiming: apply NL_SET_ERR_MSG() to
 can_calc_bittiming()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-canxl-netlink-v2-1-8b8f58257ab6@kernel.org>
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
In-Reply-To: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=yloHVT/ZWbwsMdentgq3wkJfJDSHxtJH/8vBDr2zvH0=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnfVzP7H3P+of8xdP3kmSnOv3fOYnDcIXb/XVVN2vXrO
 1amizfod5SyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZjIkhuMDPPq5Bbur3yftXj/
 iuT7JX8EZur6imxrj4++X6b5LTKn6icjw7F5KjPu3rGQ9fL99artyS7pxMipPImx618Kr08oWny
 knxMA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

When CONFIG_CAN_CALC_BITTIMING is disabled, the can_calc_bittiming()
functions can not be used and the user needs to provide all the
bittiming parameters.

Currently, can_calc_bittiming() prints an error message to the kernel
log. Instead use NL_SET_ERR_MSG() to make it return the error message
through the netlink interface so that the user can directly see it.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

  v1 -> v2:

    - New patch.
---
 include/linux/can/bittiming.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index d30816dd93c7..3926c78b2222 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -141,7 +141,7 @@ static inline int
 can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		   const struct can_bittiming_const *btc, struct netlink_ext_ack *extack)
 {
-	netdev_err(dev, "bit-timing calculation not available\n");
+	NL_SET_ERR_MSG(extack, "bit-timing calculation not available\n");
 	return -EINVAL;
 }
 

-- 
2.51.0


