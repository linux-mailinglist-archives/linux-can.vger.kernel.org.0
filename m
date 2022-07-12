Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3CE571F4E
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 17:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiGLPcn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 11:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbiGLPcl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 11:32:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964A0A2ED5
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso8420445pjk.3
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ssHG4Vaz7n8X7oMmpB21PsGGhfBPihrbDDQ7KUl9GNE=;
        b=VOa8OaluDkV9z4U/sruWoiKKBspObyv4r4ajWfpGhCaAyt4eJ+EYLHj/btpYbHOuWK
         OkZlUfk+aUDI/miXCGDqmAX8iK3kgGsjHgQZSHC9iy0RQZcvLShkO+cvEs9ydXXfr9FZ
         buRwQLGPGwGJ2diAWliF5gKZiBTf4P8I5DagE835rbZKA5K/Gs8GF9dCuWPbGhLItkNI
         hW55aGFDTsRRXX0EbCBFXhRZu4UJLZfZRUdc/1CNI6P5C4UtH3buMOF2hPb5DxNiHXir
         lHfePAPLnnZn4K0fmhPrcrsbN3nh/eKXMHM5t/E7z628P0gv8kK8OYQcPK2FlzZ0jmnt
         HVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ssHG4Vaz7n8X7oMmpB21PsGGhfBPihrbDDQ7KUl9GNE=;
        b=a74RDUHGGT1G+cHwRYds8alf7twCuqWld037AbNNUmbYWU1/r1YJ6u/zu0p2WDk4e3
         ahaeWgfbsNPXKf5EidYziTenr32Eo8Hd+kNvM6crEtImasdsi0nSmpxDeUbzf2FE228V
         XPPnXLpcRUhEH9jofC505ua01eReNnoFmquVwv4Ds97lx788/ljC5CyE/kyLhCgKTI0e
         aMsUx2ShBbqVQJZxxMPJyjDdkiLDpqpCYpFmctsrZ3vvNez8rEFwyC/11zymVj5YEl3L
         eQA3ERijIjFd7S0eTfICbhOiCV41kQmd2cRUM5eXgN5EMmvIYVDuqil9zpiS3tZYC9+K
         o/6A==
X-Gm-Message-State: AJIora+B53oTOySsqwDC6besBr7wH1Q8DP2l4p/sPnBuU88u3BRGghUP
        E37ztJ7UGrW+498ai1jH5nw0DxAh+3OI5A==
X-Google-Smtp-Source: AGRyM1vPhQsFv1IXlRM7ZV/9Dr/oa1mxr44VsQkeNM5ZUsF5vLcQLoovbTVX4HR7z2En/px7biIzEw==
X-Received: by 2002:a17:90a:d50d:b0:1ef:9130:f96b with SMTP id t13-20020a17090ad50d00b001ef9130f96bmr4906771pju.235.1657639959886;
        Tue, 12 Jul 2022 08:32:39 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id c131-20020a621c89000000b005252defb016sm6891483pfc.122.2022.07.12.08.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:32:39 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 10/12] can: error: specify the values of data[5..7] of CAN error frames
Date:   Wed, 13 Jul 2022 00:31:55 +0900
Message-Id: <20220712153157.83847-11-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
References: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
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
index 34633283de64..4eb7da568dde 100644
--- a/include/uapi/linux/can/error.h
+++ b/include/uapi/linux/can/error.h
@@ -120,6 +120,9 @@
 #define CAN_ERR_TRX_CANL_SHORT_TO_GND  0x70 /* 0111 0000 */
 #define CAN_ERR_TRX_CANL_SHORT_TO_CANH 0x80 /* 1000 0000 */
 
-/* controller specific additional information / data[5..7] */
+/* data[5] is reserved (do not use) */
+
+/* TX error counter / data[6] */
+/* TX error counter / data[7] */
 
 #endif /* _UAPI_CAN_ERROR_H */
-- 
2.35.1

