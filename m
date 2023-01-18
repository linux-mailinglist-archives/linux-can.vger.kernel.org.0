Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E9D671A7B
	for <lists+linux-can@lfdr.de>; Wed, 18 Jan 2023 12:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjARLYm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 Jan 2023 06:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjARLY3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2023 06:24:29 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B479A4A1F0
        for <linux-can@vger.kernel.org>; Wed, 18 Jan 2023 02:39:37 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:4745:2e6d:e3a6:3327])
        by andre.telenet-ops.be with bizsmtp
        id AAfX2900N2zf9gW01AfXTq; Wed, 18 Jan 2023 11:39:35 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pI5qo-005aKI-7W;
        Wed, 18 Jan 2023 11:39:31 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pI5qt-001Jt1-HX;
        Wed, 18 Jan 2023 11:39:31 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Aswath Govindraju <a-govindraju@ti.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] phy: Add support for NXP TJR1443 CAN Transceiver
Date:   Wed, 18 Jan 2023 11:39:22 +0100
Message-Id: <cover.1674037830.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

	Hi all,

The NXP TJR1443 High-speed CAN transceiver with Sleep mode is a
pin-compatible alternative for the TI TCAN1043.  Hence this patch series
adds support for it to the existing TI TCAN1043 DT bindings and to the
generic CAN Transceiver PHY driver.

This has been tested on the Renesas White-Hawk development board.

Thanks for your comments!

Geert Uytterhoeven (2):
  dt-bindings: phy: ti,tcan104x-can: Document NXP TJR1443
  phy: phy-can-transceiver: Add support for NXP TJR1443

 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
 drivers/phy/phy-can-transceiver.c                          | 4 ++++
 2 files changed, 5 insertions(+)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
