Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419CA6E58D8
	for <lists+linux-can@lfdr.de>; Tue, 18 Apr 2023 07:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDRF7Q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Apr 2023 01:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDRF7P (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Apr 2023 01:59:15 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FBE46A0
        for <linux-can@vger.kernel.org>; Mon, 17 Apr 2023 22:59:12 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4edb9039a4cso1869822e87.3
        for <linux-can@vger.kernel.org>; Mon, 17 Apr 2023 22:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681797551; x=1684389551;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQlu0Oc2Q0nPMBCNq5iTPUZpwrRZlsMdPt2zjra8+VI=;
        b=B/lJxYxd9QgPHdTz8Y94+SQwigHwPQz1MSY0HBGE49jeKpZvQ5ridodaJ1/hg5dYTg
         xfm1UctNbPOooHeryL4EpFSpzLbpfIM/1AP6IiE/eAQ2XC+jiAPE4sjVq/0OLp+s5H64
         OPszLw7mQaJ1PqKU00ScUiZOb3Ks0WeXpBGa5YCNLjOyLXsRt33eVOV3J7/7jSzM1Fi3
         /RpCf1VKsRTVD/tqHSDxBWAwYQ/D3zBjMwphUFrVmu8iFcvUlk1YDipJso9tURLsGQAs
         Kxkqmj8wx1BzA1Zw3ty0py3y/B5zl4OJTEDWjPXGFVRp+Onsg5ZfmKZ52/USaH6DILFS
         M1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681797551; x=1684389551;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQlu0Oc2Q0nPMBCNq5iTPUZpwrRZlsMdPt2zjra8+VI=;
        b=VusRUfPu7v9CY9wUCdlBDG9xB1PitMAUEJ3RH4Zs/lCEV1UhJX2Rw/+si+3w52li3k
         eubpiFIuznefoV9yTUqAhAxJAnDem2nUBYIp0xmjFuXai3XczLBsPZeKlj6c7WOzFA3U
         QcrHU4zk4zbsLClImMc5Gy0vDh/reSBLcdgQv9glwlO7dmziOIPKoQO9pzoCT4kl6HHL
         XwvPgHXmx3sZF7C2eULcUw8GweZaYD3Anti6FKmmbJ3bQQb8BO3HZVKIO1bOPZyHZsii
         xzYe2EAwXGYVfyJdI6upOXhoSvFGvJXDEg2MIqjf8ACaq6SUGVEpGQq9/VUnhTJhyY7Q
         3smQ==
X-Gm-Message-State: AAQBX9f2sFFTdZhOFZbTvGREBKedKwZHdJXYdz9KjNcS9Gii5z92zKnI
        6uTxpnuPk1Dnwe+10uR1xZlr44PNb+dBILji5Hc=
X-Google-Smtp-Source: AKy350YRsUSKQ0+i58Lzun7WtY7IrRwSkm+DWIi2JdfS71rVYYWUT2OQ/a/Q5PRWIBazn3AQLm2dWBYGVxBajLvvRoE=
X-Received: by 2002:a05:6512:96b:b0:4e8:4b7a:6b73 with SMTP id
 v11-20020a056512096b00b004e84b7a6b73mr2935594lft.4.1681797550844; Mon, 17 Apr
 2023 22:59:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab2:2681:0:b0:1b6:840f:9075 with HTTP; Mon, 17 Apr 2023
 22:59:10 -0700 (PDT)
Reply-To: mariamkouame.info@myself.com
From:   Mariam Kouame <mariamkouame1992@gmail.com>
Date:   Mon, 17 Apr 2023 22:59:10 -0700
Message-ID: <CADUz=agNY633M0qMXMnAP3Ms7-3rKuWtAZGCOQZKeYpCdBxT_w@mail.gmail.com>
Subject: from mariam kouame
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you. I am looking forward to hearing from you at your earliest
convenience.

Mrs. Mariam Kouame
