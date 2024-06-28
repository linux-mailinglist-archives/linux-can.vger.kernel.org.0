Return-Path: <linux-can+bounces-882-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CF591C83C
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 23:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57ACA1C2136E
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28017FBB7;
	Fri, 28 Jun 2024 21:41:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C10F5339D
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610884; cv=none; b=lGw+dnHlz5r8AQK8kmoIihEmrg5odkVIxcBLq8N0fF5kFrJTri6/3FXnFz0o4Jfpyrqa90oE7jP0+vWZRpZfHWB4r4eLOg6N3cM57XkAtYrXh1OVD1b7KxDgvtqwLgxupIoCLNUePJT3wkXj3uVYNYk6yecLbrApJ0slHh9K7NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610884; c=relaxed/simple;
	bh=o58Hc84fsq+Ltesz0M1Ri/m/Vu9nu/GQw7w2Pw07GJM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Qgpg6dMODOLqPVRUP1DDk3Al5/Mo6Y7kMd/9sWz70F9OxD2n5UYz98BYKsk26dksVwiR9d+GG1U39DUQ2RNQy7Z9JJDejQ0/cQ7f0niN9NobfFuDU+Vtst8+NELDsHxwfPoVlPgy1s2FKZ/KYkpMh35dlI0HGnzHj2gQAC7aYQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNJLM-0001YU-HT
	for linux-can@vger.kernel.org; Fri, 28 Jun 2024 23:41:20 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sNJLL-005h1h-R4
	for linux-can@vger.kernel.org; Fri, 28 Jun 2024 23:41:19 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 7C9982F6094
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 21:41:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 7409D2F6070;
	Fri, 28 Jun 2024 21:41:16 +0000 (UTC)
Received: from [10.11.86.119] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f480d03f;
	Fri, 28 Jun 2024 21:41:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 0/9] can: mcp251xfd: workaround for erratum DS80000789E
 6 of mcp2518fd
Date: Fri, 28 Jun 2024 23:40:24 +0200
Message-Id: <20240628-mcp251xfd-workaround-erratum-6-v4-0-53586f168524@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMktf2YC/4WOS27DMAxEr2JwXaaq/EmRVe8RZKFIVEIUkhxKd
 hwYvntd+wBZvgFm5s2QSZgynKoZhEbOnOIKzUcF9m7ijZDdyqCVblSrWgy21+3X5B0+k/waSUN
 0SCKmDAE71PStbWM77V0N60gv5HnaDs6XnYUew/pT9hCuJhPaFAKXUxWpYKSpfAbDEf4Ld84ly
 WsTHOutsbl0unnnMtao0Bp/pNbro+/UT0/xNhRJkaeDI7gsy/IHjOk/WAIBAAA=
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 =?utf-8?q?Stefan_Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>, 
 kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=5294; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=o58Hc84fsq+Ltesz0M1Ri/m/Vu9nu/GQw7w2Pw07GJM=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmfy3riFtMn/m6WXug0Z/2vR8wzgwrreGll17PM
 D6E4lqA0W6JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZn8t6wAKCRAoOKI+ei28
 b1m0B/46uu9IUe+c9y5T2RnjSb4IivnAw8sAKJDiMMiocVgfXKjOGT/jruO15g+t58jgB6k/ADf
 EWL8dgescCDazLFIUBeomYHamDn7SffFvWf2YBgaAbJjrci/i7r9+SiUDgZknMdeHHdltY0qxfo
 Y1WkHRwwqeO8c1FtGnYIf9YcEzqjbDOvh1DbIGBp287N+duPUsaPsb4H+IUUEicTbiDPcYSZspD
 iRMB9mtBB56C0vPYYRDw5v8odztYwk3aoxHPNTTHTAFRIBSawgNP7Mo6IRuXKf66hbLuuyrWR1R
 Fb2zv0rFmza8ZniBg/6MFm/JYTqj+QnM42N+9cfTgwLrHyqn
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hello,

This patch series tries to work around erratum DS80000789E 6 of the
mcp2518fd, found by Stefan Althöfer, the other variants of the chip
family (mcp2517fd and mcp251863) are probably also affected.

Erratum DS80000789E 6 says "reading of the FIFOCI bits in the FIFOSTA
register for an RX FIFO may be corrupted". However observation shows
that this problem is not limited to RX FIFOs but also effects the TEF
FIFO.

In the bad case, the driver reads a too large head index. In the
original code, the driver always trusted the read value.

For the RX FIDO this caused old, already processed CAN frames or new,
incompletely written CAN frames to be (re-)processed.

To work around this issue, keep a per FIFO timestamp of the last valid
received CAN frame and compare against the timestamp of every received
CAN frame.

Further tests showed that this workaround can recognize old CAN
frames, but a small time window remains in which partially written CAN
frames are not recognized but then processed. These CAN frames have
the correct data and time stamps, but the DLC has not yet been
updated.

For the TEF FIFO the original driver already detects the error, update
the error handling with the knowledge that it is causes by this erratum.

The series applies against current net/main or net-next/main +
d8fb63e46c88 ("can: mcp251xfd: fix infinite loop when xmit fails")

regards,
Marc

Closes: https://lore.kernel.org/all/FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v4:
- 7/9: mcp251xfd_ring_alloc(): replace BITS_PER_TYPE(u8) by
  BITS_PER_TYPE(rx_ring->obj_num_shift_to_u8) to calculate
  rx_ring->obj_num_shift_to_u8
- 7/9 mcp251xfd_get_rx_len(): add BUILD_BUG_ON() to ensure that all
  variables used in calculation are actually u8
- 9/9: mcp251xfd_ring_alloc(): replace BITS_PER_TYPE(u8) by
  BITS_PER_TYPE(tx_ring->obj_num) to calculate
  tx_ring->obj_num_shift_to_u8
- 9/9: mcp251xfd_get_tef_len(): add BUILD_BUG_ON() to ensure that all
  variables used in calculation are actually u8
- Link to v3: https://lore.kernel.org/all/20240624-mcp251xfd-workaround-erratum-6-v3-0-caf7e5f27f60@pengutronix.de

Changes in v3:
- 1/9: can: mcp251xfd: properly indent labels:
  - new
- 2/9: can: mcp251xfd: update errata references:
 - new
- 3/9: can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()
  - split mcp251xfd_timestamp_init() into mcp251xfd_timestamp_init()
    and mcp251xfd_timestamp_start()
  - update patch description
- 6/9: can: mcp251xfd: rx: prepare to workaround broken RX FIFO head index erratum
  - update comments  
  - update patch description
- 7/9: can: mcp251xfd: rx: add workaround for erratum DS80000789E 6 of mcp2518fd
  - update comments  
  - update patch description
- 8/9: new
  - import 1/2 from https://lore.kernel.org/all/20230124152729.814840-1-mkl@pengutronix.de
- 9/9: new
  - import 2/2 from https://lore.kernel.org/all/20230124152729.814840-1-mkl@pengutronix.de
- Link to v2: https://lore.kernel.org/all/20230119112842.500709-1-mkl@pengutronix.de

Changes in v2
- all:
  - add proper patch description
  - added Tested-by
- 2/5 can: mcp251xfd: clarify the meaning of timestamp:
  - revisited new naming of variables and functions
    now we use ts_raw instead of tbc
- 4/5 can: mcp251xfd: rx: prepare to workaround broken RX:
  - precalculate shift width needed for full u8 instead of calculating
    it every time
- 5/5 can: mcp251xfd: rx: workaround broken RX FIFO head:
  - remove dumping of old CAN frame in error case
  - add erratum comments
- Link to v1: v1: https://lore.kernel.org/all/20230111222042.1139027-1-mkl@pengutronix.de

---
Marc Kleine-Budde (9):
      can: mcp251xfd: properly indent labels
      can: mcp251xfd: update errata references
      can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()
      can: mcp251xfd: clarify the meaning of timestamp
      can: mcp251xfd: mcp251xfd_handle_rxif_ring_uinc(): factor out in separate function
      can: mcp251xfd: rx: prepare to workaround broken RX FIFO head index erratum
      can: mcp251xfd: rx: add workaround for erratum DS80000789E 6 of mcp2518fd
      can: mcp251xfd: tef: prepare to workaround broken TEF FIFO tail index erratum
      can: mcp251xfd: tef: update workaround for erratum DS80000789E 6 of mcp2518fd

 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |  82 +++++-----
 drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c     |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c   |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c     |   5 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c       | 165 ++++++++++++++-------
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c      | 129 ++++++++--------
 .../net/can/spi/mcp251xfd/mcp251xfd-timestamp.c    |  29 ++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |  56 +++----
 8 files changed, 269 insertions(+), 201 deletions(-)
---
base-commit: 748e3bbf47212d5e2e22d731328b0c15ee3b85ae
change-id: 20240505-mcp251xfd-workaround-erratum-6-2e82c4c62fd3

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



