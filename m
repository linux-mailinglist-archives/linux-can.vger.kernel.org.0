Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B422EE74C
	for <lists+linux-can@lfdr.de>; Thu,  7 Jan 2021 22:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbhAGVAK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 7 Jan 2021 16:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbhAGVAJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 7 Jan 2021 16:00:09 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C8C0612F4;
        Thu,  7 Jan 2021 12:59:29 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id p14so6759882qke.6;
        Thu, 07 Jan 2021 12:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nEfwopL7NpPolFEYELpz+EkzQcRyvHWwBEWEGTr7pOY=;
        b=SsImQMKdM74wq73O2vuQD2bnyE5eyy+b6w7qYMpaVt2YUmxHZAnBO6oYw0YIaoo2qR
         tzYa/ZxTWf4yomGC7qUJ3sTABGIX2BwLEAODFPEey9ZswllUC9SbyMXCZrSAL3/AgtTy
         yAeU1EORz24wBp00DfKFPb70uFXDgDm5hYM6tFCd5u8kYhEXnMdeF1kOpodUq1NHMse9
         9Mm08FmOq2sYU0MUxpKDtE/C8DSGxO5Ow6cUiipd1gA2ejJppLDZxIHGiYIgZtQe4IVf
         eAUEhd5JdoDHEc478tVSMVFVOLIWA/Z8IjqKk6dyhu2a0cnL3w0meB3+ObeAgZDdZY5n
         sEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nEfwopL7NpPolFEYELpz+EkzQcRyvHWwBEWEGTr7pOY=;
        b=mHb8mRXoo3hQvD+ShvtQnomMA3hl34a4zGJs/fCG+BhwXLk/MI8sN8KKgKVELFE8GH
         oJxqdoZva3sWHw8upheqy9sF9mkSJaxgYUOrKJ14VBinwcxVZMfaFXOChZ3xIM+H3cd/
         3TeY8QeP86ZZc5tnrR1t4C9cYla/8ZsksZE5EolC6EUo5WLa9YUNQ7SGLbP6l1j71VjU
         vtdEMPlRRDoC1NT/pmLNDHtQnQS5kV4gjkZ3XveYIeToSk1WyTH6X9VNpmrMjsYTeU/y
         xzPhYO0bNz0ECrhGi6Pltnv0ViyTFLSz2tibXJVx8p7mtWx+fNR5okHtHFfAwBSbFKAD
         5AcA==
X-Gm-Message-State: AOAM531YAOCI1vIHPefuhEAEnImhePtdH3eCuk3rCwRtreE4ooNUwzQc
        Jch5bSvEf3IgyCVa2xYfdC0=
X-Google-Smtp-Source: ABdhPJxfJGbJEj8qaX10SHPU7zJw+t+4bROcJSDUNHWpec71ztBgtrwpcRotHKxF3sN73VmEridwqA==
X-Received: by 2002:a05:620a:11ab:: with SMTP id c11mr864642qkk.282.1610053168329;
        Thu, 07 Jan 2021 12:59:28 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:a80::1001])
        by smtp.gmail.com with ESMTPSA id u5sm3939152qka.86.2021.01.07.12.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:59:27 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] dt-bindings: can: fsl,flexcan.yaml: introduce the stb-gpios property
Date:   Thu,  7 Jan 2021 17:59:14 -0300
Message-Id: <20210107205915.7602-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

It is very common to have an STB pin in CAN transceivers, which allows
putting the transceiver in standby or normal operation mode.

Add a new optional 'stb-gpios' property to describe this.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 0d2df30f19db..64f904c4b3d5 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -66,6 +66,9 @@ properties:
   xceiver-supply:
     description: Regulator that powers the CAN transceiver.
 
+  stb-gpios:
+    description: GPIO that controls the STB CAN transceiver pin.
+
   big-endian:
     $ref: /schemas/types.yaml#/definitions/flag
     description: |
-- 
2.17.1

