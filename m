Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A297AC7A7
	for <lists+linux-can@lfdr.de>; Sun, 24 Sep 2023 13:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjIXLJ2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 24 Sep 2023 07:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXLJ2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 24 Sep 2023 07:09:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A778483
        for <linux-can@vger.kernel.org>; Sun, 24 Sep 2023 04:09:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-27740ce6c76so168307a91.0
        for <linux-can@vger.kernel.org>; Sun, 24 Sep 2023 04:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695553761; x=1696158561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjW6jRzb6GVNpTGcorsaiMjTInAKWCAk9AxFnB99Nzc=;
        b=caqQGtYUB0GNRWlxMGRLpoSy/+sCLZTXG58ILkx0a7S2Z9qw1a+DSXJHhT6st6lE9O
         snebB507EL4oOvA3HX53pnYH1WSunhtU7ab9zybCbbmMNh9oj1E9HpLCveUtIGaG8/Dh
         hHGdMbOQnCb9IC0j7/ezmljkYvuqjMCEUrG/4pg6Z2TKEWtasoi1puZjdLXElFi4zx3B
         Emgo1+ogpvvHlpfANO4jC1Z2qUyiBPhNPqrRx0HhWJEPjeSANfRPVYFBjEsno7R/O04g
         YgTdP8CTFXbauDEcFKG8g/7/CZrgHbW8yPLXN0PB3A5wdK1Je6HmNJzU0y7ByPMewsas
         DmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695553761; x=1696158561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BjW6jRzb6GVNpTGcorsaiMjTInAKWCAk9AxFnB99Nzc=;
        b=MmXu4phDtognxrRkwgLMBt/Hv/tm6QYrmRk720UA+usl7kS2Au2zSeYcEDcnh/1NFX
         S/LWDG5zjONuAaqvbb+PHAiCV5rSW6v9a+E4E3+voera6gPU0jEVTJou3JuWXB/PpQiE
         3xYgcc9IJuNwppUEpkpkUkSSdHtog7nQTB43WekM3sTq5oOwsrplSUOIZipa0DcVM3Sk
         8mAwN7KTCOBTPEgX2AKPSX+GmVeW829vQ6pjdsRfpWcTIws8vGibG8d8bd7Ka2jdP3GT
         /Fqpd4CKWBuT0yLx+v9+xmDDtTu5xoAVaLntUUT6RpgEpVEQHyvVEN+1JL5pFh1xLCJ8
         seEw==
X-Gm-Message-State: AOJu0YwmBpmVtvNt21pGM9PYWrmeIYJl8d8dtYC2aa+7j9kGEmrzTef0
        ZNHO43uQMC84QbuhAQJWuY0DkmdbLaA=
X-Google-Smtp-Source: AGHT+IFjPFqna6cbE/1PEijyvQv1TcFJpYHjJ+q7YsvCUQR07v+5J5fhTUrTWEgDJdlbL6jaV+EnwQ==
X-Received: by 2002:a17:90b:30d4:b0:269:3771:7342 with SMTP id hi20-20020a17090b30d400b0026937717342mr2175092pjb.18.1695553761008;
        Sun, 24 Sep 2023 04:09:21 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id a13-20020a63704d000000b00578f1a71a91sm6074905pgn.79.2023.09.24.04.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 04:09:20 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 0/2] can: etas_es58x: clean-up of new GCC W=1 and old checkpath warnings
Date:   Sun, 24 Sep 2023 20:06:46 +0900
Message-ID: <20230924110914.183898-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914112954.3067242-1-mailhol.vincent@wanadoo.fr>
References: <20230914112954.3067242-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The kernel recently added new warnings, one of which triggers a known
false positive on the etas_es58x module. In an effort to keep
es58x_etas free of any W=12 (excluding those produced by foreign
headers), add a workaround to silence it.

While at it, this series also fix a checkpatch warning which I knew
existed for a long time but was too lazy to tackle.

* Changelog *

v2 -> v3:

  * if the parsing of one of the version/revision numbers fail,
    es58x_parse_product_info() immediately returns. If this occurs
    early, the other version/revision numbers would still be set to
    zero (which is now considered a valid version number). Set the
    version and revision to an invalid number before startnig the
    parsing so that everything is set even if an early return occurs.

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
 .../net/can/usb/etas_es58x/es58x_devlink.c    | 57 +++++++++++++------
 3 files changed, 43 insertions(+), 21 deletions(-)

-- 
2.41.0

