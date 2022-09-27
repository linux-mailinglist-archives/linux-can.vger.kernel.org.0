Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEB15ECBBC
	for <lists+linux-can@lfdr.de>; Tue, 27 Sep 2022 19:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiI0RzM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Sep 2022 13:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiI0RzE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Sep 2022 13:55:04 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F99B7E3
        for <linux-can@vger.kernel.org>; Tue, 27 Sep 2022 10:55:02 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3450990b0aeso107457977b3.12
        for <linux-can@vger.kernel.org>; Tue, 27 Sep 2022 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tWpS4cEqVjCvAbrEpDrZ5jq3lmCtX8OGRlYF/P9XNV8=;
        b=aI81aKFW+4dgqcToZisPeA4jtrgtLI5hDy+Cm0Mwnw3Ejr8SR4V2xB/zjlqPLSLI2Q
         czwtAffY37UauybiIJFHhsz/Toihy02bT6l/NDNpcOrPHizj7QfEjRvtYM5GIhXfuqX7
         GCOZ+7yIYsMcp4/5JBvMq3XLkL6ChR0Q/HorJVS6N5ATSLg3tdHQyLFx0mEa7QvC5VoQ
         mQqawFfbMWUfJhyCjDqvj3AfkYWn72DQdJIGk0Pq3N8z5bGS3XbAEPubNAt4VLiwWiFC
         Fa4ckKxIoZLKNol9BC9Lo4/0gIu93WgzTQio99Bb6BY8IDW2G97+eEkk/w8o97vUwz1C
         gQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tWpS4cEqVjCvAbrEpDrZ5jq3lmCtX8OGRlYF/P9XNV8=;
        b=7dHqAwgO5D3DmyO972SFqFj9xTt9q4Wb4sW4yoi70CaKGmNn/BoDGtGhi2B6d/9iv9
         yMRjuxGP9LvIRohpwTfFSnapMD49nHGNCMcsVUuChzoMq5GCL3+Ssk9rXqZJ5XpvFJfE
         lZ8io4KYOl8iWb0WNwl1J1lZcBr5yI736zVCOGflcnRjzUxac2WmHcMWNgBkJx6aCkVV
         1wGoI9le5lfGQ4e7QJ7DyAP1PbEDUKg2DM7C7TNO6R4AXIP3K6KOBuDjTJjPFn1kjcaL
         5yjHbophEicY97VNOC16mfWmYJ4ZihHCSloesYxV6sptyKDXVDPEllCdfePCFlogM4jc
         7nLQ==
X-Gm-Message-State: ACrzQf0bIPms0DhxPvIeFZS1uu255naDFV5WyrdIcY7XRV07Nz18sJIr
        Nt4XV0pyZeYQPrO7Zpx66vzj47itAdgCj3fSbGlYJg==
X-Google-Smtp-Source: AMsMyM52wMIxhgYM5ELWXtaWymd9neNz5hZdppDIvfylJWmhZCtnT2YZ8QouamPa8ksX5z3a0GGPERJkDnkuiW0UTkU=
X-Received: by 2002:a81:98d:0:b0:352:b79c:4cc6 with SMTP id
 135-20020a81098d000000b00352b79c4cc6mr1557441ywj.467.1664301301055; Tue, 27
 Sep 2022 10:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220927132753.750069-1-kuba@kernel.org>
In-Reply-To: <20220927132753.750069-1-kuba@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 27 Sep 2022 10:54:49 -0700
Message-ID: <CANn89iL4m=aMjZ1XWFNWDyyyDBF1uhNocN0OFqhm2VMm_JQOog@mail.gmail.com>
Subject: Re: [PATCH net-next] net: drop the weight argument from netif_napi_add
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        kvalo@kernel.org, Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Sep 27, 2022 at 6:28 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> We tell driver developers to always pass NAPI_POLL_WEIGHT
> as the weight to netif_napi_add(). This may be confusing
> to newcomers, drop the weight argument, those who really
> need to tweak the weight can use netif_napi_add_weight().
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Sure, but this kind of patch makes backports harder.
Not sure how confused are newcomers about this NAPI_POLL_WEIGHT....
