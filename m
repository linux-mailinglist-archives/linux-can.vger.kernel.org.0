Return-Path: <linux-can+bounces-5977-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F2FCECAA6
	for <lists+linux-can@lfdr.de>; Thu, 01 Jan 2026 00:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90D0230036C5
	for <lists+linux-can@lfdr.de>; Wed, 31 Dec 2025 23:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD324E4A1;
	Wed, 31 Dec 2025 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="NbMpNhl9"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A849123AB87;
	Wed, 31 Dec 2025 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767223236; cv=none; b=WU2cxHEhvNbrd7v5hX3cdcL3o3ShBSPm6nd9SdXWw5jqhvSgmrcjUzFxiBMCtZdDgrb+C5+CjTuQGs8tHrSO0kM3Iy3kyMqGnVCT3F8T/hUUapsbaaXJrXUoh7gQ8U/UZB1vJcwWYMTgpM9AUaGs3Sz09NiIX6P69uhk9YOfXgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767223236; c=relaxed/simple;
	bh=FYGdSp6czj+0imSdcNgSv3AclAmLyHq2HJLGdWVBaAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+X+Jhtqk7Q5LhdulTR7zWbBAVKTDlTO5O9DkH5qBpb9836tv+BLCTgUnDuVrC5i6+9evs2yPJGvayZH6yrQ8Zwaesw8iLM6WtMeuCEPc27OUOfJn7oc3amlPsF5wQu217W5U/bNau/A046YuTDL3e5Y8UcHAIxUl/6XG3LumzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=NbMpNhl9; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id D331722685;
	Thu, 01 Jan 2026 00:20:23 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id lcYaQay1hnm5; Thu,  1 Jan 2026 00:20:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1767223222;
	bh=93RrIMjakSwcrq6K5DWbPxQYjGApwXm9Nt8UBxC9kTI=;
	h=From:To:Cc:Subject:Date:From;
	b=NbMpNhl9OsaBty7wrPCGpnukd3WNOnpFq3pUn42Q5sUQQN8u52d6bxjfAIj0MG8c/
	 /ULjRETyfaklJC7okNA7FMRU/Ixzi3sDqGJSd86qGlJ2Pl7woitx2I42utpOpNWEzF
	 xY4NRH1m2iMfHLWj8c/IRYpyFAbTlkLBrF9QxVJAh+DjVC+JxYdsmSiS7OmksRHysb
	 JaANT4cc43588AgWrvXUNakjs76tWgaH/Tg4kizJpNX0EFH9b918kkZGbACFQgiDni
	 YDiEPnTOSA7kygsmGgtxWASgvyjtZJLJeAmMoRDUrsWLE9txI3fau5ZkYq8OZy714j
	 lwy3C+udiAw7A==
Received: from fel.cvut.cz (static-84-242-78-234.bb.vodafone.cz [84.242.78.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id E4749224E6;
	Thu, 01 Jan 2026 00:20:21 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: linux-can@vger.kernel.org,
	"Marc Kleine-Budde" <mkl@pengutronix.de>,
	David Laight <david.laight.linux@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrea Daoud <andreadaoud6@gmail.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Jiri Novak <jnovak@fel.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Pavel Pisa <pisa@fel.cvut.cz>
Subject: [PATCH] can: ctucanfd: fix SSP_SRC in cases when bit-rate is higher than 1 MBit.
Date: Thu,  1 Jan 2026 00:19:26 +0100
Message-ID: <20251231231926.20043-1-pisa@fel.cvut.cz>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Ille <ondrej.ille@gmail.com>

The change has been tested on AMD/Xilinx Zynq
with the next CTU CN FD IP core versions:

 - 2.6 aka master in the "integration with Zynq-7000 system" test
   6.12.43-rt12+ #1 SMP PREEMPT_RT kernel with CTU CAN FD git
   driver (change already included in the driver repo)
 - older 2.5 snapshot with mainline kernels with this patch
   applied locally in the multiple CAN latency tester nightly runs
   6.18.0-rc4-rt3-dut #1 SMP PREEMPT_RT
   6.19.0-rc3-dut

The logs are available at

 https://canbus.pages.fel.cvut.cz/

Signed-off-by: Ondrej Ille <ondrej.ille@gmail.com>
Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 1e6b9e3dc2fe..0ea1ff28dfce 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -310,7 +310,7 @@ static int ctucan_set_secondary_sample_point(struct net_device *ndev)
 		}
 
 		ssp_cfg = FIELD_PREP(REG_TRV_DELAY_SSP_OFFSET, ssp_offset);
-		ssp_cfg |= FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x1);
+		ssp_cfg |= FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x0);
 	}
 
 	ctucan_write32(priv, CTUCANFD_TRV_DELAY, ssp_cfg);
-- 
2.47.3


