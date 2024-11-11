Return-Path: <linux-can+bounces-1947-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DA39C3A3D
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 09:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC6B281551
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 08:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765E916F0D0;
	Mon, 11 Nov 2024 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="aBT1mmxC"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AE1662FA;
	Mon, 11 Nov 2024 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731315323; cv=none; b=a5D9/8cOuuxx+AaY/w8511U/OJ6oV/c7gqxMgHghZJ25vsQnmzhHR+h/zWOtBwQlM/V5FFQP3kqnTEeYJIHUtfsGGhWaCk2L+TjHoqs1rjD5pbA4+7/QM8uQWG9/7ZlrSHpbfARLOO7MosBxPWJB4tTM7wCu7qIXLvYHYRLCYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731315323; c=relaxed/simple;
	bh=vImf0sA5riq0WF7KE4d6yEm3YzSNUorhQRg1MjeTB24=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NX8mL/gNdbSp5bNhTRKSA8CR5MQUCUOoCUt5aMbfftv0DMjNx5G3wTIK6A5XDNaDHx8aDTk3t+KGVucTig21rC0tgwNpC0cpK6GfWjnOqOOQPlG7/dleSN2IGcU+Lk2TrohAxEtsT53GTx+wuR2+qqOTxrC7uV22Oqcp/najdis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=aBT1mmxC; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=Xod8IIugEE8GAGPvkEgpU7xU4C05DUpCikeTF13nrqM=; b=aB
	T1mmxCcbuaYTawlICP4HpaYAXnft6aCGMx7KMQQMZNZfWGCs/L7vgTN12WFqXcQHB8OsOrWgE9jFw
	ow3ha4qGZMZygwJDlgsTEFiBOhpKTDPhMcYA7OEGOcbBQJcMou6Cuxs3AZXrci9yZv1CNomTq0kk4
	1CrIPHHAmAITY9Et9+R/JfDNtfcqrQJYAZnIFUaij9oAsVhRsQ66ssT55pdnJb27ArVliLBLIbpwj
	TR/JdHIzdW9+B2TZjr1iLSCZO63KKSsWoiXCBFCXHFs37wW4ce60OyvS2OTRm4ihPiY6U935cJitE
	BWKdx3TT3qdL/sScROYDLucMQvcjAazQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tAQCV-0005w2-GL; Mon, 11 Nov 2024 09:55:11 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tAQCU-000LxI-2T;
	Mon, 11 Nov 2024 09:55:10 +0100
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v2 0/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
Date: Mon, 11 Nov 2024 09:54:48 +0100
Message-Id: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFjGMWcC/02PS27DMAxErxJoXRUULat2Vr1HkYU+VCIUthtJV
 RIEuXvpGEW7nAHn4fEuCuVERex3d5GppZKWmQO+7IQ/2flIMgXOAgG1gg5k9XaWl898btIbdCM
 YgD5YwYOvTDFdn7CPA+dTKnXJtye7qbX9xaj/mKYkyAG74ILCSNq+H8nO6frql0kcHhs40/mb5
 epG/3Nj1RWpoJd+mRvluqG165XRqMlHs2+46jlbiI+mKVVeObSjhSEOEfgJTRadNyq4rnvTGpW
 DOGptDQs8fgBieb3YJQEAAA==
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27454/Sun Nov 10 10:45:07 2024)

This series adds support for setting the nWKRQ voltage.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v2:
- Converted tcan4x5x.txt to DT schema. In
  https://lore.kernel.org/linux-can/20241105-convert-tcan-v2-1-4b320f3fcf99@geanix.com/
- Reworked ti,nwkrq-voltage-sel, to DH schema style.
- Link to v1: https://lore.kernel.org/r/20241031-tcan-wkrqv-v1-0-823dbd12fe4a@geanix.com

---
Sean Nyekjaer (2):
      can: tcan4x5x: add option for selecting nWKRQ voltage
      dt-bindings: can: tcan4x5x: Document the ti,nwkrq-voltage-sel option

 .../devicetree/bindings/net/can/ti,tcan4x5x.yaml   | 13 ++++++++
 drivers/net/can/m_can/tcan4x5x-core.c              | 35 ++++++++++++++++++++++
 drivers/net/can/m_can/tcan4x5x.h                   |  2 ++
 3 files changed, 50 insertions(+)
---
base-commit: 2b2a9a08f8f0b904ea2bc61db3374421b0f944a6
change-id: 20241030-tcan-wkrqv-c62b906005da
prerequisite-change-id: 20241105-convert-tcan-4b516424ecf6:v2
prerequisite-patch-id: a652b1a16dadd5ff525d0b58fec56f605a976aa3

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


