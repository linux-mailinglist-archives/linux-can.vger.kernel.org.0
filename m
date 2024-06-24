Return-Path: <linux-can+bounces-851-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A95B915070
	for <lists+linux-can@lfdr.de>; Mon, 24 Jun 2024 16:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159861F224D4
	for <lists+linux-can@lfdr.de>; Mon, 24 Jun 2024 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3637B19B3EC;
	Mon, 24 Jun 2024 14:45:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20D719B3ED
	for <linux-can@vger.kernel.org>; Mon, 24 Jun 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240346; cv=none; b=qIBluBvEXsvZg6K9RLXrspKDGQr58gv1lQ9ilobIC8VzivWsvn8w8/DwviaxrZiR7lEr6cHEJ6s04/a+mehRxgQWzKfhrlkZCgvf+MF1JSJKGrTOgf/2AatNFde/3WGYzgjOlDkRjZ5KFiGnRX22WEU4S7+9/SCmpf5r5I0SrN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240346; c=relaxed/simple;
	bh=XmkuoWyPVU9VsNdex7Da3yL1dDT9glP5Y8iXu/bEZjo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PWb7vSu1RMmHXbWyibsp98ToLEcyNIFc2McDmukWQj33SiSfuHz8xQaX759VMW64F8i0rvmWn0bsjqDJUYZIuneUJ19sh6X8owWnPlExc16Lbac2H+LaTn4SFopyL/NogrQKsODCnaFuKlqYbYX1eUCFnn4NHs8Bynb59Ngumkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sLkww-0002rG-0t
	for linux-can@vger.kernel.org; Mon, 24 Jun 2024 16:45:42 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sLkwu-004flo-Nu
	for linux-can@vger.kernel.org; Mon, 24 Jun 2024 16:45:40 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 663B62F1A39
	for <linux-can@vger.kernel.org>; Mon, 24 Jun 2024 14:45:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id BB9642F19FF;
	Mon, 24 Jun 2024 14:45:37 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 848d3dbd;
	Mon, 24 Jun 2024 14:45:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 0/9] can: mcp251xfd: workaround for erratum DS80000789E
 6 of mcp2518fd
Date: Mon, 24 Jun 2024 16:45:04 +0200
Message-Id: <20240624-mcp251xfd-workaround-erratum-6-v3-0-caf7e5f27f60@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHCGeWYC/yWNQQ6DIBAAv2I4lxRBkPqVxgMuSyUNaBFbE+PfS
 +tx5jCzkwWTx4V01U4Svv3ip1hAXCoCo4kPpN4WJpzxhkkmaYCZy3pzln6m9DRpWqOlmJLJa6C
 KctQcGlDcWUFKZE7o/PYf3PuTE77W8smnJLPJMJZLV1ntBiWwUaB1A/qmjdCOqRq4EMy1Lb9hK
 2XNft3BLEhhCsHnroqYacQtX4PxkfTH8QVNdDpv1wAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4631; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=XmkuoWyPVU9VsNdex7Da3yL1dDT9glP5Y8iXu/bEZjo=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmeYZ+7WQQYbxaZJZ2rzejF3bctdaoaIBpQIHnO
 hCqTcroes+JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZnmGfgAKCRAoOKI+ei28
 b+UOB/98n5J6T+jNnPuq08a65swviEI6Yo8HhdqGF0b/zh96bgEgaaXA/+OkPWVPHvDVtWSfVEG
 iz/O9uC65ZvDJzUAmB6pxrA5qYYE8dLqD+EdQELZMT0GcSKzzkQ+eVoHRzVSu+ozhLXrnrkV3xM
 OFR5VilqONSMtx198pgM4CE8SDyumICx7NcHlxsfkxNqnXlUjS8AJ9LSs4KqK2huSUBKbDJs7Vl
 ky+6QylSlMt8V8z1IYAb+czeebK3rKwkAq9RVoQrL/L5sihnAX5HcK2bgfPzjoCgRMri6SOZuE2
 uDAXyPrEJUGPKcodRPSkthKz9RiaDwdeBitdCFL3+Kx5YTKZ
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

Changes since v2: https://lore.kernel.org/all/20230119112842.500709-1-mkl@pengutronix.de
1/9: can: mcp251xfd: properly indent labels:
  - new
2/9: can: mcp251xfd: update errata references:
 - new
3/9: can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()
 - split mcp251xfd_timestamp_init() into mcp251xfd_timestamp_init()
   and mcp251xfd_timestamp_start()
 - update patch description
6/9: can: mcp251xfd: rx: prepare to workaround broken RX FIFO head index erratum
 - update comments  
 - update patch description
7/9: can: mcp251xfd: rx: add workaround for erratum DS80000789E 6 of mcp2518fd
 - update comments  
 - update patch description
8/9: new
 - import 1/2 from https://lore.kernel.org/all/20230124152729.814840-1-mkl@pengutronix.de
9/9: new
 - import 2/2 from https://lore.kernel.org/all/20230124152729.814840-1-mkl@pengutronix.de

Changes since v1: https://lore.kernel.org/all/20230111222042.1139027-1-mkl@pengutronix.de
all:
  - add proper patch description
  - added Tested-by
2/5 can: mcp251xfd: clarify the meaning of timestamp:
  - revisited new naming of variables and functions
    now we use ts_raw instead of tbc
4/5 can: mcp251xfd: rx: prepare to workaround broken RX:
  - precalculate shift width needed for full u8 instead of calculating
    it every time
5/5 can: mcp251xfd: rx: workaround broken RX FIFO head:
  - remove dumping of old CAN frame in error case
  - add erratum comments

Closes: https://lore.kernel.org/all/FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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

 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |  82 ++++++-----
 drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c     |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c   |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c     |   3 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c       | 163 ++++++++++++++-------
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c      | 127 ++++++++--------
 .../net/can/spi/mcp251xfd/mcp251xfd-timestamp.c    |  29 ++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |  56 +++----
 8 files changed, 261 insertions(+), 203 deletions(-)
---
base-commit: 568ebdaba6370c03360860f1524f646ddd5ca523
change-id: 20240505-mcp251xfd-workaround-erratum-6-2e82c4c62fd3
prerequisite-patch-id: d8fb63e46c884c898a38f061c2330f7729e75510

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



