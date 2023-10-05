Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7DF7B9912
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 02:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbjJEAFp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 20:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbjJEAFo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 20:05:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F0ECE
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 17:05:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a1d352a86dso5269197b3.0
        for <linux-can@vger.kernel.org>; Wed, 04 Oct 2023 17:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696464339; x=1697069139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kDV9H2uqIJhr2H0MOz02/qFIRGm8ZuULD9yNay+8KCk=;
        b=K02LwLZc/Smk0mQ3VBoQ78isLxECitC5Vg1GfKQCmUOBsHVwhyu91I3xP2xKgA8nWl
         CnX1iJnJrwZ7KrrEGxqlP92wWGiAiPhfniOSbUneU2YXRa7KPaJDNUlnGFgI8PizHRAX
         p2OgXY8px0NT3V1hLj/ABoeKF1tB5dis+bgxVw0InN4z9UjJuyMd+rPf4fn3sSE2IBBH
         5mU2Q5tgptwk+smA7bxPCOQepKL0vUpiQ2eln94WaXK/SSf93WvWNlZGPK27FB8nNIUN
         6flZmVKfvMnGXBJkJVyIGntT/Bsw1Op++gCOcTro0LRWAuJ7VHFrhuEITcQ1EXoHpR67
         dZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696464339; x=1697069139;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kDV9H2uqIJhr2H0MOz02/qFIRGm8ZuULD9yNay+8KCk=;
        b=a7LTYgdyY4DfWZ1sEa2r1z69Uhlg0hIKLFp/4WAZ+G91CV+VoFW2fuIgghCwh2DEgY
         WxEAFq0kS+iyK/wrQvRFmiN2FGu6l6GywnKxEOd6k1YfLhgFoboIsYP2q3S0bzmRxDM8
         jyzy1OVaU50g513NFeYfw/Jsu5j+/PF/UZSp9BP59vM7zAOPgjd1SgAVpEMisxNgjKTS
         Ci65chgaH6b4v/l/dpQIB8GosRsvmsqJdNCqtFVo0qnmzUK+F+hei63LYhBWb6rpDS2z
         QwAVS2WXXGG2LgmdDFlK0g9jrV1t30sgyK5uU1IAi8uiewCTh4pYCd0uTqD+vgxF1F9C
         hcwQ==
X-Gm-Message-State: AOJu0YxSGkBBLXgqyXRVugOCOyJnz1o77gBgvObU1Eef77HuhheQSuhp
        5Qw5eMQLIBNQXCMnH1SLAxbJLNloO52tvE9QNw==
X-Google-Smtp-Source: AGHT+IGTiXwbNXO7t2kuJzI5viQlgrAq3e1RhUIhpSHCpv6OU7nkZ+Yipbuymx3X62nCckzHZkW3q0ytTz4SHMFoxg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:85:b0:d86:5644:5d12 with SMTP
 id h5-20020a056902008500b00d8656445d12mr65620ybs.4.1696464338892; Wed, 04 Oct
 2023 17:05:38 -0700 (PDT)
Date:   Thu, 05 Oct 2023 00:05:35 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAM79HWUC/x2NUQrCMBAFr1L224U0qaBeRUTi9qmrEMNuKUrp3
 Q39HAZmFnKYwunULWSY1fVTGvS7juSZywOsY2OKIaY+hIF9siL1x6PpDHMumFhyYX/l5gNX5Pe 1irLwUSL2SPGGQ6IWrIa7frfZ+bKuf7wKd7p8AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696464338; l=1704;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=apMk3PAp7wXCg1G7f65LzqlG2jyMKCWZrLKd+QMkLV0=; b=KC7laJ0xXFcTNOKm5F+aafeyNRacesWewOUckhjMrjqfd5s8iINWyi0XoECH8dh8asYPWgvfu
 BkhfjUaE7GHDyMxgXBmMJY/o+OV6NUTP4UvGyJ2uJ8NkWTata7w8+5A
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-can-sja1000-peak_pci-c-v1-1-c36e1702cd56@google.com>
Subject: [PATCH] can: peak_pci: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

NUL-padding is not required since card is already zero-initialized:
|       card = kzalloc(sizeof(*card), GFP_KERNEL);

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/can/sja1000/peak_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 84f34020aafb..da396d641e24 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -462,7 +462,7 @@ static int peak_pciec_probe(struct pci_dev *pdev, struct net_device *dev)
 		card->led_chip.owner = THIS_MODULE;
 		card->led_chip.dev.parent = &pdev->dev;
 		card->led_chip.algo_data = &card->i2c_bit;
-		strncpy(card->led_chip.name, "peak_i2c",
+		strscpy(card->led_chip.name, "peak_i2c",
 			sizeof(card->led_chip.name));
 
 		card->i2c_bit = peak_pciec_i2c_bit_ops;

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231004-strncpy-drivers-net-can-sja1000-peak_pci-c-9c2e5e32be83

Best regards,
--
Justin Stitt <justinstitt@google.com>

