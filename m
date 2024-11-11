Return-Path: <linux-can+bounces-1953-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D10A9C3CB6
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 12:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E98A1F224AF
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 11:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA45189F2B;
	Mon, 11 Nov 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="BTN3qrl8"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B882D17C7BD;
	Mon, 11 Nov 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323330; cv=none; b=n5lsCbABxGPeYYyPOpqal7+Yo7/PA+NYSbAfCiRPnOnw5zXbDHk1Z9KD4l12rYDpYQr4fnk2Ibk9CSGBFzz0+k56ZaHy1eB4DTswyaUF6W+PhuHIiQrrsPzMfjAps2Pgqo/2LzEkt/0c/LQa/XDhY3MceJVMtlHU49qV352uv9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323330; c=relaxed/simple;
	bh=fTnBKWroAyibFZ32vMLmU6CwNgFakXylqSPOxlmzdyo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G7JRE8XFBnpjrDCB1YwtXAySNGEOoTdaoxxSmOwTqZWy/dY6WCqXQZPDRD257Ka4Pe+yq+hCqE/O63CEZMs4VptCAgO6z43tr6YhTYcZLxG/9jwn70qfMh1injGxD5B9m1ZD29lcUWuU3p7Z2djCUrhvI9Q2gH0peh7b16PcKCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=BTN3qrl8; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=DAZ9kB/NRO4q+atx8mADsxFS6yrC9e9RVvCP2RbOVa8=; b=BT
	N3qrl8Rn63I1aZUCGF1QQFIlWmQTduTRzSnj2zbzjdqNKagNh+7hHoap2Y4WS2Lst3j9ofY+hZ7XJ
	Xm3WKtDT3DA2m/mokYjT5PNUv+cPTcbEwFzuced2RkvXusFEa6nnmOgGd5hIRUwjjXtADfPN00jkv
	5ahp/F6wXoSt2OZGJaJQsRjHO36eyFZCsd9fbCgE8pWcAiq0YlIPvVSOPTMwHwu3PUDzIEneQgss/
	FNjd0dAOiNCxQ8JRyacSHKUYQqKkjc/EuyrWSbGetrQ4ZfWpuf3cacvPuuMWggBhPCh25aL1u2Mdd
	FxeljhDMet7DqILPXYUYWma50eP40pDQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tAS19-0000iw-Ln; Mon, 11 Nov 2024 11:51:35 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tAS19-000JnT-08;
	Mon, 11 Nov 2024 11:51:35 +0100
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 0/3] can: tcan4x5x/m_can: use standby mode when down and in
 suspend
Date: Mon, 11 Nov 2024 11:51:22 +0100
Message-Id: <20241111-tcan-standby-v1-0-f9337ebaceea@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKrhMWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwNz3ZLkxDzd4pLEvJSkSt2U1DRjUwtzc8MkoyQloJaCotS0zAqwcdG
 xtbUA5hW7Il4AAAA=
X-Change-ID: 20241107-tcan-standby-def358771b2b
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27455/Mon Nov 11 10:58:33 2024)

When downing the tcan4x5x there is no reason to keep the tcan4x5x in
"normal" mode and waste power.
So set standby mode when the interface is down and normal mode when
interface is up.

Also when going into suspend, set the tcan4x5x into standby mode. The
tcan4x5x can still be used as a wake-source when in standby as low power
rx is enabled.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Sean Nyekjaer (3):
      can: m_can: add deinit callback
      can: tcan4x5x: add deinit callback to set standby mode
      can: m_can: call deinit callback when going into suspend.

 drivers/net/can/m_can/m_can.c         | 10 ++++++++++
 drivers/net/can/m_can/m_can.h         |  1 +
 drivers/net/can/m_can/tcan4x5x-core.c | 12 ++++++++++++
 3 files changed, 23 insertions(+)
---
base-commit: 2b2a9a08f8f0b904ea2bc61db3374421b0f944a6
change-id: 20241107-tcan-standby-def358771b2b

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


