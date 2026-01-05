Return-Path: <linux-can+bounces-5994-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7399CF3455
	for <lists+linux-can@lfdr.de>; Mon, 05 Jan 2026 12:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE96E3093B00
	for <lists+linux-can@lfdr.de>; Mon,  5 Jan 2026 11:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2379F340DA5;
	Mon,  5 Jan 2026 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="RWjUJ3Qf"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538EF340A6A;
	Mon,  5 Jan 2026 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611854; cv=none; b=WY619DVf+nF0aa2uG5dBhjM5t/kzkWYJX/0jYIK35A1XU92CTloTavTy0gpxWPwKv64i1sCIUUO4PXI69EOtdDX8dryIl1askG/gMWy+6yYBcdgQtPM8a076LMcDg0tPW5zol2S2m0yQxw8Pd0HEBoVZCYMii9yE6ja44Z+V71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611854; c=relaxed/simple;
	bh=TGf6Xx6EH00BglDDqkVDcwkNf66EGGQew7JsrhRqn2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OyYjqAYaLnChhrR3oxJnlucLp4zbTbf76n9GQD983q6WczNjZovlzNajVHU2I44nD66VH1dAxDMukkBMN8YLN5fw0f7zLp11ckwFXZzbOF0OtqOvak7dhyRwZzsKFtIo9kQC0Ndh2zw1eJfiyYRty2NJAU8BLP3n29XdrePA0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=RWjUJ3Qf; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id C40092A6C1;
	Mon, 05 Jan 2026 12:17:21 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id EmTVYg8_ynXu; Mon,  5 Jan 2026 12:17:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1767611840;
	bh=39GTysQ2XB6nQtWthRK9kPEZbFJ8UXpWexiHu0yeSGc=;
	h=From:To:Cc:Subject:Date:From;
	b=RWjUJ3QfZod/XZfb1byB+7qSEAmyXtkxTF9EqiI+pg0N7fufgBAbEIxwgE2x8O49t
	 rmGRJgtyn4W+KABlLyYWPiSvxKd840fVFYwVe/DlWJhYDoDuIqPrL7VPKlo0paup1N
	 KAC1mFeqIaTjcS4oZNXlQ1SoLGG7kgrrjUkstx0jWyMEDJKokH8635sLs0tkbgnaNk
	 P+/880+rQjyJZ1UhFE/BDgYYjl9hkvreDH83AiLdm5aLL+wWRHJnuHx4jOnHOkH33+
	 CSagkNsEKWnPhihEiDGvJVGw70RrhejwLzKTAeaxkhVB4CZ4+qU6+UlzK4n2+T5YmG
	 d+cj6XouootYQ==
Received: from fel.cvut.cz (unknown [147.32.86.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id CB8CD2A9CC;
	Mon, 05 Jan 2026 12:17:19 +0100 (CET)
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
Subject: [PATCH v2] can: ctucanfd: fix SSP_SRC in cases when bit-rate is higher than 1 MBit.
Date: Mon,  5 Jan 2026 12:16:20 +0100
Message-ID: <20260105111620.16580-1-pisa@fel.cvut.cz>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Ille <ondrej.ille@gmail.com>

The Secondary Sample Point Source field has been
set to an incorrect value by some mistake in the
past

  0b01 - SSP_SRC_NO_SSP - SSP is not used.

for data bitrates above 1 MBit/s. The correct/default
value already used for lower bitrates is

  0b00 - SSP_SRC_MEAS_N_OFFSET - SSP position = TRV_DELAY
         (Measured Transmitter delay) + SSP_OFFSET.

The related configuration register structure is described
in section 3.1.46 SSP_CFG of the CTU CAN FD
IP CORE Datasheet.

The analysis leading to the proper configuration
is described in section 2.8.3 Secondary sampling point
of the datasheet.

The change has been tested on AMD/Xilinx Zynq
with the next CTU CN FD IP core versions:

 - 2.6 aka master in the "integration with Zynq-7000 system" test
   6.12.43-rt12+ #1 SMP PREEMPT_RT kernel with CTU CAN FD git
   driver (change already included in the driver repo)
 - older 2.5 snapshot with mainline kernels with this patch
   applied locally in the multiple CAN latency tester nightly runs
   6.18.0-rc4-rt3-dut #1 SMP PREEMPT_RT
   6.19.0-rc3-dut

The logs, the datasheet and sources are available at

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


