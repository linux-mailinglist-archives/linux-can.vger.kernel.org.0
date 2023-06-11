Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC5572B008
	for <lists+linux-can@lfdr.de>; Sun, 11 Jun 2023 04:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjFKC6A (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 10 Jun 2023 22:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjFKC56 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 10 Jun 2023 22:57:58 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52C394;
        Sat, 10 Jun 2023 19:57:57 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5440e98616cso1536740a12.0;
        Sat, 10 Jun 2023 19:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686452277; x=1689044277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOnAmvU8+4Mt3WlYCWLk9hDRAGAvBO+7sKgKdTa30LY=;
        b=pBertmk0B/XJ9jQzxBAA1xZ5HWTElIvwUMWLmURRVUhjfWyUOw9VUuAcv8402XYSDc
         isMKiKPzQrQgk8fYqTShNMLpIvhikIlG/Gi8IabL1ysy+HZbfQUpLqtRyyMY7+QEtilP
         DX7/TW4JfK5hWB/2VoXJcrAW9m9Hf+1SAD0Wi3364o/5yTlM99Ebx+DTh0rGnrgYczJj
         /wTaCtZiIdAI03kJPpZ5nb+54Z5rt2kHdEeSOq34fxlx6+5Il0sLOzMUyY281pyEZ9qx
         pz/VEqWOZRpHGYCUoxzbN64+RDZJ6BP8p2ZWtimYHxEpbYYp0IJs6g7HHNFaE1teQ5/N
         Adwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686452277; x=1689044277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hOnAmvU8+4Mt3WlYCWLk9hDRAGAvBO+7sKgKdTa30LY=;
        b=DCg+ytCi51ZQ8sCit0PSvMO2hl98utHvOInjcMWvHWtXmHgWArStSDOVfBMDvpHlgL
         Yp4bfcxkxNsf+Yqf5DmwWLoaPEGl8+Ngkaob24OQglgAnHbGT4rp/Dh1z4h+Bf7FiMr0
         BTAqnb+UMhiZ4CAVYEGjVRvrK9a1pAamOtOiMAZLNDbau0olEBpZrFYhg7xpv2w5pSI/
         QvI838Hw9OcNVndobjrh18Vl2m6SeUg55F1dxlYtL+SpG+OTnweQksDyl/FOsTxGHNRM
         Lpnlih8U62fGxsMhdjgXOHN41M0Yzln3Ts7+ia0+qM2ovXLMiLuScBkkrozEnmLfEvm0
         qkxg==
X-Gm-Message-State: AC+VfDx7KXamHNo37ETeH4ZvcrVGFVCmCGaXTz1zsdGzeobI1RlNXpoP
        pnUX9UNDUVlIEMN/LIF8NpU=
X-Google-Smtp-Source: ACHHUZ44wsG33yViyiNSyTl7sIIvmapE5+pTU4YbCYIwBRvUmxOxYoXdE6VAuh5ryFbTuTAlat6fJQ==
X-Received: by 2002:a17:90b:4b46:b0:259:a603:936e with SMTP id mi6-20020a17090b4b4600b00259a603936emr10858227pjb.8.1686452277191;
        Sat, 10 Jun 2023 19:57:57 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id l7-20020a17090a150700b0025621aa4c6bsm1530319pja.25.2023.06.10.19.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 19:57:56 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Thomas.Kopp@microchip.com
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org,
        marex@denx.de, Simon Horman <simon.horman@corigine.com>,
        linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v5 1/3] can: length: fix bitstuffing count
Date:   Sun, 11 Jun 2023 11:57:26 +0900
Message-Id: <20230611025728.450837-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230611025728.450837-1-mailhol.vincent@wanadoo.fr>
References: <20230507155506.3179711-1-mailhol.vincent@wanadoo.fr>
 <20230611025728.450837-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The Stuff Bit Count is always coded on 4 bits [1]. Update the Stuff
Bit Count size accordingly.

In addition, the CRC fields of CAN FD Frames contain stuff bits at
fixed positions called fixed stuff bits [2]. The CRC field starts with
a fixed stuff bit and then has another fixed stuff bit after each
fourth bit [2], which allows us to derive this formula:

  FSB count = 1 + round_down(len(CRC field)/4)

The length of the CRC field is [1]:

  len(CRC field) = len(Stuff Bit Count) + len(CRC)
                 = 4 + len(CRC)

with len(CRC) either 17 or 21 bits depending of the payload length.

In conclusion, for CRC17:

  FSB count = 1 + round_down((4 + 17)/4)
            = 6

and for CRC 21:

  FSB count = 1 + round_down((4 + 21)/4)
            = 7

Add a Fixed Stuff bits (FSB) field with above values and update
CANFD_FRAME_OVERHEAD_SFF and CANFD_FRAME_OVERHEAD_EFF accordingly.

[1] ISO 11898-1:2015 section 10.4.2.6 "CRC field":

  The CRC field shall contain the CRC sequence followed by a recessive
  CRC delimiter. For FD Frames, the CRC field shall also contain the
  stuff count.

  Stuff count

  If FD Frames, the stuff count shall be at the beginning of the CRC
  field. It shall consist of the stuff bit count modulo 8 in a 3-bit
  gray code followed by a parity bit [...]

[2] ISO 11898-1:2015 paragraph 10.5 "Frame coding":

  In the CRC field of FD Frames, the stuff bits shall be inserted at
  fixed positions; they are called fixed stuff bits. There shall be a
  fixed stuff bit before the first bit of the stuff count, even if the
  last bits of the preceding field are a sequence of five consecutive
  bits of identical value, there shall be only the fixed stuff bit,
  there shall not be two consecutive stuff bits. A further fixed stuff
  bit shall be inserted after each fourth bit of the CRC field [...]

Fixes: 85d99c3e2a13 ("can: length: can_skb_get_frame_len(): introduce function to get data length of frame in data link layer")
Suggested-by: Thomas Kopp <Thomas.Kopp@microchip.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Thomas Kopp <Thomas.Kopp@microchip.com>
---
 include/linux/can/length.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/can/length.h b/include/linux/can/length.h
index 69336549d24f..b8c12c83bc51 100644
--- a/include/linux/can/length.h
+++ b/include/linux/can/length.h
@@ -72,17 +72,18 @@
  * Error Status Indicator (ESI)		1
  * Data length code (DLC)		4
  * Data field				0...512
- * Stuff Bit Count (SBC)		0...16: 4 20...64:5
+ * Stuff Bit Count (SBC)		4
  * CRC					0...16: 17 20...64:21
  * CRC delimiter (CD)			1
+ * Fixed Stuff bits (FSB)		0...16: 6 20...64:7
  * ACK slot (AS)			1
  * ACK delimiter (AD)			1
  * End-of-frame (EOF)			7
  * Inter frame spacing			3
  *
- * assuming CRC21, rounded up and ignoring bitstuffing
+ * assuming CRC21, rounded up and ignoring dynamic bitstuffing
  */
-#define CANFD_FRAME_OVERHEAD_SFF DIV_ROUND_UP(61, 8)
+#define CANFD_FRAME_OVERHEAD_SFF DIV_ROUND_UP(67, 8)
 
 /*
  * Size of a CAN-FD Extended Frame
@@ -101,17 +102,18 @@
  * Error Status Indicator (ESI)		1
  * Data length code (DLC)		4
  * Data field				0...512
- * Stuff Bit Count (SBC)		0...16: 4 20...64:5
+ * Stuff Bit Count (SBC)		4
  * CRC					0...16: 17 20...64:21
  * CRC delimiter (CD)			1
+ * Fixed Stuff bits (FSB)		0...16: 6 20...64:7
  * ACK slot (AS)			1
  * ACK delimiter (AD)			1
  * End-of-frame (EOF)			7
  * Inter frame spacing			3
  *
- * assuming CRC21, rounded up and ignoring bitstuffing
+ * assuming CRC21, rounded up and ignoring dynamic bitstuffing
  */
-#define CANFD_FRAME_OVERHEAD_EFF DIV_ROUND_UP(80, 8)
+#define CANFD_FRAME_OVERHEAD_EFF DIV_ROUND_UP(86, 8)
 
 /*
  * Maximum size of a Classical CAN frame
-- 
2.39.3

