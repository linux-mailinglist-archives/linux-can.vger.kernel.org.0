Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055B31A6AD3
	for <lists+linux-can@lfdr.de>; Mon, 13 Apr 2020 19:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbgDMRCt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Apr 2020 13:02:49 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:54017 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732285AbgDMRCs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Apr 2020 13:02:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 50021785;
        Mon, 13 Apr 2020 13:02:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 13 Apr 2020 13:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flameeyes.com;
         h=from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=GF95bauUXWVszPqlJ+z17XSG4B
        WF1f59F2tWtT4HHtI=; b=rRmE1ouivtMuXHyqezDJMlUjI321vw7TqMv4MPaj3R
        1Bg0kTKecdPQb44mcUE/70qq2KCWgvTkq8H0+YANNvYfmus8wjvqfmwSrwKtjxFf
        GwsvajraTaGJ9vCf9CNpdG5t19FyTb6inpTyEmYvzY0gQkfB5DaxxWGWMTAwFI5U
        4vcO51rlySlEFrlteSkZ6uOhh1T9M7MYp//S1QGCG1cr86sUc+WYH4nIQ1kaMarp
        nVH6pMDlbqx5jau+041RzTIc1MZdk+6xS52MupGMoD17/ArBihOlVjvj5aNjI2TC
        QkgMGAwBhMk+H3DqS5Lh5as/ETfr9Wu+KRViXPIdpfng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=GF95ba
        uUXWVszPqlJ+z17XSG4BWF1f59F2tWtT4HHtI=; b=SMrMXcy+M4+gv9rtfFXY8u
        7XPWPh6Rzku27etwjt2SmQxvnfU6T1sIMDFJum20GZG+VZF1ISY21WaRvcTq2QUC
        2HIj93vjPXjbzx+BIc5sZJ4UqKC4Bv7XbjhQBhI4TVhdDYi/AMkW0VWIfMQWDTk6
        pmaVG2wmnGB3vn7k1F7n0faq8XmlzPGkKrEU7CgS0Oz2UR9iDcA5jxteWEC1jAJu
        9qIJ/DgxNy5QfI8hk66I7dKzCpQNJYVOGq8w3BXoTMuWmXcudiD0fZKNoedmIznv
        BVNW5RJ1StyQARzSGprdeum5y1Uiain9PpuNoN+XA/WTts2wFGZxUKVfRgZma5OQ
        ==
X-ME-Sender: <xms:NpuUXk-G2c3MPLVNORTZKxefCDa1TfhFxgDhOBYNFUzkeGm5b63u3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrvdelgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepffhivghgohcu
    gfhlihhoucfrvghtthgvnhpjuceofhhlrghmvggvhigvshesfhhlrghmvggvhigvshdrtg
    homheqnecuffhomhgrihhnpegtrghnuhhssgdrtghomhdptggrnhdvfedvrdgtohhmpdhm
    ihgtthhrohhnihgtshdruggvpdgtrghnhhgrtghkrdguvgdpsggvrhhlihhoshdruggvpd
    hgihhthhhusgdrtghomhenucfkphepkeekrdelkedrvdefkedrudeftdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehflhgrmhgvvgihvghsse
    hflhgrmhgvvgihvghsrdgtohhm
X-ME-Proxy: <xmx:NpuUXmtHBtyG9pxmJncAAME6b-O-BebPkgsHU8GNTss896Bnrx0a6A>
    <xmx:NpuUXgoZuRtmjSutTzvLIEbgYzAdYCnqw9zQRvcPgewvsZe2N4nFZw>
    <xmx:NpuUXiqjPrya-duke1VSQrOb7gd3tavYWFtnxjOo82bwJBDFQvunqg>
    <xmx:NpuUXvJtWSky1JBjVE5ja5rIb9Oc02QQ675IyjHuWXyEy7x7yPUXpw>
Received: from localhost.localdomain (unknown [88.98.238.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8BCDE3280066;
        Mon, 13 Apr 2020 13:02:45 -0400 (EDT)
From:   =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>
Subject: [PATCH 2/4] softcan: update dead links.
Date:   Mon, 13 Apr 2020 18:02:41 +0100
Message-Id: <20200413170241.13207-1-flameeyes@flameeyes.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

BerliOS has not been operating for more than five years. linux-can appears
to have moved to GitHub.

Signed-off-by: Diego Elio Pettenò <flameeyes@flameeyes.com>
---
 drivers/net/can/Kconfig         | 4 ++--
 drivers/net/can/softing/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 17c166cc8482..be1bcb012761 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -41,8 +41,8 @@ config CAN_SLCAN
 	  www.canusb.com / www.can232.com / www.mictronics.de / www.canhack.de
 
 	  Userspace tools to attach the SLCAN line discipline (slcan_attach,
-	  slcand) can be found in the can-utils at the SocketCAN SVN, see
-	  http://developer.berlios.de/projects/socketcan for details.
+	  slcand) can be found in the can-utils at the linux-can project, see
+	  https://github.com/linux-can/can-utils for details.
 
 	  The slcan driver supports up to 10 CAN netdevices by default which
 	  can be changed by the 'maxdev=xx' module option. This driver can
diff --git a/drivers/net/can/softing/Kconfig b/drivers/net/can/softing/Kconfig
index 0f1708f99308..70ca800c1bfa 100644
--- a/drivers/net/can/softing/Kconfig
+++ b/drivers/net/can/softing/Kconfig
@@ -24,7 +24,7 @@ config CAN_SOFTING_CS
 	  Support for PCMCIA cards from Softing Gmbh & some cards
 	  from Vector Gmbh.
 	  You need firmware for these, which you can get at
-	  http://developer.berlios.de/projects/socketcan/
+	  https://github.com/linux-can/can-firmware
 	  This version of the driver is written against
 	  firmware version 4.6 (softing-fw-4.6-binaries.tar.gz)
 	  In order to use the card as CAN device, you need the Softing generic
-- 
2.26.0

