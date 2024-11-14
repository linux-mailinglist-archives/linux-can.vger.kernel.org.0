Return-Path: <linux-can+bounces-2037-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1A99C85CA
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE121F21E8E
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD38B1DE2AC;
	Thu, 14 Nov 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="FeIHjFDY"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E71D1DD543;
	Thu, 14 Nov 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575704; cv=none; b=P9QNzJbe1S/u6vTHXwRXQyMX5FaiffK7Yen/9ep1/H8YUQcjesS5p/5g92C9clBDeRpoo5JJoU87usu/OEWHOxLbnGLtETA/Di/IZUYqsksz3n+xWQOGw0THXuz/EbUPxh6FVaK01fUv/GccitN/LTaveeUbB8K2f/XFHwC7UPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575704; c=relaxed/simple;
	bh=UfZDXQ2N8w93v1N5a0BWt8ollotHB3gJFv86MwPBrhA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P/BYiETr/lWkaxQPLrTpYFFHHSpwarsFg4woFNbXkLbV3Va710nXoVvY2+3dba2/7FwLKR9ZKaUjeE3vRV4gbwIYH472v6p4VtQIbYwP65+ZaSaaSah0gFDHdYTJ+F6UhpkjKEj3fLIBz/wPEFW8YGMMoBM2C0227rYq/quaqGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=FeIHjFDY; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=J0UQfna7jNLbeDrAuqNbxUqtTKKRn32cspLm+dU2JaY=; b=Fe
	IHjFDYsII8n6iEGL68IIOmZbTAHRsFIOn3YO50mXNCVVzEKzgN9n7MiqSA6Gih7Otfqp7WwVOFG9D
	CKEYHPfax/KQ3F4+S91yX5mxv5PmVC8z6/1jxWvAhcuRJbjlzLQUv2qrPZczt9zIItDTT1t3S/5oI
	5KVp3R9o0vk9vYQf8T6x0ZvfARu+VmOFQeyuVEYxh4z6GW2Uyi0tcmvT7RILoP8/u5auidNLOSgbi
	497Vddm4+v4c9OcApPINPryeNzvJLLFRr0YOx/FJn/0YJY0Axow2zN7hScocWF46A9GnJH4gtLYJA
	jGUWr/y4JTAIOcOidCm910FUiawj6QSg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBVwK-000HFh-Vk; Thu, 14 Nov 2024 10:15:01 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBVwK-000EOg-0f;
	Thu, 14 Nov 2024 10:15:00 +0100
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH can-next v5 0/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
Date: Thu, 14 Nov 2024 10:14:48 +0100
Message-Id: <20241114-tcan-wkrqv-v5-0-a2d50833ed71@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIi/NWcC/2WR3W7DIAxGX6XiekxgDE1ytfeYdsGPadHUZCVZ1
 qnqu89LV61RubPsczAfZzFSLTSKbnMWleYylqHnwj5tRNz7fkeyJK4FKECtjJJT9L38eq/HWUY
 HoVVOKZu8YOCjUi6nRfYqfsd6Ok3ijTv7Mk5D/V5umfXS/xPqe+GspZINmBSShkzoX3bk+3J6j
 sNh8czwz/JZscBsu3XG6jZYsPDAmnsWVqxhNjqHYHLw4NIDi/csrlhkNgPYpk1um4NesZdrLJW
 OnxztdMvmlmy3uSqVlXHoZ6rTVY3Bat4GKWbX8aPZEvxIPHQ4lImpAL71qslNVvwFSB5CdDoFY
 7aIoIPKLaJ3vMDlB9jvFvPjAQAA
X-Change-ID: 20241030-tcan-wkrqv-c62b906005da
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27457/Wed Nov 13 10:35:46 2024)

This series adds support for setting the nWKRQ voltage.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v5:
- Assign bool directly from of_property_read_bool.
- Added Reviewed-By tag to 2/2
- Link to v4: https://lore.kernel.org/r/20241114-tcan-wkrqv-v4-0-f22589d67fb1@geanix.com

Changes in v4:
- Fixed commit msg, as pr. Marc's comments
- Added Reviewed-By tag to 2/2
- Link to v3: https://lore.kernel.org/r/20241112-tcan-wkrqv-v3-0-c66423fba26d@geanix.com

Changes in v3:
- Switched the order of patches, yaml patch first and then code change.
- Switched to a boolean ti,nwkrq-voltage-vio.
- Switched internal variable to a bool.
- Link to v2: https://lore.kernel.org/r/20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com

Changes in v2:
- Converted tcan4x5x.txt to DT schema. In
  https://lore.kernel.org/linux-can/20241105-convert-tcan-v2-1-4b320f3fcf99@geanix.com/
- Reworked ti,nwkrq-voltage-sel, to DH schema style.
- Link to v1: https://lore.kernel.org/r/20241031-tcan-wkrqv-v1-0-823dbd12fe4a@geanix.com

---
Sean Nyekjaer (2):
      dt-bindings: can: tcan4x5x: Document the ti,nwkrq-voltage-vio option
      can: tcan4x5x: add option for selecting nWKRQ voltage

 .../devicetree/bindings/net/can/ti,tcan4x5x.yaml     |  8 ++++++++
 drivers/net/can/m_can/tcan4x5x-core.c                | 20 ++++++++++++++++++++
 drivers/net/can/m_can/tcan4x5x.h                     |  2 ++
 3 files changed, 30 insertions(+)
---
base-commit: 2b2a9a08f8f0b904ea2bc61db3374421b0f944a6
change-id: 20241030-tcan-wkrqv-c62b906005da
prerequisite-change-id: 20241105-convert-tcan-4b516424ecf6:v2
prerequisite-patch-id: a652b1a16dadd5ff525d0b58fec56f605a976aa3

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


