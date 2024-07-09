Return-Path: <linux-can+bounces-957-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4101492C0EF
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2024 18:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7288C1C22BFE
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2024 16:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2553B18D4CC;
	Tue,  9 Jul 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctIWyDtd"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE6B18D4C8;
	Tue,  9 Jul 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542336; cv=none; b=ME00a16amfCkns+Cf6K6Z3FX/yYU83p+HmVyBPsUkSzRHBjpszpYj+gmUJJsJsvuvZ/b8rHGQhdhvYidDKmTGfAZBHypEItpwuN3GrjZ6LLunD30C5WsksDgcf+MnDu+qHwRa5nrppNcZ3RG4fsXqv/3URO0jFi31UDpcSDeaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542336; c=relaxed/simple;
	bh=k9LrWFVxAszloHBi6WEwLha/Pfjh2z2Rh6fnIf+ZWCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1LejM46HoyHdptGExtgCKE5qFhvsP+B5SnabzRCYehndWxg3ZjWbHpSTfTh27RRzoyHdZQ69tuU3cDZbYj6bc/KuOEG2cF9RP5LqJjGbcJKOzhembZsGC5u4HDuNhde8U8/3isFUWVKkLdemlMVpxiNlFvdT79kycUX3Pf5eZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctIWyDtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25411C32782;
	Tue,  9 Jul 2024 16:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542335;
	bh=k9LrWFVxAszloHBi6WEwLha/Pfjh2z2Rh6fnIf+ZWCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctIWyDtd9gP2lhbkJo/wJbHiTXlF99xjHPWL60GChl5A/pgYXnfW1zwxHm6f0tll4
	 P1tvnIIznYi1ww+Iu8t3MVSBksC5PiZpIKFgCmTT13NCB2I07CaVV5SUhLjbRdsemV
	 cUJPD+OwmuEhK17a6tuagQaUCtmFypsc9JWTVLNs25YSnyo088jwyRima6zIOtKeZg
	 90HfOqrj8guZl3++uNd9ARyRD9yZ0qx8TjC0VnUR2+q7wpoHH9TkG5fxNU8Zc//eoq
	 pZ1RmJSpsgQLdvvvjFQmDMqt4ndytaaqw7Z+9cCW5TiglINudLdchW0zAY1S7bfZfW
	 UFFniOAcMcYcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	mailhol.vincent@wanadoo.fr,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	extja@kvaser.com,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 07/17] can: kvaser_usb: fix return value for hif_usb_send_regout
Date: Tue,  9 Jul 2024 12:24:51 -0400
Message-ID: <20240709162517.32584-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162517.32584-1-sashal@kernel.org>
References: <20240709162517.32584-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.162
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 0d34d8163fd87978a6abd792e2d8ad849f4c3d57 ]

As the potential failure of usb_submit_urb(), it should be better to
return the err variable to catch the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Link: https://lore.kernel.org/all/20240521041020.1519416-1-nichen@iscas.ac.cn
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 09dbc51347d70..41594cac54966 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -292,7 +292,7 @@ int kvaser_usb_send_cmd_async(struct kvaser_usb_net_priv *priv, void *cmd,
 	}
 	usb_free_urb(urb);
 
-	return 0;
+	return err;
 }
 
 int kvaser_usb_can_rx_over_error(struct net_device *netdev)
-- 
2.43.0


