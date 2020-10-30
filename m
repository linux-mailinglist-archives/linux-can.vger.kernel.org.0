Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305322A10D6
	for <lists+linux-can@lfdr.de>; Fri, 30 Oct 2020 23:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgJ3W3z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 30 Oct 2020 18:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3W3y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 30 Oct 2020 18:29:54 -0400
Received: from relay.felk.cvut.cz (relay.felk.cvut.cz [IPv6:2001:718:2:1611:0:1:0:70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1109FC0613D5;
        Fri, 30 Oct 2020 15:29:53 -0700 (PDT)
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 09UMScWX034509;
        Fri, 30 Oct 2020 23:28:38 +0100 (CET)
        (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 09UMSb2c019342;
        Fri, 30 Oct 2020 23:28:37 +0100
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 09UMSbbs019341;
        Fri, 30 Oct 2020 23:28:37 +0100
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        David Miller <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        Carsten Emde <c.emde@osadl.org>, armbru@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>,
        Jaroslav Beran <jara.beran@gmail.com>,
        Petr Porazil <porazil@pikron.com>, Pavel Machek <pavel@ucw.cz>,
        Drew Fustini <pdp7pdp7@gmail.com>,
        Pavel Pisa <pisa@cmp.felk.cvut.cz>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/6] dt-bindings: vendor-prefix: add prefix for the Czech Technical University in Prague.
Date:   Fri, 30 Oct 2020 23:19:23 +0100
Message-Id: <daeb8efd6659ed06dab42a97ee565dafd9cdd21b.1604095004.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1604095004.git.pisa@cmp.felk.cvut.cz>
References: <cover.1604095004.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 09UMScWX034509
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-0.222, required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.28,
        SPF_HELO_NONE 0.00, SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1604701722.46487@DbyVbgSzNlwquvSI7NZPzw
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The Czech Technical University in Prague (CTU) is one of
the biggest and oldest (founded 1707) technical universities
in Europe. The abbreviation in Czech language is ČVUT according
to official name in Czech language

  České vysoké učení technické v Praze

The English translation

  The Czech Technical University in Prague

The university pages in English

  https://www.cvut.cz/en

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c5ec0a..dedb10f1b250 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -215,6 +215,8 @@ patternProperties:
     description: Hangzhou C-SKY Microsystems Co., Ltd
   "^csq,.*":
     description: Shenzen Chuangsiqi Technology Co.,Ltd.
+  "^ctu,.*":
+    description: Czech Technical University in Prague
   "^cubietech,.*":
     description: Cubietech, Ltd.
   "^cypress,.*":
-- 
2.20.1

