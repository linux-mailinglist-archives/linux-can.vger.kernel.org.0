Return-Path: <linux-can+bounces-1849-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C619B7C1F
	for <lists+linux-can@lfdr.de>; Thu, 31 Oct 2024 14:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B500D1F21DF9
	for <lists+linux-can@lfdr.de>; Thu, 31 Oct 2024 13:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEAB1A0718;
	Thu, 31 Oct 2024 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="A6chTNt6"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47D1A00E2;
	Thu, 31 Oct 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382489; cv=none; b=lNb8nKzbfB7M0HFfJhh6mehWF6fRBnfbfYuUCmVsv+PEc49rarTZL2xNHKGRYHQjQPAk7yqcYO1Lmu08YbsZ0p8TOaPx6S+aXYUIaWvll+sfZEd9ehmTdwWDHJRCRjDZ12+aNi7zve/uBbQGHL479HYq4Bp1zlRdwipxzhaFVpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382489; c=relaxed/simple;
	bh=rxqIYUa/88KA7IdISu4c3kQ5I2OSOmVp9YvD7HCgSnQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Dk6j6NhZQlhHjL+48R3ABdDZKjIJrwPeD1kxPxQhGrjOmnVJV4XRBZLbZMrcMD2dMC2ZkPSzuuwZQft24ZqL8yaLscY0m7QTvt9412rvo2E5TL809y8xA8Vyn5F6MPovkRtF8yxh2AZ7vfkoLoDrlCKVcuFsDVytVYsETmZr6Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=A6chTNt6; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=/WX0zlVMGEjN7OmQYxz8QF0Yqk7Ydl3fEs/ezvkQO0w=; b=A6
	chTNt6iJIXWR1g9MryBelAZnCtfOKjj7Mromu1S+HYk8tO5Tx83lkTr+AKw+KFODIq/ISxkIY8iKz
	wCcgAsWqBCekLPRSAttJWEeOzCgizHSmyNnMqswuWGq3be+l4yPoOo6ngFZQVxJzelmd7QLJ+/mQe
	ecyp9iQWMS20GIMtPhOEeIg9Fz31EeYHRPhpSRvOQbje26oAX9e8O6i3rVEPgui5GoQEP+5VDABLd
	4cNQT5/9QwS85eLH24GnOdHYTaAJGvAE2zRYAGuHCW8btxtxftMpWyaY8Qi5siVMAhgGJCzsmqO8k
	qj6UEPd81/+B9Rv4tcU+omZJnonPejbg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1t6VAR-0005LO-Jb; Thu, 31 Oct 2024 14:24:51 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1t6VAR-000DTL-0K;
	Thu, 31 Oct 2024 14:24:50 +0100
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 0/2] can: tcan4x5x: add option for selecting nWKRQ voltage
Date: Thu, 31 Oct 2024 14:24:20 +0100
Message-Id: <20241031-tcan-wkrqv-v1-0-823dbd12fe4a@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASFI2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA2MD3ZLkxDzd8uyiwjLdZDOjJEsDMwMD05REJaCGgqLUtMwKsGHRsbW
 1AOmEH6hcAAAA
X-Change-ID: 20241030-tcan-wkrqv-c62b906005da
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27444/Thu Oct 31 09:34:36 2024)

This series adds support for setting the nWKRQ voltage.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Sean Nyekjaer (2):
      can: tcan4x5x: add option for selecting nWKRQ voltage
      dt-bindings: can: tcan4x5x: Document the ti,nwkrq-voltage-sel option

 .../devicetree/bindings/net/can/tcan4x5x.txt       |  7 +++++
 drivers/net/can/m_can/tcan4x5x-core.c              | 35 ++++++++++++++++++++++
 drivers/net/can/m_can/tcan4x5x.h                   |  2 ++
 3 files changed, 44 insertions(+)
---
base-commit: 2b2a9a08f8f0b904ea2bc61db3374421b0f944a6
change-id: 20241030-tcan-wkrqv-c62b906005da

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


