Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC32754ED
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 11:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgIWJ5g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 05:57:36 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:51865 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgIWJ5g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 05:57:36 -0400
X-Greylist: delayed 7928 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 05:57:35 EDT
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ECF8423E3F;
        Wed, 23 Sep 2020 11:57:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1600855054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NXWhWfj4hrlvy/Jn3KoqjelS97LvJCQ+gOm1t1gVQoo=;
        b=tqqGcFxVlVzl3Mb+yR3cNExDy7gm/3wyJ8uSaId3oDX56C8Z2ut3LGFWjEtDeT45ltPDwN
        qRCYWZ5am6rofA6+6GyQdLSUcnyGgYgvG7YN3fVp2sKPgDavKwrtM/Qycqr9g+k87neUdC
        5qcwpng1NSFBCtD6w7bAMAoFxa4trvo=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 0/2] arm64: dts: add FlexCAN support to LS1028A and sl28
Date:   Wed, 23 Sep 2020 11:57:09 +0200
Message-Id: <20200923095711.11355-1-michael@walle.cc>
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

[1] https://lore.kernel.org/netdev/20200923085418.2685858-1-mkl@pengutronix.de/

Michael Walle (2):
  arm64: dts: ls1028a: add missing CAN nodes
  arm64: dts: freescale: sl28: add CAN node

 .../dts/freescale/fsl-ls1028a-kontron-sl28.dts |  4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

-- 
2.20.1

