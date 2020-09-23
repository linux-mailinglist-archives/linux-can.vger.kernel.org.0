Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3862754F6
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 11:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIWJ5h (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 05:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgIWJ5h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 05:57:37 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6CAC0613CE;
        Wed, 23 Sep 2020 02:57:36 -0700 (PDT)
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 145C323E49;
        Wed, 23 Sep 2020 11:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1600855055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OLX6rkZTMp14c9/whr6cer1r2u5BHaiqDJ2+MlPTrzI=;
        b=ICL73UY8qLZqMNA25wdZ6isCI1cG4yYiv0dINaePYOPOaV1GL/lbadv8qRrzZoZonYyt7P
        DZUKBnqltWR3JCttyhdZOoaZTRvrPRRzDL5PDm9TTAO1eUQDi55//fsIJe47KVZ1VazFio
        gaVep8KAIBlUgdxCVD6rltaWV5IMomg=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] arm64: dts: freescale: sl28: add CAN node
Date:   Wed, 23 Sep 2020 11:57:11 +0200
Message-Id: <20200923095711.11355-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200923095711.11355-1-michael@walle.cc>
References: <20200923095711.11355-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The module supports one CAN controller. Enable it.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 852dad8d70ab..360b3a168c10 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -27,6 +27,10 @@
 	};
 };
 
+&can0 {
+	status = "okay";
+};
+
 &dspi2 {
 	status = "okay";
 };
-- 
2.20.1

