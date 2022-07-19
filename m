Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433FF57A1FB
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 16:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbiGSOky (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 10:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238914AbiGSOkU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 10:40:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D60D64D3
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gn24so594923pjb.3
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MFpGkGr2auIG1rBVBVgZiKNGxuZfm9Pu5f2JI5P807c=;
        b=QgkFscJZjds8n9Y/x5+OuKnV+9c89LgdBsvHv+R9c5sSVT9hgirAsY1W84Dn/QcIwy
         bf8NzGwK3u/RB6bCmTqAHxn0uERSvVb0cPyiFandSgVF3N+zV1yIguw4rrRNV27bg6w+
         L1iS5BrjtBuL7qGRWLxR36li9RsHNP6oNa6gOVxoJUdp4+BfPGveY/3p3W9B3G2vhjoi
         sE3HPiuwfa9Q88vNX1+h6uBLbDmLMKPy4A3LkLGGHQ9YSKCJ9+pYV/o3inalnXeIwQBx
         M6NnA2dX7qMhVVSyrzSMRnXRTsXRw52/18MNhXNSdrxFZf2D7i+fubQcy3aD1IOLcNuf
         ppxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MFpGkGr2auIG1rBVBVgZiKNGxuZfm9Pu5f2JI5P807c=;
        b=4VHgsKF4tDIDhzdhd2DsCf7ZCC/Aa3+h97Dl0ZwGdvEEh+Z+NMf/vTZEus2+7lJkV2
         4ylzBABasDet/i88LH0U43wk11JSnco83UgLBEmV2KWU8ApbcGqvWorCztLXOtIVa0kV
         6PScErIRJbHRoIaXT/6uhH1FnCkwr7xphhM+GMAm3Iqrq25wLBlnLZqKqdrWO+nQjHAv
         Zk9q1ed2cFK5gQ6usf8AU6oK4YX77IYAFf/bUjSR9k5nIAVrxfzKR0/dBZvjyevjclrP
         YzEHFD/3RPiHNvwyjECiFELYjmkxmu5Wy175yL74hd67aQYYKIWjhQv0WQ12Bc3mdFJQ
         pgJg==
X-Gm-Message-State: AJIora/J5oVnqyKhUDj1btb8+2znmOykrEAIBO+iC7GpnWXCB6+bFc5s
        1YOHu/2cIpEsHP9VsCk5zjYg1T88QiE7tQ==
X-Google-Smtp-Source: AGRyM1u/EZt23fi+/LqMtSTjVNO8EPk2a4jkiIc6Wsa2MzzN3RviAIoy5+Wquwl0RhE8fiCrYETqog==
X-Received: by 2002:a17:90b:1b0c:b0:1f0:1c:1f8a with SMTP id nu12-20020a17090b1b0c00b001f0001c1f8amr38750315pjb.77.1658241381417;
        Tue, 19 Jul 2022 07:36:21 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d75-20020a621d4e000000b0052896629f66sm11562516pfd.208.2022.07.19.07.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:36:20 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 10/12] can: error: specify the values of data[5..7] of CAN error frames
Date:   Tue, 19 Jul 2022 23:35:48 +0900
Message-Id: <20220719143550.3681-11-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220719143550.3681-1-mailhol.vincent@wanadoo.fr>
References: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
 <20220719143550.3681-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Currently, data[5..7] of struct can_frame, when used as a CAN error
frame, are defined as being "controller specific". Device specific
behaviours are problematic because it prevents someone from writing
code which is portable between devices.

As a matter of fact, data[5] is never used, data[6] is always used to
report TX error counter and data[7] is always used to report RX error
counter. can-utils also relies on this.

This patch updates the comment in the uapi header to specify that
data[5] is reserved (and thus should not be used) and that data[6..7]
are used for error counters.

Fixes: 0d66548a10cb ("[CAN]: Add PF_CAN core module")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/uapi/linux/can/error.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/can/error.h b/include/uapi/linux/can/error.h
index 34633283de64..a1000cb63063 100644
--- a/include/uapi/linux/can/error.h
+++ b/include/uapi/linux/can/error.h
@@ -120,6 +120,9 @@
 #define CAN_ERR_TRX_CANL_SHORT_TO_GND  0x70 /* 0111 0000 */
 #define CAN_ERR_TRX_CANL_SHORT_TO_CANH 0x80 /* 1000 0000 */
 
-/* controller specific additional information / data[5..7] */
+/* data[5] is reserved (do not use) */
+
+/* TX error counter / data[6] */
+/* RX error counter / data[7] */
 
 #endif /* _UAPI_CAN_ERROR_H */
-- 
2.35.1

