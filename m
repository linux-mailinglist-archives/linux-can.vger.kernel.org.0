Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C36A6B98A1
	for <lists+linux-can@lfdr.de>; Tue, 14 Mar 2023 16:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjCNPMW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 14 Mar 2023 11:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCNPMV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Mar 2023 11:12:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D7C9BE25
        for <linux-can@vger.kernel.org>; Tue, 14 Mar 2023 08:12:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h17so662651wrt.8
        for <linux-can@vger.kernel.org>; Tue, 14 Mar 2023 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678806738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmGIHQCmWWdA9EwE4mVtBEzfVG8pp3/R17fUTMGZ6+A=;
        b=wm3utNeOJHiNjSb3v0zKJI8yUo1ASepqLTO4rJyfMNSbyOL1ayZKciL7n7Nym3iOSo
         bUQNZxfiK6aHhB4p23vPSr78iJJsfc5QUU+onuZdINfynDMrYFTt3MaDn1vDOjLEXiK2
         D/lMEKsbKHcdwt30d8wwqu7BsPqCRL5jpDUD3Gd6g93gnLnbmDccRDaUeWt/v444SyIF
         8BoSi53tL6PVh0z5zTzOOvsmowoa+25ze54I9rUqblUyFhXDDHABlKvLXX8HskQpl2Sb
         VEjf8qDwyF192LHl3WB385ura+pgBnPCbGmsZvL3P3JjAhKGuJuRzmX7c3ifHeIAEMFy
         g6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678806738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmGIHQCmWWdA9EwE4mVtBEzfVG8pp3/R17fUTMGZ6+A=;
        b=dQ81q/OhgF/7QOQcxjq4yvmNeXr93I1HvOxevAkFvQ8HCX337gFj9hLK7DubqNluv8
         HhX704fzcegjDYXVqBMmhtnh4IOB7iVM1AspIduQMouuNTLTI48EYb5+SJ6foWf6ywee
         1rL5uyPTeJoFajGFehreIfdt75VeTrV986R14ZJlj9Td+bqfIewb9qemJzdGM9j+KSyO
         OJIGmRreFua7/9fH312JDKJIVMped7Nfnu5ELjI1eQzzmYmtC4h5O5LRZLfZTId/1Yah
         D1cLMgq+4WsEOhLmXW51eIKB7Ku/7zxm+9pc9kbzuMsxfiLEjt1iy6I5FizXcu8WwXgU
         y78A==
X-Gm-Message-State: AO0yUKX18Ezlr+vXaKNnt8Qu2R7k/eVyDlUtwaEnOz0nv7cdvHxes2fw
        FBaBN4TeiXGWMDLbkxBu8WuVww==
X-Google-Smtp-Source: AK7set+VwQ1MOQZgBH9M7eBmtzGtnaJhTpgUKfJzwV2LiegW5kOCGYMbtpLnd6S1mJV7l6Q+/Cbtsg==
X-Received: by 2002:adf:f78e:0:b0:2c8:bf89:39be with SMTP id q14-20020adff78e000000b002c8bf8939bemr28733891wrp.7.1678806738473;
        Tue, 14 Mar 2023 08:12:18 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a247:8056:be7d:83e:a6a5:4659])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d4f89000000b002c707b336c9sm2320158wru.36.2023.03.14.08.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:12:17 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 2/5] can: tcan4x5x: Remove reserved register 0x814 from writable table
Date:   Tue, 14 Mar 2023 16:11:58 +0100
Message-Id: <20230314151201.2317134-3-msp@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314151201.2317134-1-msp@baylibre.com>
References: <20230314151201.2317134-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The mentioned register is not writable. It is reserved and should not be
written.

Fixes: 39dbb21b6a29 ("can: tcan4x5x: Specify separate read/write ranges")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/tcan4x5x-regmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-regmap.c b/drivers/net/can/m_can/tcan4x5x-regmap.c
index 2b218ce04e9f..fafa6daa67e6 100644
--- a/drivers/net/can/m_can/tcan4x5x-regmap.c
+++ b/drivers/net/can/m_can/tcan4x5x-regmap.c
@@ -95,7 +95,6 @@ static const struct regmap_range tcan4x5x_reg_table_wr_range[] = {
 	regmap_reg_range(0x000c, 0x0010),
 	/* Device configuration registers and Interrupt Flags*/
 	regmap_reg_range(0x0800, 0x080c),
-	regmap_reg_range(0x0814, 0x0814),
 	regmap_reg_range(0x0820, 0x0820),
 	regmap_reg_range(0x0830, 0x0830),
 	/* M_CAN */
-- 
2.39.2

