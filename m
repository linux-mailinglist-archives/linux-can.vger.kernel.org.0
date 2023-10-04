Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A94C7B7D78
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 12:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjJDKoc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 06:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjJDKob (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 06:44:31 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AA8A1
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 03:44:28 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6c67060fdfaso1365576a34.2
        for <linux-can@vger.kernel.org>; Wed, 04 Oct 2023 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696416268; x=1697021068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jMkN0ypp9ItNe9lJgTzN5f0pLKiSXjwTvNbrl5/EmoU=;
        b=Z9fSooVhQ5kIPNdhX4SS4d0+U2OskJYLdFsua5ZZBPDi4nOD3Wj3ITSLuwXo3JxkgR
         GkP43QCs8+UzG/pIjmmWSry1LaRC7rKao7Xod4ichBp3Th7B2iHOIlvCQj8ImM1w5E5C
         nSvbkxLVCO7SnmUbQ82rFGR0eJYrjTbxYOcqGb817q2eq/L/pT3tfGSR+hvwKHlsbZ1t
         Wh2mPn6Z9oXgjyPrFon1824pmtusMMG1evnKB0Y5StnM2LYnchxzaR0sPbAkvZGk2zBX
         cvCjXEmW+zZWQ+qecmwq+NkrzFrceLR3LPSM4p8I56BohXrabnQ3zgYm5FHy1JjQfa/V
         KpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696416268; x=1697021068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMkN0ypp9ItNe9lJgTzN5f0pLKiSXjwTvNbrl5/EmoU=;
        b=eOMK1kZaI/ePKq1Udmd7G5ra8JNrlZtRxkV1Rh9Ns+CEXMKY6vMopoGylKVZcTzX6z
         1eFSixzg40NfOlgrxvb/cSNS+Yi+daYVGlifZrLyZujVr9TBA+sBbyPY92+nDPcBqySF
         j+JBBXGsDiJ4PtfZnvKfHp0spJ9sQiq7IvnB8524Cv9QnyCH9Mft3rZCk/gpmXiCVKYb
         JTwApydg4KZwGTb3C7cnGVDA9DWrkD4eOossx9qXE0wKNQlnzAijalwX1bjil3Se03U0
         rdFVc+tAHFPphguCcisKQRj9opRKi0TgUb4eASQJzFwQDMos3H8BgYyWesRE54xvMYc/
         5UOw==
X-Gm-Message-State: AOJu0Yz3XKpA6tpHrf7qATNHV/VoNW+nDhylZl1Haa1xLIiZjs8OoyJn
        6WXkeyrkXutQr+pZCawiuzNEm919Sdr2zOi0xESKWEr+UF4=
X-Google-Smtp-Source: AGHT+IFE/2KVNYrQibebn+tHnBegw1hxkp+d+8NrSa7uBLnyDSYaGrAJzvR4i8Z25GgkkPv93BHTerZh2dNY0zEY7uM=
X-Received: by 2002:a05:6358:4298:b0:143:8af4:229e with SMTP id
 s24-20020a056358429800b001438af4229emr2006870rwc.9.1696416268159; Wed, 04 Oct
 2023 03:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-can-dev-fix-can-restart-v1-0-2e52899eaaf5@pengutronix.de>
 <20231004-can-dev-fix-can-restart-v1-4-2e52899eaaf5@pengutronix.de>
In-Reply-To: <20231004-can-dev-fix-can-restart-v1-4-2e52899eaaf5@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 4 Oct 2023 19:44:15 +0900
Message-ID: <CAMZ6Rq+=iaRCroX7kQT5f-+qq5iBv3kFX_sytV8BmF0BcrtX2g@mail.gmail.com>
Subject: Re: [PATCH 4/5] can: dev: can_restart(): update debug and error messages
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
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

On Wed. 4 Oct. 2023, 18:18, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Update the debug message from "restarted" to "Attempting restart", as
> it is actually printed _before_ restarting the CAN device, and that
> restart may fail.
>
> Also update the error message from printing the error number to
> printing symbolic error names.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/dev/dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 9014256c486a..8e4054e2abcc 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -147,14 +147,14 @@ static void can_restart(struct net_device *dev)
>                 netif_rx(skb);
>         }
>
> -       netdev_dbg(dev, "restarted\n");
> +       netdev_dbg(dev, "Attempting restart\n");
>         priv->can_stats.restarts++;
>
>         /* Now restart the device */
>         netif_carrier_on(dev);
>         err = priv->do_set_mode(dev, CAN_MODE_START);
>         if (err) {
> -               netdev_err(dev, "Error %d during restart", err);
> +               netdev_err(dev, "Restart failed, error %pe\n", ERR_PTR(err));
>                 netif_carrier_off(dev);
>         }


Nitpick: I would rather remove the first message and print the
affirmative: "restarted"

        if (err) {
                netdev_err(dev, "Restart failed, error %pe\n", ERR_PTR(err));
                netif_carrier_off(dev);
        } else {
                netdev_dbg(dev, "Restarted\n");
        }
