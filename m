Return-Path: <linux-can+bounces-958-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADAA92C137
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2024 18:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81CDCB2D2CF
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2024 16:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9831A653B;
	Tue,  9 Jul 2024 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyuCRDb2"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C51A6501;
	Tue,  9 Jul 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542390; cv=none; b=t6RVq2LGkXXKiTqdCoUejt3AHs8iuOgNyrsIKYatGOA437fCkPnmfeGtXVPqCuZc4O51NMSkOhEMcVcaIyGTThJ0IAgRULybnpd6U9FRNqrzr5bkp2EsOxUlNH58hAXfgl2zwwCPcG4lgZVpfGGhtjCUIZ0/KMUmPU23GDujoqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542390; c=relaxed/simple;
	bh=0VP+AH9neVUKwg4wvSYzQw+S15cNFQ0GW8YmXIa16Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwX5g5YAQVWzvAcA8W6yH51N1s8w9IEYOf3mh3Qp9CIvxbHKZWpG02MQpTy4+vtF1cRdZT228lgQz2MZyqkpjkwE0nHdz1JBQpLDMWO/b2NQczpT8ysKuJ8RxCKjKnHmOFysedb3toAiFSC9iZcTbKOI5lbfNeyCZ6qCqgNGndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyuCRDb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE68C4AF0A;
	Tue,  9 Jul 2024 16:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542389;
	bh=0VP+AH9neVUKwg4wvSYzQw+S15cNFQ0GW8YmXIa16Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GyuCRDb2yl42dRaPsy0X4/76CehHZaMkjMBKsynpRYpX/X1JMuhISEWDGIKDwzqEP
	 G9K23r8wHBE1L8hboQYMfQ+YiDeW/oRSfkRSAwjZeDeaSGwk4S56llnDpIel0mjZjx
	 lQSuS5G4ODEzsv2Ay9YK2Kmd9l34WJ7K89xOF8lIqHdynBLUpdE9GoLva8AS1EKVX4
	 G2MDXn7YQLQsb4gKPJ9ON2+Au4rkN35xi5vrO8ZrADWYaTDW3u41YJ/5xVqtn8jHVp
	 gTFIBnNR6Br35jmEKISBwLsiMdVTn0PjcbtJbjPXX7SLcY4AYI7AkzIu9ziXX4WmMR
	 +SCdn44ToxUAw==
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
Subject: [PATCH AUTOSEL 5.10 07/14] can: kvaser_usb: fix return value for hif_usb_send_regout
Date: Tue,  9 Jul 2024 12:25:51 -0400
Message-ID: <20240709162612.32988-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162612.32988-1-sashal@kernel.org>
References: <20240709162612.32988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.221
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
index 1f015b496a472..a26103727fc3e 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -265,7 +265,7 @@ int kvaser_usb_send_cmd_async(struct kvaser_usb_net_priv *priv, void *cmd,
 	}
 	usb_free_urb(urb);
 
-	return 0;
+	return err;
 }
 
 int kvaser_usb_can_rx_over_error(struct net_device *netdev)
-- 
2.43.0


