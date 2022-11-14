Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817596285A3
	for <lists+linux-can@lfdr.de>; Mon, 14 Nov 2022 17:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbiKNQku (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Nov 2022 11:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiKNQk0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Nov 2022 11:40:26 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463E05FBF
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 08:39:12 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso11172484pjc.5
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2022 08:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXieDvxLbKVIEy8JEg2op3nuKVuDoBrrUyBYpSdpHg0=;
        b=RI8J7ixeldcjZkluicVsuQLw1KHIVlklJS9P/UPsW6ZZanydfwMlyPTGSryxrB646A
         U+um1duxZO/C5E3rGEod81EryX8wXDILfvuR6oEIj1I3ILrg+bisSu7OhrzHyfKcZMvc
         lEnwu764SCY2OvtQQwwehaEQNR6SnfoN+y4t/DAhNkkiusDffXmwsRXT9Y8W/mNpq74f
         jhDvJlw7qWGG6V27IhZBu8pftzXd+apSoYBwVUHBOJu5nHbCZ09c3hiQVYI9eHt8hjL8
         1jxzpDvCQOWmKuubnDrSWR+kwWeoFg3eMYoIymlmX+lEo8eUJNMX78X8HylBqwwk8g39
         6hpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KXieDvxLbKVIEy8JEg2op3nuKVuDoBrrUyBYpSdpHg0=;
        b=8JynMuAzAYMhXoX7Y12fPpxaxYDJDnNqer9EWcgegr5uyznLM+44in8rFa3XItNd2j
         X1JmvVT5fMsumWqzawP5acF8VJg0zLLP2Nu8ms3WG/zYFXHtPONFQKm6gHX46yEfoUOY
         lcEH+ErIfzPtRQTYCkGT8LGs+gvX2fC98x9ceXdoUD6D2HY2v8bTEZYbqDOhniYvZ5pI
         0W7cg54/a3R5yitMRZRQKEQYQjRHW3vjBtzZeHWCq+olO1Nng5lphN1mE/0aN92X3YuU
         x3f0cT4mhCi7mwQJQzPbi1/misdl1xEdEKno2cJierCM2zxhpdu5ECq0KZXkEDKGU/1h
         gVUQ==
X-Gm-Message-State: ANoB5pmESfRwm4+v3XMEuJYVSfRw3m3mBoz9dlXk30b2//dREFrADipA
        uuhsfN14JJ3l3zCxFF8KrJgQWqu8HjprBw==
X-Google-Smtp-Source: AA0mqf508Gb2me4UQjXs9laa8KLNXcRNrTgu1ykGGFpMPUmdMttMKXPC8xyb8MlERahNdaEtA0tMrQ==
X-Received: by 2002:a17:90b:35d1:b0:213:c06e:348f with SMTP id nb17-20020a17090b35d100b00213c06e348fmr14498930pjb.5.1668443951477;
        Mon, 14 Nov 2022 08:39:11 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id g190-20020a6252c7000000b0057255b82bd1sm807183pfb.217.2022.11.14.08.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:39:11 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev v3 3/6] lib: snprintf_can_error_frame: print counter errors if CAN_ERR_CNT is set
Date:   Tue, 15 Nov 2022 01:38:45 +0900
Message-Id: <20221114163848.3398-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221114163848.3398-1-mailhol.vincent@wanadoo.fr>
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
 <20221114163848.3398-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since version 6.0.0 (specifically [1]), the kernel has a new flag:
CAN_ERR_CNT to notify whether or not the error counter is set. Use
this to decide whether on not the error-counter-tx-rx should be
printed.

This way, when a driver set data[6] and data[7] to zero, it is
possible to differentiate whether the error counter is not available
or if the drivers simply reported both counters to be zero.

For interoperability reasons, continue to check data[6] and data[7]
against zero so that the code still works with the old behavior if
run on a kernel version lower than 6.0.0.

[1] commit 3e5c291c7942 ("can: add CAN_ERR_CNT flag to notify
    availability of error counter")
Link: https://git.kernel.org/torvalds/linux/c/3e5c291c7942

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index 3c1a0d9..0f9b510 100644
--- a/lib.c
+++ b/lib.c
@@ -679,7 +679,7 @@ void snprintf_can_error_frame(char *buf, size_t len, const struct canfd_frame *c
 		}
 	}
 
-	if (cf->data[6] || cf->data[7]) {
+	if (cf->can_id & CAN_ERR_CNT || cf->data[6] || cf->data[7]) {
 		n += snprintf(buf + n, len - n, "%s", sep);
 		n += snprintf(buf + n, len - n, "error-counter-tx-rx{{%d}{%d}}",
 			      cf->data[6], cf->data[7]);
-- 
2.37.4

