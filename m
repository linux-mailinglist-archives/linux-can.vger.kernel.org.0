Return-Path: <linux-can+bounces-2067-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582919CDA52
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2024 09:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044881F21F0E
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2024 08:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B648118E047;
	Fri, 15 Nov 2024 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="wgC35Cof"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871892B9B7;
	Fri, 15 Nov 2024 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658573; cv=none; b=U6v8umlPY8BOMiBEsF9n5yZU8uOSSalL49L0LdpsQdCT+dtb/9KEKODLDK8lqt1kfM5H+9DBZluacLVIQstbs+aUC+ewUmZzV/sVaVvmP9Vxqf+pul1RTatfz0LuxUHP45IBJlsJ6Os7N7AQQAuBSsyNpJkSXMB9JItUN068cfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658573; c=relaxed/simple;
	bh=3MaTfz9vKg5ddw0x1Troqp+Sbb3jlKZPB/N3CnTHdCQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SU2BvFunQ8IHw7oEoNbXDsr+Y5aDwF46x6a2kiYe/8XSIq8zVHXk+K+iy+A7WJa3sPIlHKqEA7mRi6J+h965xbzyQ1Rjh/iYRgVE2JM2C/fycr4LsZkHLDlKWxUe6bMTqnpdDJIbUxTUPkPgDGyeYaZoe+Jc16qVdhFqFhzCvR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=wgC35Cof; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=tTPtQK1NCkLAPABO4dZNnXzsuLZ7kmUQYx4HlyChATk=; b=wg
	C35Cofb8mnR82uO9my+6Ege0BWqOToXViD2uGtYsVIntnbB9HIGpquVRH8mj0e8KbKANNd46XUoN6
	ockoiIhg+ygx0hdEOo7Qo8CNjrT//Bn677bTyXqzUTvJfCaaBmse0YeCtU9+CnnICWG6GKqGU+JZv
	0GKjtEjaWqnmR65Cej91m1SLlGBPZyFhRZo+N7zfeEcV5i4lIQfYo/GEwMCGUzdcUw/q31fm/LE4L
	i8IRjUttNQohQ9eUmOH0Z1WFMRi9+WSDEN9uOd6WiunouScpEswq0z5B+hSfIp7Dbr00eYS/amWen
	x8hbaenZsrdOCDD2TskU/kZa9Rtt6efA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBrUj-000NV9-Pg; Fri, 15 Nov 2024 09:15:57 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBrUj-000OuX-0s;
	Fri, 15 Nov 2024 09:15:57 +0100
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH can-next v2 0/3] can: tcan4x5x/m_can: use standby mode when
 down and in suspend
Date: Fri, 15 Nov 2024 09:15:49 +0100
Message-Id: <20241115-tcan-standby-v2-0-4eb02026b237@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADUDN2cC/1WNwQ7CIBBEf6XZsxiWalBP/Q/TA9Cl3YPUACFtm
 v67WE8eJ2/mzQaJIlOCR7NBpMKJ51CDOjXgJhNGEjzUDEqqC6LUIjsTRMomDHYVA/n2etMarbJ
 QJ+9InpdD94RvMdCSoa9k4pTnuB4/BQ/+UyL+KwsKKfy9bTVZ44hMN5IJvJzd/IJ+3/cP6aBLo
 LMAAAA=
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27458/Thu Nov 14 10:38:08 2024)

When downing the tcan4x5x there is no reason to keep the tcan4x5x in
"normal" mode and waste power.
So set standby mode when the interface is down and normal mode when
interface is up.

Also when going into suspend, set the tcan4x5x into standby mode. The
tcan4x5x can still be used as a wake-source when in standby as low power
rx is enabled.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v2:
- Reduced code in tcan4x5x_deinit()
- Taken care of return values from deinit callback
- Link to v1: https://lore.kernel.org/r/20241111-tcan-standby-v1-0-f9337ebaceea@geanix.com

---
Sean Nyekjaer (3):
      can: m_can: add deinit callback
      can: tcan4x5x: add deinit callback to set standby mode
      can: m_can: call deinit/init callback when going into suspend/resume

 drivers/net/can/m_can/m_can.c         | 25 ++++++++++++++++++-------
 drivers/net/can/m_can/m_can.h         |  1 +
 drivers/net/can/m_can/tcan4x5x-core.c |  9 +++++++++
 3 files changed, 28 insertions(+), 7 deletions(-)
---
base-commit: 2b2a9a08f8f0b904ea2bc61db3374421b0f944a6
change-id: 20241107-tcan-standby-def358771b2b

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


