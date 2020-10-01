Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D1427FC4B
	for <lists+linux-can@lfdr.de>; Thu,  1 Oct 2020 11:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbgJAJLn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Oct 2020 05:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731805AbgJAJLk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Oct 2020 05:11:40 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D6C0613D0;
        Thu,  1 Oct 2020 02:11:40 -0700 (PDT)
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DA77122FAD;
        Thu,  1 Oct 2020 11:11:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1601543496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Msd7QP9ufU1637xwoCtbzRf1NuAnH4fqHmEgE77mVYc=;
        b=mfa/2XjUfXYW4X1buF8TiR+tAAZEEdse3n495e7WPrFaUhgoPKyAyXUDL0g4TR/WMz6D3f
        7HXJZhGzuEZ04tOIWiIkazM6GxFLH//bzgY8Zv9nztlxhOmBoH0HxEiHgeAoMhzPzhH7qD
        5ziCcFbkW3h37qTX4gjSBrINxxyAD6g=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 0/3] arm64: dts: add FlexCAN support to LS1028A and sl28
Date:   Thu,  1 Oct 2020 11:11:28 +0200
Message-Id: <20201001091131.30514-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Now that FlexCAN support for newer IPs is finally hitting upstream [1],
lets add the corresponding nodes for the LS1028A SoC and enable it for the
Kontron sl28 board.

changes since v1:
 - added new patch "dt-bindings: can: flexcan: list supported processors"
   Suggested by Lee.

   Please keep in mind that this only an intermediate step, as Marc already
   pointed out [2] that Oleksij is alreay working on converting the
   bindings to YAML format.

[1] https://lore.kernel.org/netdev/20200923085418.2685858-1-mkl@pengutronix.de/
[2] https://lore.kernel.org/linux-can/790ce102-7542-b65e-0945-a04faf6e4b89@pengutronix.de/

Michael Walle (3):
  dt-bindings: can: flexcan: list supported processors
  arm64: dts: ls1028a: add missing CAN nodes
  arm64: dts: freescale: sl28: add CAN node

 .../bindings/net/can/fsl-flexcan.txt           |  6 ++++++
 .../dts/freescale/fsl-ls1028a-kontron-sl28.dts |  4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 18 ++++++++++++++++++
 3 files changed, 28 insertions(+)

-- 
2.20.1

