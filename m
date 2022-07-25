Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3249958000E
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbiGYNoM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiGYNoG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:44:06 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B52140B7
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:44:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y9so10445550pff.12
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfxpo7ISFpCldf2tvnUCktaXM4UACLSlVKJQGNwdCF4=;
        b=dIEuWD7MzyBvjISfyBPez9NI+6o87VUbW5tXbFbPf0EInXZyRHFCL9y+FHrb5+OCr2
         6od8xtxTm1cn8CzjWkiAnQBHpi1kmrtjAMT09C9UAvzr7ZnBAp48ke1Hhh/1A5AdZU06
         q6F0RrFldGSD/KRwmR9GHbcUW12h1BQxET4Xm0FLUFxHAwbQr9xWQaJg27a2ZxlMJsPX
         LXpJzl2fbDVlo5N6dEjQ8Aok6mxqY1SLiSonPclsLsSqlJENPGghJjNtm3SJRnZtxBdX
         R8FuIQOyiEI7ooyvYjt1EiIF5LpY9P+fMXCqcLrDIAu5SUv1Z7ysDxs3QYExxoNp2YFA
         Kxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=yfxpo7ISFpCldf2tvnUCktaXM4UACLSlVKJQGNwdCF4=;
        b=w2iH/eUehn1Y4e7SalDNycVtk4OnFNcQVjyVc/MCdaxw6P6A1shieNZhzFYi791i5B
         QZRYBOWtA193JffN0rwtLo9CTpvAzij9JHQJ938ZYZAKNqZmjW5upMNa3TzzHbZYl23P
         n6iDOW1Y5SeLA4ex9wllxPhmRwdIH4KFBE3qDJn2dDb1UgI4yQ0ahIxrUAub0V9XaeZg
         iana9gdfixUcbB2hZMJhW/I3hDINllkUJMOG7Ii2CJyWEVw3jR5iKSB+PWa7TgWKojhn
         M9q9Pt5gMoD+McJn+/8NuCGb07UAAW0YIHpXau2mJZod3RoKkErIPQDRG6QilBpX4Qx6
         g3Ng==
X-Gm-Message-State: AJIora+sEffoR1MRFJuuJrkucQ+9aF+QTQv7ar3bX0kzN8jMgtNNDiEh
        EahTGSh3yWBdZXEbzkJ41bVvrnnrBUk=
X-Google-Smtp-Source: AGRyM1u2e4Nh0d6MJ1mfSPFFgsR8FUE+QHc5UA3a1p/GPP4QMKJ8tiDjjAvT4QmIX4xdxt4AtIEx6Q==
X-Received: by 2002:a65:6a52:0:b0:41b:6cd:dfd3 with SMTP id o18-20020a656a52000000b0041b06cddfd3mr2501951pgu.545.1658756643933;
        Mon, 25 Jul 2022 06:44:03 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id v12-20020aa799cc000000b00528c149fe97sm9579795pfi.89.2022.07.25.06.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:44:03 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 0/4] can-round-trip-stats
Date:   Mon, 25 Jul 2022 22:43:41 +0900
Message-Id: <20220725134345.432367-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
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

This series applies to below branch of Marc's fork of can-utils:

https://github.com/marckleinebudde/can-utils/tree/can-roundtrip-stats

It does some cleanup on the can-round-trip-stats in a first time and
then add the support for hardware timestamps (including TX hardware
timestamps).

This series can be helpfull for those of you who want to test the
kernel patch series which I recently posted:
https://lore.kernel.org/linux-can/20220725133208.432176-1-mailhol.vincent@wanadoo.fr/T/

Vincent Mailhol (4):
  can-roundtrip-stats: add print_stats() and calc_and_print_stats()
  can-roundtrip-stats: remove needless else after continue
  can-roundtrip-stats: rewrite the logic of the main loop to make it
    more robust
  can-roundrip-stats: add hardware timestamps information

 can-roundtrip-stats.c | 237 +++++++++++++++++++++++++++++-------------
 1 file changed, 164 insertions(+), 73 deletions(-)

-- 
2.35.1

