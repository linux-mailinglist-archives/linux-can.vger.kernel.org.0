Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C952B5B90E3
	for <lists+linux-can@lfdr.de>; Thu, 15 Sep 2022 01:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiINXOJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 14 Sep 2022 19:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiINXOI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Sep 2022 19:14:08 -0400
Received: from mxd1.seznam.cz (mxd1.seznam.cz [IPv6:2a02:598:a::78:210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A96F895C3;
        Wed, 14 Sep 2022 16:14:05 -0700 (PDT)
Received: from email.seznam.cz
        by email-smtpc22b.ko.seznam.cz (email-smtpc22b.ko.seznam.cz [10.53.18.29])
        id 7d69c81899c51b267cb46976;
        Thu, 15 Sep 2022 01:13:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1663197200; bh=DZl/zpDC4daeyZK5+yAdaWiaFpHk14LLzJ5mzlIQIT0=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=aZUf5jpqLPwK6GOkq971fp44K/zEHLgbmu460bF9xOZE0epCFY9UaWulGo7K71OYk
         NXbuTvfVX9foefQTMuBs79xrjhKKsA/P+xUl1bq64dmi9k0ekJqD8xhe96foSm08Po
         dZrvA7Zkc3HXNV/elVqZFkPB0+FRJM/XSCRsiswg=
Received: from localhost.localdomain (2a02:8308:900d:2400:4bcc:f22e:1266:5194 [2a02:8308:900d:2400:4bcc:f22e:1266:5194])
        by email-relay23.ko.seznam.cz (Seznam SMTPD 1.3.137) with ESMTP;
        Thu, 15 Sep 2022 01:13:19 +0200 (CEST)  
From:   Matej Vasilevski <matej.vasilevski@seznam.cz>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        Matej Vasilevski <matej.vasilevski@seznam.cz>
Subject: [PATCH v3 3/3] doc: ctucanfd: RX frames timestamping for platform devices
Date:   Thu, 15 Sep 2022 01:12:49 +0200
Message-Id: <20220914231249.593643-4-matej.vasilevski@seznam.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914231249.593643-1-matej.vasilevski@seznam.cz>
References: <20220914231249.593643-1-matej.vasilevski@seznam.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Update the section about timestamping RX frames with instructions
how to enable it.

Signed-off-by: Matej Vasilevski <matej.vasilevski@seznam.cz>
---
 .../device_drivers/can/ctu/ctucanfd-driver.rst      | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/can/ctu/ctucanfd-driver.rst b/Documentation/networking/device_drivers/can/ctu/ctucanfd-driver.rst
index 40c92ea272af..05a7ce0c3d9e 100644
--- a/Documentation/networking/device_drivers/can/ctu/ctucanfd-driver.rst
+++ b/Documentation/networking/device_drivers/can/ctu/ctucanfd-driver.rst
@@ -386,8 +386,17 @@ The CTU CAN FD core reports the exact timestamp when the frame has been
 received. The timestamp is by default captured at the sample point of
 the last bit of EOF but is configurable to be captured at the SOF bit.
 The timestamp source is external to the core and may be up to 64 bits
-wide. At the time of writing, passing the timestamp from kernel to
-userspace is not yet implemented, but is planned in the future.
+wide.
+
+Both platform and PCI devices can report the timestamp.
+For platform devices, add another clock phandle for timestamping clock
+in device tree bindings. If you don't add another clock, the driver
+will assume the primary clock's frequency for timestamping.
+For PCI devices, the timestamping frequency is assumed to be equal to
+the bus frequency.
+
+Timestamp reporting is disabled by default, you have to enable it with
+SIOCSHWTSTAMP ioctl call first.
 
 Handling TX
 ~~~~~~~~~~~
-- 
2.25.1

