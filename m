Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89F44EF7A3
	for <lists+linux-can@lfdr.de>; Fri,  1 Apr 2022 18:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348872AbiDAQLj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 1 Apr 2022 12:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352394AbiDAQLF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 1 Apr 2022 12:11:05 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E156A6350F
        for <linux-can@vger.kernel.org>; Fri,  1 Apr 2022 08:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=dWSnXQ5mMCKCwuZZpGPs6juMNph
        4VlyXgoTGdS3oI2w=; b=aYmd5OlunqYkcbbxgcPCb5+ndp6xJjjfRtY9r+VAp7n
        0BsjEJlIdPXyaoRvvcJat8HmOz1CVXZDM5JK89A8PDQEZI7Cb8YJWF2fbeDUsLYn
        thSol/Vz58VeecoEjPD3TYNIPB3N5xcd0L4HxiuYQCrT7TbFFNSqCh/mAmzUqa30
        =
Received: (qmail 789075 invoked from network); 1 Apr 2022 17:37:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2022 17:37:46 +0200
X-UD-Smtp-Session: l3s3148p1@O4tnj5nbYKYgAQnoAGGbAFirbAEmXd1u
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-can@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] dt-bindings: can: renesas,rcar-canfd: Document r8a77961 support
Date:   Fri,  1 Apr 2022 17:37:43 +0200
Message-Id: <20220401153743.77871-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index f98c53dc1894..648740270731 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -23,6 +23,7 @@ properties:
               - renesas,r8a774e1-canfd     # RZ/G2H
               - renesas,r8a7795-canfd      # R-Car H3
               - renesas,r8a7796-canfd      # R-Car M3-W
+              - renesas,r8a77961-canfd     # R-Car M3-W+
               - renesas,r8a77965-canfd     # R-Car M3-N
               - renesas,r8a77970-canfd     # R-Car V3M
               - renesas,r8a77980-canfd     # R-Car V3H
-- 
2.30.2

