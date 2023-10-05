Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC20E7BA5DA
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240989AbjJEQUo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242488AbjJEQSH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:18:07 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB93C59F9
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 09:07:45 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-58916df84c8so751904a12.3
        for <linux-can@vger.kernel.org>; Thu, 05 Oct 2023 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696522065; x=1697126865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xgf2ElcyKKAfFPy3H78+MT0fFnWCMC74rDFLYV0KG9k=;
        b=f5VdUbArFo7hKbdRQFlu04P+hjjtsuO9RdyU5Val6AOm4iSb4q26rPt3144YATCyE0
         t1WVCrG3kQmOfJOuUrbuldZBizbnZmo0+Ma9Q1GZM3t827k1ILY/6qSHMpfV1Ug8WUd5
         UNp6YDkeuDFofSxz/lnxrpu2wA+XBOGk+4VrPDnjfc0FaFv+tDTC9Zh24MHA66mP1dkY
         eTvx8j6dwOGnpRpVKBoPsLJrHkt8kyIfoqNKXpcKp1UxPuH4JmBEIw4oB/0UIBqpa0+u
         gBcUgbIZDhLR5AAoehhc/dHTi4XtO8hbbUIHGvJ47bgimt47SEAEfwai6ls5ZRPqyMog
         8hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696522065; x=1697126865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xgf2ElcyKKAfFPy3H78+MT0fFnWCMC74rDFLYV0KG9k=;
        b=mQ871k53yc7yezROLsCHu5oSzFFrRG974j7sOKOLtQX2/Xtf6hk5KEXMTpH2FT3OH3
         AUXnEKSSJbY2q9zmU1nffk0n9elbMzi87Y/aE1pFjl+YWdj0r9DUKL++kUlTx01F2zwP
         W/sCPw05m81cHB2fdl5Wx56ir7GmTVoOwaFnYPprFxDNAbjAGVH/fwUu/ac2+tH++k/S
         u+cucDE/YPhfpdaMVSjJjbYIf7ooSO5gddxEtt/ur0IHLMCHWXzlIkrz2huKhrb5fJ6t
         H4XX43wQpE9lyFghIWshzCQqIa4V9J/p2R2uDZ6uDsrt296qzTwme8hedG9biJzREQmo
         TYxQ==
X-Gm-Message-State: AOJu0Ywv90c1SujnMm5P3kNLUh1Pv8I9sTDYLTbwRUsVLByrH2RBauTj
        qaeyk2v5Bp5wlhvrTPZNw5SdkeZqHgRYy5jaM62Sr7Nj19A=
X-Google-Smtp-Source: AGHT+IEFof3GjNUu8PoYJ1fm72LC731gZO/JgcjWsMyroYoTct8Pe9ftxqaRN2vOMtWR90dmDdSCeDr9PIWmWzPyzq4=
X-Received: by 2002:a17:90b:4f44:b0:26d:5cd0:979f with SMTP id
 pj4-20020a17090b4f4400b0026d5cd0979fmr5543553pjb.43.1696522064924; Thu, 05
 Oct 2023 09:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de>
In-Reply-To: <20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 6 Oct 2023 01:07:33 +0900
Message-ID: <CAMZ6Rq+QpPEoYp=Cis5a3fuFFZmRMjAZqNTJ2j-B3r4jdwNNhg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] can: dev: fix can_restart() and replace BUG_ON()
 by error handling
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu. 5 Oct. 2023 at 23:36, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> There are 2 BUG_ON() in the CAN dev helpers. During the update/test of
> the at91_can driver to rx-offload the one in can_restart() was
> triggered, due to a race condition in can_restart() and a hardware
> limitation of the at91_can IP core.
>
> This series fixes the race condition, replaces BUG_ON() with an error
> message, and does some cleanup. Finally, the BUG_ON() in
> can_put_echo_skb() is also replaced with error handling.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Notwithstanding of my nitpick on patch 4/5:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Side note, I did not received patch 1/5, 3/5 and 5/5 from this v2 and
I do not see them either on
https://lore.kernel.org/linux-can/20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de/T/#me6e1b1ced8ceca1a3bc27b9b36b582a286fd259a
Note sure if this is a send error on your end or some congestion on
the mailing list.
