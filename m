Return-Path: <linux-can+bounces-12-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7044F7E9CD3
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 14:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25637280DDA
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 13:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34AA1F92C;
	Mon, 13 Nov 2023 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="j2mVapa+"
X-Original-To: linux-can@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF21DFE6;
	Mon, 13 Nov 2023 13:15:08 +0000 (UTC)
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1321724;
	Mon, 13 Nov 2023 05:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=LXUE+NRJxfmQxSGL92CBp/7fv64YpQIfIHH8AJk7NIA=; b=j2mVapa+fuMRPKpx0I5LN6ok1E
	V1TJQIk3FjGO5c1aaucbv1v/YqnSQ/Qsf5/T4WGM7lEKtOvkvMudCOTic37AQrPEq0mo0Gycqe5Wx
	XB7NLNvZDFXpo77PWJUuJtjqMWEIl3nJpamgp5RdWsH3BUQxwle18CSB1GE3FHtA8WTWDx8V5T5v4
	pWvADXzdY65XWmDiFVRShxWGB18E7Yj0KkbMHdPVuRGsMYFAJQgkvt5Ynpxu0ZP/gQij66TkDQ+s3
	NuZQodpk45jCuHWtxjLPIQQ6v/emTDVHm22M7XKPMo0LMPt7RWoZ+joQHt1o1P/GkrmSNK3+3zImN
	IRvDtCzA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1r2WmF-0007GW-Gj; Mon, 13 Nov 2023 14:14:55 +0100
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <martin@geanix.com>)
	id 1r2WmE-000XPJ-UJ; Mon, 13 Nov 2023 14:14:54 +0100
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH v3 0/3] can: tcan4x5x: support resume upon rx can frame
Date: Mon, 13 Nov 2023 14:14:49 +0100
Message-ID: <20231113131452.214961-1-martin@geanix.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27092/Mon Nov 13 09:38:20 2023)

This is the third iteration of the previous submitted patches [0] and
[1].

This revision replaces the "wake_source" function parameters to a flag
in the class device structure, and adds a patch to document the
"wakeup-source" device tree property.

Also, the previous revisions forgot to mention that the patches are
based on Markus' coalescing patches[2]. Those implements caching of the
enabled interrupts, which is handy when restoring the set of interrupts
in the resume path.

[0] https://lore.kernel.org/linux-can/20230912093807.1383720-1-martin@geanix.com/
[1] https://lore.kernel.org/linux-can/20230919122841.3803289-1-martin@geanix.com/
[2] https://lore.kernel.org/linux-can/20230929141304.3934380-1-msp@baylibre.com/

Martin Hundebøll (3):
  can: m_can: allow keeping the transceiver running in suspend
  can: tcan4x5x: support resuming from rx interrupt signal
  dt-bindings: can: tcan4x5x: Document the wakeup-source flag

 .../devicetree/bindings/net/can/tcan4x5x.txt  |  3 ++
 drivers/net/can/m_can/m_can.c                 | 22 ++++++++++---
 drivers/net/can/m_can/m_can.h                 |  1 +
 drivers/net/can/m_can/m_can_pci.c             |  1 +
 drivers/net/can/m_can/m_can_platform.c        |  1 +
 drivers/net/can/m_can/tcan4x5x-core.c         | 33 ++++++++++++++++++-
 6 files changed, 55 insertions(+), 6 deletions(-)

-- 
2.42.0


