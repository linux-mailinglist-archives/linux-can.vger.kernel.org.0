Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9302C580240
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbiGYPyP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiGYPyM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:54:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9386DF66
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:11 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c139so10827316pfc.2
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzgyOo7BH7tFdrdKL3b8igSvwmrl7qlaltWraaOdaBw=;
        b=QqdIHq2tZ5dAqBdFXPyjHom2tR+wFIt+Ira6vjy+n+7NPeRd+ZURP3pi9UduXSGV2h
         DD3CQuMOQUEqLzI8S9yGYWi+Z1Z3bmEKr1fO9cIikQYa78yvQZWGrChbRM7LMO4SCOMo
         JBrbKIrbDi9bGJWD36TY081Xn0LpoZtFYPZBjipq4Lu/bdlMTv/HL+kelWjplddf1VI9
         8C7TuSsh82QjTyxjidB62lnicri6GrNGxRbTCASEX9/QOAe3KCb08rcTCE2GDvQUV8hQ
         bY+lI0vS3OJAH9+KumsXXmcVETJpcO/VRrMb6qLk5S/M5IyHohIOSfRXoMWPjgxJQd/d
         GjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bzgyOo7BH7tFdrdKL3b8igSvwmrl7qlaltWraaOdaBw=;
        b=L6exlxmRybLEDlm3V6ZBClDXWfgrM2aTMKpYU860hHG3Z3Z++o/bGdamXd/3odoy95
         k33lSAb1E+lzYTVbT3Y4oABwdSQn+P9g6jwKDz8fx1EbfAWtk3YABL1QjhJsAWo4f2g3
         rBHj9MG0EgNneiwcxIh3fDcz1sPMNSk5+DBca32bKfpT8Ezo3MvCkoUoBMUDxpichLaX
         WbpUQVZA/J7Tr9VjvBORs+nhuIRDgJgrfdf5Qxi/ERgNiqcV8zLpxahSskKsoU6svb0U
         3FvJWr/VY1x/i4G7n6WCOyZniJ5y9eCcX3//mqY5mu59OlFkpmxAoHHJAiyrYGLW6Bjp
         d3Vw==
X-Gm-Message-State: AJIora/CMSJ0viMjgfNg8ZFi/bSvklAinmV97KRfBNkKlbVOessKMs6a
        Dsswy6LmpJm1Ydo0dI7aMOiZApCyp7Fzxw==
X-Google-Smtp-Source: AGRyM1tIyLi0h6CShq8jkWIqwRHiYb3L3CxNHcIhJnSr37Bn+Ozqz3k0lg0dHNDpxOsjehmgysCDvg==
X-Received: by 2002:a05:6a02:30d:b0:412:9de2:eb48 with SMTP id bn13-20020a056a02030d00b004129de2eb48mr11364356pgb.47.1658764450669;
        Mon, 25 Jul 2022 08:54:10 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0016d692ff95esm3511296plr.133.2022.07.25.08.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:54:10 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 01/14] can: can327: add software tx timestamps
Date:   Tue, 26 Jul 2022 00:53:41 +0900
Message-Id: <20220725155354.482986-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725155354.482986-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220725155354.482986-1-mailhol.vincent@wanadoo.fr>
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

TX timestamps were added to the can_put_echo_skb() function of can_dev
modules in [1]. However, can327 does not rely on that function and as
such does not offer TX timestamping.

Add a call to skb_tx_timestamp() in the can327_netdev_start_xmit()
function so that the module now supports TX software timestamps.

[1] commit 741b91f1b0ea ("can: dev: can_put_echo_skb(): add software
tx timestamps")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=741b91f1b0ea34f00f6a7d4539b767c409291fcf

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/can327.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 5da7778d92dc..88718d0cc569 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -836,6 +836,8 @@ static netdev_tx_t can327_netdev_start_xmit(struct sk_buff *skb,
 	dev->stats.tx_packets++;
 	dev->stats.tx_bytes += frame->can_id & CAN_RTR_FLAG ? 0 : frame->len;
 
+	skb_tx_timestamp(skb);
+
 out:
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
-- 
2.35.1

