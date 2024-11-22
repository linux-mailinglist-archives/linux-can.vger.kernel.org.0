Return-Path: <linux-can+bounces-2179-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2019D60E1
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 15:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46341B281D2
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 14:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A1B146A69;
	Fri, 22 Nov 2024 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Xng8Dcjw"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884EA7081B;
	Fri, 22 Nov 2024 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287182; cv=none; b=KoakrB1xddmaj7qfo+WV61XbClLj7Wpdwf5BhV9iQlOVKKfFBJgglruf+p55dRm3Z+xKvh18PSM8OmDZ4tIDqH3MrST5PKs3LhVJo7swlcxePCU+xalgFGFCdXXVL1spqJvfii3lFvG28nJo3gMmDnmgfFAGe3JuNWAf2gRGXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287182; c=relaxed/simple;
	bh=hIZ/xDPyN/1QHmTijlYLd6msZPWHwDvrTt3hWM2PkCc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jmm+plPfPJBxnhPct9O6r2I/mu1a+WJ040UMqi0rmQ/u9cxInFJjneQsd+hDkzvPKfT9aNQkiyrsrzlJ/FE2Tipm/0MldUE4UCNKljxaxny4kZ2S/O9nwPP9BUoi194kGQf5Pm9YRilyLtvBprwF/3fAlZzpBEW0WNhq6g/3voA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Xng8Dcjw; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=sqvgtVEOVfoQ6/LkzH6KDQcRvaoEUvwUSz00hqpnSEs=; b=Xn
	g8Dcjw/fu959XMnoRvIRZTmyJdRXsW3DFe2v/CR1tlv+SpJC1RKHGxFUQni1FAbLNt3ZK/Oo4qyZB
	sT+biwVHvAYPeHMiWmfnwU4JChP8K9R8QI+75bWfeWleELEaaXIoSgBbbLiD9bfucFji/KsVOZYPD
	OWUZY2KRYlUYqxABcsZKeWrAmHig6Eik+ZzguAxKPsR+jjAMjevhEaGVxxo/YW2ZnwwLwMvbYwMlk
	07Y0WZE5UnZgGLBZpiAvnDMbGDsNrkyvTtWMzBZVNHmZEhQfS7WAx//DLHCtyvp90tfg79i7mJhFO
	f5SxAmxI2kZkVcHH/YaWjB5boGVOSZPA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tEV1W-000KIC-1U; Fri, 22 Nov 2024 15:52:42 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tEV1V-000HFz-2d;
	Fri, 22 Nov 2024 15:52:41 +0100
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH can-next v3 0/3] can: tcan4x5x/m_can: use standby mode when
 down and in suspend
Date: Fri, 22 Nov 2024 15:52:21 +0100
Message-Id: <20241122-tcan-standby-v3-0-90bafaf5eccd@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKWaQGcC/12NzQ7CIBAGX6XZsxh+WlFPvofxAHTbcpAaIISm6
 buLeLEev8zO7AoBvcUA12YFj8kGO7syxKEBMyk3IrF92cApbxmjkkSjHAlRuV4vpMdBdGcpmeY
 aivLyONhcc3f4HDrMER6FTDbE2S/1T2KVf5OM7ZOJEUqGixAStTKI6jaicjYfzfyspcR/7e7P5
 sVuUdOCT5oLubO3bXsDFyKugfEAAAA=
X-Change-ID: 20241107-tcan-standby-def358771b2b
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27465/Fri Nov 22 10:41:26 2024)

When downing the tcan4x5x there is no reason to keep the tcan4x5x in
"normal" mode and waste power.
So set standby mode when the interface is down and normal mode when
interface is up.

Also when going into suspend, set the tcan4x5x into standby mode. The
tcan4x5x can still be used as a wake-source when in standby as low power
rx is enabled.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v3:
- Run deinit in m_can_stop() in any case even if m_can_cccr_update_bits() fails
- Link to v2: https://lore.kernel.org/r/20241115-tcan-standby-v2-0-4eb02026b237@geanix.com

Changes in v2:
- Reduced code in tcan4x5x_deinit()
- Taken care of return values from deinit callback
- Link to v1: https://lore.kernel.org/r/20241111-tcan-standby-v1-0-f9337ebaceea@geanix.com

---
Sean Nyekjaer (3):
      can: m_can: add deinit callback
      can: tcan4x5x: add deinit callback to set standby mode
      can: m_can: call deinit/init callback when going into suspend/resume

 drivers/net/can/m_can/m_can.c         | 22 ++++++++++++++++++----
 drivers/net/can/m_can/m_can.h         |  1 +
 drivers/net/can/m_can/tcan4x5x-core.c |  9 +++++++++
 3 files changed, 28 insertions(+), 4 deletions(-)
---
base-commit: e0b741bc53c94f9ae25d4140202557a0aa51b5a0
change-id: 20241107-tcan-standby-def358771b2b

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


