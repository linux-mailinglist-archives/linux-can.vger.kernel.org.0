Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663E67A15B5
	for <lists+linux-can@lfdr.de>; Fri, 15 Sep 2023 07:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjIOFsh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Sep 2023 01:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjIOFsh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Sep 2023 01:48:37 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF032735
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2023 22:48:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5776089b652so1334182a12.2
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2023 22:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694756901; x=1695361701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMAhmldfmhGPb/gMVNzcJh3soN86DYo+XXKXAGYHtgA=;
        b=DsZEqNzmH8ANxEGYim2vJVtRBVzCUClKe8sC5gMa+Bi6/ISNUjYPPgja++9FlchqYK
         eoDVilwSQ1ld4Zv4wkP4WFtybaiQNFa/FxR/9uV1N/WQBSiH3W1ZPp8MMmNJweqZhRjx
         t27rVIkryS++DRofXWUv1AH7ZbLJWO1frpbMfOz+15T65jVu/DR+pX0j+WmFG51NFSU7
         0aY5hCnXCZPvRaqd8r+meCVLHgUaWObT3Emhi7a3wZDO2D746z/nRXxzVWI2bJi689/B
         NkJ8ZuA2BDN4eA11YvlVV+tqp57ofTqIFJncmsQTGikBvY4tG17ECTzqCFTdObcp8wzO
         MnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694756901; x=1695361701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FMAhmldfmhGPb/gMVNzcJh3soN86DYo+XXKXAGYHtgA=;
        b=NLVTg46kuxrH2jr36jDSNE+O1pB6vU95r21FM24bPr6COqVuuKixDVdxAcez27PUtE
         noWJ+foYMn0KiAKsey/0lu5D9ABJw4INqI1EIwJg61YkqscNDuh+afgZ7VVZmPCf8/tZ
         AN/DHj06QSbxHi1GUGN0D0yd8r7nuIH3dwz5U/Klt0vuxhW+CW1DC8mE1SeEPY8UxLDR
         unN8spc6W+/5WKSKLxIJfigCtSlBqjCvCUgTAYVfjmOewWjWWbcNP7LjPbU2ukLZHvPd
         bZ3zBxYpm9gFez/UD78bYo8TkS43hWBRfF/NuA7tW1pEb6ok9HUrJ/6it6Ff6UaKhQl6
         FwmQ==
X-Gm-Message-State: AOJu0YwQ/Md8wCNbOBlWasmSwm0Ax8eeXE7mBNqvtsi0JKc6i3OhVTcH
        pmrxCTvj7pNYWkEjXF3d4C2kWXeg4kE=
X-Google-Smtp-Source: AGHT+IFzypvIE3npjHZM5eyW6d7Qt0Om/8D83S1Ir84Wh3lWu4NDVLETWru/eKgpVat9fApYmuzYNw==
X-Received: by 2002:a05:6a21:33a4:b0:158:f65:12d5 with SMTP id yy36-20020a056a2133a400b001580f6512d5mr945577pzb.43.1694756900810;
        Thu, 14 Sep 2023 22:48:20 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78d43000000b0068c62a45be6sm2268742pfe.179.2023.09.14.22.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 22:48:20 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 0/2] can: etas_es58x: clean-up of new GCC W=1 and old checkpath warnings
Date:   Fri, 15 Sep 2023 14:48:13 +0900
Message-Id: <20230915054815.3130251-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230914112954.3067242-1-mailhol.vincent@wanadoo.fr>
References: <20230914112954.3067242-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The kernel recently added new warnings, one of which triggers a known
false positive on the etas_es58x module. In an effort to keep
es58x_etas free of any W=1 and W=2 (excluding those produced by
foreign headers), add a workaround to silence it.

While at it, this series also fix a checkpatch warning which I knew
existed for a long time but was too lazy to tackle.

* Changelog *

v1 -> v2:

  * v1 had two different check logics for the version numbers:

    - check that none of the sub-version number are zero to make sure
      the parsing succeeded  
    - check that all of the sub-version number fit the expected digit
      range to please GCC.

    v2 simplifies things by merging those two logics together.

Vincent Mailhol (2):
  can: etas_es58x: rework the version check logic to silence
    -Wformat-truncation
  can: etas_es58x: add missing a blank line after declaration

 drivers/net/can/usb/etas_es58x/es58x_core.c   |  1 +
 drivers/net/can/usb/etas_es58x/es58x_core.h   |  6 +-
 .../net/can/usb/etas_es58x/es58x_devlink.c    | 61 +++++++++++++------
 3 files changed, 46 insertions(+), 22 deletions(-)

-- 
2.25.1

