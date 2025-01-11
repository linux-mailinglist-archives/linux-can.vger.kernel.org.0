Return-Path: <linux-can+bounces-2593-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E397A0A068
	for <lists+linux-can@lfdr.de>; Sat, 11 Jan 2025 03:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A1E3AB510
	for <lists+linux-can@lfdr.de>; Sat, 11 Jan 2025 02:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A967E0FF;
	Sat, 11 Jan 2025 02:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdIP+S+l"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFA4139D;
	Sat, 11 Jan 2025 02:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736563669; cv=none; b=CBCk0jMyduo9vRK9Wd2/zJTY1if+RLUyzvWh98gpnwBz/CUdrImKwTeUSYeVNI9eXVT1CGo78BM20XP5OLuOYtDse+guf2rEO+mbMwi/M1kSgAyzfRqoPR6W1Z05pN6FYtUCUJxTR+0WRN5ieZP9Er53m9ciff9hYa3iWS15uKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736563669; c=relaxed/simple;
	bh=8Eymkj3tuckJY/wY4i/3Jszm9EfpEcl02JuSk3Y6ONE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMaHL9xPBmN4MTYv7SJ+dTbIP8uYDXOJlHKNVjoKEG860yeqXvICjM/lAWM0VHXhmsxLzVY+knaUrj79HCFCLaUzfAEgQb6VZZlZ5odiNxZeBVsnlOjqWVLtjnH10Nl8TaEBDLnP1bH/anMFx3FQZPRoCTHGwt+sl39iw77YYvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdIP+S+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF681C4CED6;
	Sat, 11 Jan 2025 02:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736563669;
	bh=8Eymkj3tuckJY/wY4i/3Jszm9EfpEcl02JuSk3Y6ONE=;
	h=From:To:Cc:Subject:Date:From;
	b=jdIP+S+lFehhLvAd7WjjniYIEkaIJhkKUK/3c0yhJCdnyPQ3EGmjOQFyC0N/K2FTu
	 0sMl8g38X+/5WR2d43D1+TZx6b70vmE0/cbOG9MGrJ5lWgS15WtKNL4CFcea9eu8R5
	 PHekfxPdRrLnVBmtvVauSb/LHCftOgrl7QbvdoMnFA9wiUNRpD0JxW1HDMg5flJ7Xa
	 asUX7zDG+UzBLiB357NI7KPQ60NRf8zia/seDCa/I7QsbgrHto6tppgurytm+SW/NF
	 +akqyqtBBU6cAkc0uEVF4nXY19Wq+lbJHSkTz1ru9gcP8gD/DZTn1c5IBZf8WTO1ht
	 WFdx7/BtAkesA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	linux-can@vger.kernel.org
Subject: [PATCH net-next] can: grcan: move napi_enable() from under spin lock
Date: Fri, 10 Jan 2025 18:47:42 -0800
Message-ID: <20250111024742.3680902-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I don't see any reason why napi_enable() needs to be under the lock,
only reason I could think of is if the IRQ also took this lock
but it doesn't. napi_enable() will soon need to sleep.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Marc, if this is correct is it okay for me to take via net-next
directly? I have a bunch of patches which depend on it.

CC: mkl@pengutronix.de
CC: mailhol.vincent@wanadoo.fr
CC: linux-can@vger.kernel.org
---
 drivers/net/can/grcan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index cdf0ec9fa7f3..21a61b86f67d 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1073,9 +1073,10 @@ static int grcan_open(struct net_device *dev)
 	if (err)
 		goto exit_close_candev;
 
+	napi_enable(&priv->napi);
+
 	spin_lock_irqsave(&priv->lock, flags);
 
-	napi_enable(&priv->napi);
 	grcan_start(dev);
 	if (!(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
 		netif_start_queue(dev);
-- 
2.47.1


