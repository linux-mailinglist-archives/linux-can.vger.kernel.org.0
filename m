Return-Path: <linux-can+bounces-959-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5FB92C153
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2024 18:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC63D1C23597
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2024 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235EF1ACA3B;
	Tue,  9 Jul 2024 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNXjNLgg"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E1E1ACA05;
	Tue,  9 Jul 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542427; cv=none; b=eH19nCo42PwB8Fm/geY1dqbnYERrg3SGthhtdP04+5Ar3lai1Y4SGMmjjkNRXox3uq8/Cd79KFJtNHne6lvtQKh1kkzb1ajAnjEf4A47NNLnRX3mcvxf8hzqL2hQWvtYAhKp4fcpCzUwOEmLBIPyvYTNPD0+1UuPn65k6T0KF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542427; c=relaxed/simple;
	bh=0VP+AH9neVUKwg4wvSYzQw+S15cNFQ0GW8YmXIa16Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrXQUIUiD/2zRIVZ/MhrwPPysK0rcgmWGBCnEmNjNrXYvq4RlYiUGoS2ZqQhbTzJnXWhLEC/7hEpE3A285297d4N1rNt65uNSh0LRpZGNh5f+qqNrlcksK53BZtrUxDWug3bWARz884gNcjlTFV4wFXcAMT1oPGQjdt2Tp7bqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNXjNLgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E3CC32782;
	Tue,  9 Jul 2024 16:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542426;
	bh=0VP+AH9neVUKwg4wvSYzQw+S15cNFQ0GW8YmXIa16Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNXjNLgg9Q80GdJPlvF0Ft+bVmj9uFIqbvyrOFtQRSKjxvucF74Q3UABgjMsJbd//
	 718J15MRd6hY7EsRvIGpB1B6z1A9bRnLFh7Dy1SyPcj0f5bvgKDkjAyV+Ngc6nVnXI
	 dXh8L9qVq3/GaoE+YVmddA/200wz3cHS/+wBpYbDsdESBeGXClnsoqhcmAXS9BQJM8
	 0Uu+BZmFEuTijf+sHdy65bUsICGqpdxbqwDzPjE2bSnZLZogE8AJDxTHhWnkmQ54m4
	 m/5AYI7+5NibG43a80Cm0pkDhEMhstjsHxclrg9umce+N1rCCc6AmzlbFusSvBoZNH
	 GCH3rN/2R6u8Q==
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
Subject: [PATCH AUTOSEL 5.4 05/11] can: kvaser_usb: fix return value for hif_usb_send_regout
Date: Tue,  9 Jul 2024 12:26:38 -0400
Message-ID: <20240709162654.33343-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162654.33343-1-sashal@kernel.org>
References: <20240709162654.33343-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.279
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


